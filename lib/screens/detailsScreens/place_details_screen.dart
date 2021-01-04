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
  final Place place;
  _PlaceDetailsScreenState({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.near_me),
          backgroundColor: Colors.redAccent),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          place.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Text(''),
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
            itemExtent: 50.0,
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  place.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.near_me),
                    Text('   '),
                    Text('Distance: ' + place.distance,
                        style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
              //Text(place.location.toString()),
            ]),
          )
        ],
      )),
    );
  }
}
