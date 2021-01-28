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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Selected: ${_filters.join(', ')}");
          Navigator.pop(context);
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blueAccent,
      ),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: Text('Search Events'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildCategoryBar('Location', Icons.place),
            _buildLocationRow(),
            SizedBox(height: 15),
            _buildCategoryBar('Categories', Icons.place),
            Wrap(children: categoryWidgets.toList()),
          ],
        ),
      ),
    );
  }

  _loadCategories() {
    _categories =
        eventCategories.getEventCategories().map((e) => e.name).toList();
  }

  Iterable<Widget> get categoryWidgets sync* {
    for (String category in _categories) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          selectedColor: Colors.blue[200],
          backgroundColor: Colors.blue[50],
          avatar: CircleAvatar(
            backgroundColor: Colors.blue[100],
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

  Widget _buildCategoryBar(String categoryName, IconData categoryIcon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(categoryIcon, color: Colors.blueAccent),
            SizedBox(width: 8),
            Text(
              categoryName,
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Divider(height: 15, thickness: 2),
      ],
    );
  }
}
