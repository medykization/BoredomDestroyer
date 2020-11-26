import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

List<String> preferences = [
  "movie theater",
  "cafe",
  "bar",
  "beauty salon",
  "bowling alley",
  "casino",
  "gym",
  "zoo",
  "spa",
  "shopping mall",
  "night club",
  "museum",
];

class _PreferencesScreenState extends State<PreferencesScreen> {
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
      body: Container(
        child: new GridView.builder(
          itemCount: preferences.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return new Card(
              child: new GridTile(child: new Text(preferences[index])),
            );
          },
        ),
      ),
    );
  }
}
