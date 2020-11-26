import 'package:flutter/material.dart';
import 'package:flutter_project/models/place.dart';
import 'package:flutter_project/screens/settings_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_project/API/places.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

bool isLoadedPlaces = false;
bool isLoadedEvents = false;
List<Place> places;
PlacesApi placesApi = new PlacesApi();

Set<String> preferences = {
  "movie_theater",
  //"cafe",
};

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      await placesApi
          .getNearbyPlaces(500,
              new Location(position.latitude, position.longitude), preferences)
          .then((val) => setState(() {
                if (val != null) {
                  places = val;
                  isLoadedPlaces = true;
                }
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<bool>(builder: (BuildContext context) {
                    return SettingsScreen();
                  }));
                },
                child: Icon(Icons.menu),
                textColor: Colors.white),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Places'),
              Tab(text: 'Events'),
            ],
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: new Center(
          child: TabBarView(
            children: [
              isLoadedPlaces == false ? spinkit : _buildPlacesView('Places'),
              isLoadedEvents == false ? spinkit : _buildEventsView('Events'),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildPlacesView(String choice) {
    return ListView.builder(
        itemExtent: 120,
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
              child: Container(
                child: Card(
                  child: ListTile(
                    title: Text(places[index].name),
                    subtitle: Text("Distance: " + places[index].distance),
                    tileColor: Colors.blueAccent,
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 100,
                        minWidth: 100,
                        maxHeight: 100,
                        maxWidth: 100,
                      ),
                      child: Image.network("${places[index].icon}")
                  ),
                ),
              ));
    });
  }

  ListView _buildEventsView(String choice) {
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
              child: Container(
                child: Card(
                  child: ListTile(
                    title: Text(places[index].name),
                    subtitle: Text("Distance: " + places[index].distance),
                    tileColor: Colors.blueAccent,
                    leading: Image.network("${places[index].icon}"),
                  ),
                ),
              ));
        });
  }
}

const spinkit = SpinKitWave(
  color: Colors.blueAccent,
  size: 50.0,
);
