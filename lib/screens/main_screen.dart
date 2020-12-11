import 'package:flutter/material.dart';
import 'package:flutter_project/API/events.dart';
import 'package:flutter_project/models/event.dart';
import 'package:flutter_project/models/place.dart';
import 'package:flutter_project/screens/add_event_screen.dart';
import 'package:flutter_project/screens/settings_screen.dart';
import 'package:flutter_project/screens/preferences_screen.dart';
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
List<Event> events;

PlacesApi placesApi = new PlacesApi();
EventsApi eventsApi = new EventsApi();

Set<String> preferences = {
  "restaurant",
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
          .getNearbyPlaces(2000,
              new Location(position.latitude, position.longitude), preferences)
          .then((val) => setState(() {
                if (val != null) {
                  places = val;
                  isLoadedPlaces = true;
                }
              }));
    }

    String city = "Łódź"; // TEST
    if (city != null) {
      await eventsApi.getEventsNearby(city).then((val) => setState(() {
            if (val != null) {
              events = val;
              isLoadedEvents = true;
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
          toolbarHeight: 80,
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

  Scaffold _buildPlacesView(String choice) {
    return new Scaffold(
      body: ListView.builder(
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
                    tileColor: Colors.white,
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 100,
                          minWidth: 100,
                          maxHeight: 100,
                          maxWidth: 100,
                        ),
                        child: Image.network("${places[index].icon}")),
                  ),
                )));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<bool>(builder: (BuildContext context) {
            return (PreferencesScreen());
          }));
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Scaffold _buildEventsView(String choice) {
    return new Scaffold(
      body: ListView.builder(
          itemExtent: 120,
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                child: Container(
                    child: Card(
                  child: ListTile(
                    title: Text(events[index].name),
                    subtitle: Text("Subtitle"),
                    tileColor: Colors.white,
                    leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 100,
                          minWidth: 100,
                          maxHeight: 100,
                          maxWidth: 100,
                        ),
                        child: Icon(Icons.access_alarm)),
                  ),
                )));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<bool>(builder: (BuildContext context) {
            return (AddEventScreen());
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

const spinkit = SpinKitWave(
  color: Colors.blueAccent,
  size: 50.0,
);
