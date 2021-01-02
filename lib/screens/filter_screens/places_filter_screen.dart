import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/API/events.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

EventsApi eventsApi = new EventsApi();
List<String> _categories;
List<String> _filters;

class _PreferencesScreenState extends State<PreferencesScreen> {
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
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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

  _loadCategories() {
    _categories = eventsApi.getCategories();
  }
}
