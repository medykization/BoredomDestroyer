import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/place_category.dart';
import 'package:hive/hive.dart';

class PreferencesScreen extends StatefulWidget {
  final Function reloadData;
  final double range;
  final List<String> preferences;
  PreferencesScreen({Key key, this.reloadData, this.range, this.preferences})
      : super(key: key);
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

PlaceCategories placeCategories;
List<String> filters = [];
double sliderRange = 500;
Box box;

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  void initState() {
    super.initState();
    initValues();
    sliderRange = widget.range;
    filters = widget.preferences;
    placeCategories = new PlaceCategories();
  }

  Future<void> initValues() async {
    box = await Hive.openBox("places");
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
        title: Text('Search Places'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildCategoryBar('Search range', Icons.place),
            Divider(height: 15, thickness: 2),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                sliderRange.round().toString() + " m",
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            ),
            Slider(
                activeColor: Colors.blue[200],
                inactiveColor: Colors.blue[50],
                divisions: 4,
                min: 500,
                value: sliderRange,
                max: 2500,
                onChanged: (double value) {
                  setState(() {
                    sliderRange = value;
                  });
                }),
            SizedBox(height: 10),
            _buildCategoryBar('Place categories', Icons.category),
            Divider(height: 15, thickness: 2),
            Wrap(children: categoryWidgets.toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await box.put('preferences', filters.toList());
          await box.put('range', sliderRange.toInt());
          widget.reloadData();
          Navigator.pop(context);
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Iterable<Widget> get categoryWidgets sync* {
    for (PlaceCategory category in placeCategories.placeCategories) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          selectedColor: Colors.blue[200],
          backgroundColor: Colors.blue[50],
          avatar: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(category.toString()[0].toUpperCase()),
          ),
          label: Text(toLabel(category.toString())),
          selected: filters.contains(category.toString()),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filters.add(category.toString());
              } else {
                filters.removeWhere((String name) {
                  return name == category.toString();
                });
              }
            });
          },
        ),
      );
    }
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

Widget _buildCategoryBar(String categoryName, IconData categoryIcon) {
  return Row(
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
  );
}
