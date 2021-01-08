import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/API/places.dart';
import 'package:flutter_project/models/place_category.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

PlacesApi placesApi = new PlacesApi();
PlaceCategories placeCategories;
List<String> _filters;

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  void initState() {
    super.initState();
    _filters = <String>[];
    placeCategories = new PlaceCategories();
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
        title: Text('Preferences'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Wrap(children: categoryWidgets.toList()),
            _buildSearchButton()
          ],
        ),
      ),
    );
  }

  Iterable<Widget> get categoryWidgets sync* {
    for (PlaceCategory category in placeCategories.placeCategories) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          avatar: CircleAvatar(
            child: Text(category.toString()[0].toUpperCase()),
          ),
          label: Text(toLabel(category.toString())),
          selected: _filters.contains(category.toString()),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(category.toString());
              } else {
                _filters.removeWhere((String name) {
                  return name == category.toString();
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
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  String toLabel(String s) {
    if (s == null) {
      return null;
    }
    String result = s.replaceAll('_', ' ');
    return result.splitMapJoin(RegExp(r'\w+'),
        onMatch: (m) =>
            '${m.group(0)}'.substring(0, 1).toUpperCase() +
            '${m.group(0)}'.substring(1).toLowerCase(),
        onNonMatch: (n) => ' ');
  }
}
