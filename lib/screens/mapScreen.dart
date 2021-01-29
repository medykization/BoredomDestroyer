import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  final Position placePosition;
  MapScreen(this.placePosition);

  @override
  _MapScreenState createState() => _MapScreenState(placePosition);
}

class _MapScreenState extends State<MapScreen> {
  _MapScreenState(this._endPosition) {
    _startPosition = Position(
        latitude: _endPosition.latitude, longitude: _endPosition.longitude);
  }
  Position _endPosition;
  Position _startPosition;

  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_startPosition.latitude, _startPosition.longitude),
        "origin", BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_endPosition.latitude, _endPosition.longitude),
        "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(_startPosition.latitude, _startPosition.longitude),
              zoom: 12),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_startPosition.latitude, _startPosition.longitude),
      PointLatLng(_endPosition.latitude, _endPosition.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
