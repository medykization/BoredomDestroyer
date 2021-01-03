import 'package:flutter/material.dart';
import 'package:flutter_project/screens/elements/rounded_app_bar.dart';

class PlaceDetailsScreen extends StatefulWidget {
  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomPaint(
          size: Size(800, 150),
          painter: RoundedAppBar(),
        ),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            _buildPlaceName(),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}

Widget _buildPlaceName() {
  return Column(
    children: [Text("data")],
  );
}
