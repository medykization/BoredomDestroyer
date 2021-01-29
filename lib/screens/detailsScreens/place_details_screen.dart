import 'package:flutter/material.dart';
import 'package:flutter_project/models/place.dart';
import 'package:flutter_project/screens/mapScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute<bool>(builder: (BuildContext context) {
              return MapScreen(new Position(
                  latitude: place.location.lat, longitude: place.location.lng));
            }));
          },
          child: Icon(Icons.near_me),
          backgroundColor: Colors.blueAccent),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
            backgroundColor: Colors.blueAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: FittedBox(
                child: new Image.network("${place.icon}"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildNameColumn(),
              _buildLocationColumn(),
              _buildRatingColumn(),
              //Text(place.location.toString()),
            ]),
          )
        ],
      )),
    );
  }

  getPosition() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => () {
              setState(() {});
            });
  }

  Widget _buildNameColumn() {
    {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.place,
                  color: Colors.blueAccent,
                ),
                Text('   '),
                Text(
                  'Place',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            Row(
              children: [
                Text(
                  place.name,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  _buildLocationColumn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.map,
                color: Colors.blueAccent,
              ),
              Text('   '),
              Text(
                'Distance',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 20,
          ),
          Row(
            children: [
              Text(
                place.distance,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildRatingColumn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star_rate,
                color: Colors.blueAccent,
              ),
              Text('   '),
              Text(
                'Rating',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 20,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: place.rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              minRating: place.rating,
              maxRating: place.rating,
              itemSize: 28,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double value) {},
            ),
          ),
        ],
      ),
    );
  }
}
