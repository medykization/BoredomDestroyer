import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/place.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;
  PlaceDetailsScreen({Key key, @required this.place}) : super(key: key);
  @override
  _PlaceDetailsScreenState createState() =>
      _PlaceDetailsScreenState(place: place);
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  // Declare a field that holds the Todo.
  final Place place;

  // In the constructor, require a Todo.
  _PlaceDetailsScreenState({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(place.name),
            backgroundColor: Colors.redAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: FittedBox(
                child: new Image.network("${place.icon}"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildListDelegate([
              Text(place.name),
              Text(place.distance),
              //Text(place.location.toString()),
              Text('TEST'),
              Text('TEST'),
              Text('TEST'),
              Text('TEST'),
              Text('TEST'),
              Text('TEST'),
            ]),
          )
        ],
      )),
    );
  }
}
