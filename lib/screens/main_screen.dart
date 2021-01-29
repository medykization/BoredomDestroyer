import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/API/events.dart';
import 'package:flutter_project/models/event.dart';
import 'package:flutter_project/models/event_category.dart';
import 'package:flutter_project/models/place.dart';
import 'package:flutter_project/screens/add_event_screen.dart';
import 'package:flutter_project/screens/filter_screens/event_filter_screen.dart';
import 'package:flutter_project/screens/settings_screen.dart';
import 'package:flutter_project/screens/filter_screens/places_filter_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_project/API/places.dart';
import 'package:hive/hive.dart';

import 'detailsScreens/event_details_screen.dart';
import 'detailsScreens/place_details_screen.dart';

class MainScreen extends StatefulWidget {
  final double currentRange;
  final List<String> currentPreferences;
  final String currentCity;
  final List<String> currentCatrgories;
  MainScreen(
      {Key key,
      this.currentRange,
      this.currentPreferences,
      this.currentCity,
      this.currentCatrgories});
  @override
  _MainScreenState createState() => _MainScreenState();
}

bool isLoadedPlaces = false;
bool isLoadedEvents = false;

Timer timer;

double range;
String city;

List<Place> places;
List<Event> events;

PlacesApi placesApi = new PlacesApi();
EventsApi eventsApi = new EventsApi();

Set<String> placesPreferences;
List<String> eventCategory;
EventCategories eventCategories = new EventCategories();
Box placesBox;
Box eventsBox;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    initValues();
    loadPlaces();
    loadEvents();
    setTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  initValues() {
    range = widget.currentRange;
    city = widget.currentCity;
    placesPreferences = widget.currentPreferences.toSet();
    eventCategory = widget.currentCatrgories;
  }

  setTimer() {
    timer = new Timer.periodic(Duration(minutes: 1), (timer) {
      if (this.mounted) {
        loadPlaces();
        loadEvents();
      }
    });
  }

  Future<void> loadPlacesPreferences() async {
    placesBox = await Hive.openBox("places");
    placesPreferences = (await placesBox.get('preferences') as List).toSet();
    if (placesPreferences == null) {
      placesPreferences = {"restaurant"};
      await placesBox.put('preferences', ["restaurant"]);
    }
    range = (await placesBox.get('range') as int).toDouble();
    if (range == null) {
      await placesBox.put('range', 500.0);
      range = 500;
    }
  }

  Future<void> loadEventPreferences() async {
    eventsBox = await Hive.openBox("events");
    eventCategory = await eventsBox.get('category');
    if (eventCategory == null) {
      eventCategory = ["party"];
      await eventsBox.put('category', ["party"]);
    }
    city = await eventsBox.get('city');
    if (city == null) {
      city = "Łódź";
      await eventsBox.put('city', "Łódź");
    }
    print(eventCategory);
    print(city);
  }

  reloadEvents() async {
    await loadEventPreferences();
    await loadEvents();
  }

  reloadPlaces() async {
    await loadPlacesPreferences();
    await loadPlaces();
  }

  Future<void> loadPlaces() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      await placesApi
          .getNearbyPlaces(
              range.toInt(),
              new Location(position.latitude, position.longitude),
              placesPreferences)
          .then((val) => {
                if (this.mounted)
                  {
                    setState(() {
                      if (val != null) {
                        places = val;
                        isLoadedPlaces = true;
                      }
                    })
                  }
              });
    }
  }

  Future<void> loadEvents() async {
    if (city != null) {
      await eventsApi.getEventsNearby(city).then((val) => {
            if (this.mounted)
              {
                setState(() {
                  if (val != null) {
                    events = val;
                    isLoadedEvents = true;
                  }
                })
              }
          });
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
      body: RefreshIndicator(
        onRefresh: loadPlaces,
        child: ListView.builder(
            itemExtent: 120,
            itemCount: places.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 20.0),
                  child: Container(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<bool>(
                          builder: (BuildContext context) {
                        return (PlaceDetailsScreen(
                          place: places[index],
                        ));
                      }));
                    },
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
                          child: FittedBox(
                            child: Image.network("${places[index].icon}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<bool>(builder: (BuildContext context) {
            return (PreferencesScreen(
              reloadData: reloadPlaces,
              range: range,
              preferences: placesPreferences.toList(),
            ));
          }));
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Scaffold _buildEventsView(String choice) {
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: loadEvents,
        child: ListView.builder(
            itemExtent: 120,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 20.0),
                  child: Container(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute<bool>(
                                builder: (BuildContext context) {
                              return (EventDetailsScreen(
                                event: events[index],
                              )); // Event Details onTap
                            }));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(events[index].name),
                              subtitle: Text(events[index].locationAddress),
                              trailing: Text(events[index]
                                  .dateTimeBegin
                                  .substring(11, 16)),
                              tileColor: Colors.white,
                              leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  minWidth: 100,
                                  maxHeight: 100,
                                  maxWidth: 100,
                                ),
                                child: Icon(
                                  eventCategories
                                      .getIconByID(events[index].categoryID),
                                  color: Colors.blue.shade200,
                                  size: 50,
                                ),
                              ),
                            ),
                          ))));
            }),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.search),
            backgroundColor: Colors.blueAccent,
            onTap: () => Navigator.push(context,
                MaterialPageRoute<bool>(builder: (BuildContext context) {
              return (EventPreferencesScreen(
                  reloadData: reloadEvents,
                  city: city,
                  catrgories: eventCategory));
            })),
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.green[400],
            onTap: () => Navigator.push(context,
                MaterialPageRoute<bool>(builder: (BuildContext context) {
              return (AddEventScreen());
            })),
          ),
        ],
      ),
    );
  }
}

const spinkit = SpinKitWave(
  color: Colors.blueAccent,
  size: 50.0,
);
