import 'package:flutter/material.dart';
import 'package:flutter_project/models/event.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({Key key, this.event}) : super(key: key);
  @override
  _EventDetailsScreenState createState() =>
      _EventDetailsScreenState(event: event);
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final Event event;
  int _userVote; // TO DO: GET USER VOTE
  int _rating;

  var _thumbUpColor = Colors.grey;
  var _thumbDownColor = Colors.grey;

  _EventDetailsScreenState({@required this.event}) {
    _userVote = 0;
    _rating = event.userRating;
  }

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
          event.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Text(''),
            backgroundColor: Colors.redAccent,
            expandedHeight: 120,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildLocationColumn(),
              _buildDateTimeColumn(),
              _buildDescriptionColumn(),
              _buildRatingColumn(),
              Divider(
                height: 100,
              )
            ]),
          )
        ],
      )),
    );
  }

// Date Time
  Widget _buildDateTimeColumn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: Colors.redAccent,
              ),
              Text('   '),
              Text(
                'Date / Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 30,
          ),
          Row(
            children: [
              Text(
                'Beginning:   ',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(flex: 1, child: Container()),
              Text(
                event.dateTimeBegin.substring(0, 10) +
                    '  ' +
                    event.dateTimeBegin.substring(11, 16) +
                    ' ',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Ending:         ',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(flex: 1, child: Container()),
              Text(
                event.dateTimeEnd.substring(0, 10) +
                    '  ' +
                    event.dateTimeEnd.substring(11, 16) +
                    ' ',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            height: 30,
          ),
        ],
      ),
    );
  }

// Location
  Widget _buildLocationColumn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.map,
                color: Colors.redAccent,
              ),
              Text('   '),
              Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 30,
          ),
          Row(
            children: [
              Text(
                event.locationCity + ', ' + event.locationAddress,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Divider(
            height: 30,
          ),
        ],
      ),
    );
  }

// Description
  Widget _buildDescriptionColumn() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.redAccent,
              ),
              Text('   '),
              Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 30,
          ),
          Text(
            event.description,
            style: TextStyle(fontSize: 18),
          ),
          Divider(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingColumn() {
    var _greenThumbColor = Colors.green;
    var _redThumbColor = Colors.red;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.rate_review,
                color: Colors.redAccent,
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: 20,
                  color: _thumbUpColor,
                  icon: Icon(Icons.thumb_up),
                  onPressed: (() {
                    setState(() {
                      if (_userVote == 0) {
                        // TO DO: ADD VOTE TO DB
                        _userVote = 1;
                        _thumbUpColor = _greenThumbColor;
                        _rating += 1;
                      } else if (_userVote == -1) {
                        // TO DO: CHANGE VOTE IN DB
                        _userVote = 1;
                        _thumbUpColor = _greenThumbColor;
                        _thumbDownColor = Colors.grey;
                        _rating += 2;
                      } else if (_userVote == 1) {
                        // TO DO: REMOVE VOTE FROM DB
                        _userVote = 0;
                        _thumbUpColor = Colors.grey;
                        _rating -= 1;
                      }
                    });
                  })),
              Text(
                _rating.toString(),
                style: TextStyle(fontSize: 30, color: Colors.grey[800]),
              ),
              IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.thumb_down),
                  color: _thumbDownColor,
                  onPressed: (() {
                    setState(() {
                      if (_userVote == 0) {
                        // TO DO: ADD VOTE TO DB
                        _userVote = -1;
                        _thumbDownColor = _redThumbColor;
                        _rating -= 1;
                      } else if (_userVote == 1) {
                        // TO DO: CHANGE VOTE IN DB
                        _userVote = -1;
                        _thumbDownColor = _redThumbColor;
                        _thumbUpColor = Colors.grey;
                        _rating -= 2;
                      } else if (_userVote == -1) {
                        // TO DO: REMOVE VOTE FROM DB
                        _userVote = 0;
                        _thumbDownColor = Colors.grey;
                        _rating += 1;
                      }
                    });
                  })),
            ],
          ),
        ],
      ),
    );
  }
}
