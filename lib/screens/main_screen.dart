import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                // TO DO
              },
              child: Icon(Icons.menu),
              textColor: Colors.white),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            // CONTEXT
          ],
        ),
      ),
    );
  }
}
