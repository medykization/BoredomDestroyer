import 'package:google_maps_webservice/places.dart';

class Place {
  String id;
  String name;
  String distance;
  String icon;
  Location location;
  num rating;

  Place({this.id, this.name, this.location, this.icon, this.rating});
}
