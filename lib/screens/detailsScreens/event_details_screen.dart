import 'package:flutter/material.dart';
import 'package:flutter_project/screens/elements/rounded_app_bar.dart';

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
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
            _buildEventName(),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}

Widget _buildEventName() {
  return Column(
    children: [Text("data")],
  );
}
