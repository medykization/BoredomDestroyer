import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool isRouteMapped = false;

  _MapScreenState(this._endPosition);
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
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // TO DO: BOTTOM BAR WITH PLACE NAME
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: isRouteMapped == false ? _buildSpinkit() : _buildMap(),
    );
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
    setState(() {
      isRouteMapped = true;
    });
  }

  _getPolyline() async {
    _getStartPosition().then((value) async {
      _addMarker(LatLng(_endPosition.latitude, _endPosition.longitude),
          "destination", BitmapDescriptor.defaultMarker);

      _addMarker(LatLng(_startPosition.latitude, _startPosition.longitude),
          "origin", BitmapDescriptor.defaultMarkerWithHue(90));

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
    });
  }

  Future<void> _getStartPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      if (value == null) {
        _startPosition = Position(
            latitude: _endPosition.latitude, longitude: _endPosition.longitude);
      } else {
        _startPosition = value;
      }
    });
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(_startPosition.latitude, _startPosition.longitude),
          zoom: 16),
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}

const spinkit = SpinKitCircle(
  color: Colors.redAccent,
  size: 50.0,
);

Widget _buildSpinkit() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        spinkit,
        Text('Route mapping'),
      ],
    ),
  );
}
