import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/event_category.dart';
import 'package:search_map_place/search_map_place.dart';

class EventPreferencesScreen extends StatefulWidget {
  @override
  _EventPreferencesScreenState createState() => _EventPreferencesScreenState();
}

EventCategories eventCategories = new EventCategories();
List<String> _categories;
List<String> _filters;
String _apiKey = "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I";
String inputEventLocationCity;

class _EventPreferencesScreenState extends State<EventPreferencesScreen> {
  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    _loadCategories();
    print(_categories);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: Text('Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLocationRow(),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Wrap(children: categoryWidgets.toList()),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              _buildSearchButton()
            ],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> get categoryWidgets sync* {
    for (String category in _categories) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          avatar: CircleAvatar(
            child: Text(category[0].toUpperCase()),
          ),
          label: Text(category),
          selected: _filters.contains(category),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(category);
              } else {
                _filters.removeWhere((String name) {
                  return name == category;
                });
              }
            });
          },
        ),
      );
    }
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 130),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () async {
            print("Selected: ${_filters.join(', ')}");
          },
          child: Text(
            'Search',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SearchMapPlaceWidget(
        iconColor: Colors.blueAccent.shade100,
        hasClearButton: true,
        placeType: PlaceType.address,
        placeholder: 'City',
        language: 'pl',
        apiKey: _apiKey,
        onSelected: (Place place) {
          List<String> splitted = place.description.split(", ");
          if (splitted.length == 0) {
            inputEventLocationCity = '';
          } else if (splitted.length == 1) {
            inputEventLocationCity = splitted[0];
          } else {
            inputEventLocationCity = splitted[1];
          }
          print('City: ' + inputEventLocationCity);
        },
      ),
    );
  }

  _loadCategories() {
    _categories =
        eventCategories.getEventCategories().map((e) => e.name).toList();
  }
}
