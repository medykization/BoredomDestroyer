import 'package:flutter/material.dart';
import 'elements/rounded_app_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomPaint(
          size: Size(800, 150),
          painter: RoundedAppBar(),
        ),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[_buildWelcomeTextRow()],
        ),
      ),
    );
  }

  Widget _buildWelcomeTextRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40, top: 110),
      child: Column(
        children: [
          Container(
            child: new Text(
              'Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ),
          Container(
            child: new Text(
              'Main Screen',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
