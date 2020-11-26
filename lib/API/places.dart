import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:flutter_project/models/place.dart';

class PlacesApi {
  final GoogleMapsPlaces places =
      new GoogleMapsPlaces(apiKey: "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I");

  final GoogleDistanceMatrix matrix = new GoogleDistanceMatrix(
      apiKey: "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I");

  final photoLink =
      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=100&maxheight=100&photoreference=";

  Future<List<Place>> getNearbyPlaces(
      int radius, Location location, Set<String> preferences) async {
    //origin varible to distance request
    List<Location> origin = new List();
    origin.add(location);

    List<Place> resutls = new List();
    try {
      for (String val in preferences) {
        PlacesSearchResponse response = await places.searchNearbyWithRadius(
            location, radius,
            type: val, language: "pl");

        if (response.isOkay) {
          for (PlacesSearchResult next in response.results) {
            if (next.types.first == val) {
              String photo = photoLink +
                  next.photos.first.photoReference +
                  "&key=AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I";

              Place place = new Place(
                  name: next.name,
                  icon: photo,
                  location: next.geometry.location);

              //destination varible to distance request
              List<Location> destination = new List();
              destination.add(new Location(
                  next.geometry.location.lat, next.geometry.location.lng));

              place.distance = await _getDistanceData(origin, destination);
              resutls.add(place);
            }
          }
        }
      }
      return resutls;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> _getDistanceData(
      List<Location> origin, List<Location> destination) async {
    DistanceResponse response = await matrix.distanceWithLocation(
        origin, destination,
        travelMode: TravelMode.walking, unit: Unit.metric);

    if (response.isOkay) {
      return response.results.first.elements.last.distance.text;
    }
    return "N/D";
  }
}
