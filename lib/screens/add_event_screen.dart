import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main_screen.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

String eventName, location, description;
DateTime startTime, endTime;
String category;

List<String> _categories = [
  "tournament",
  "party",
  "concert",
  "festival",
];

List<DropdownMenuItem<String>> _dropDownMenuItems;

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    category = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _categories) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCategory) {
    setState(() {
      category = selectedCategory;
    });
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
        title: Text('Add Event'),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Expanded(flex: 2, child: _buildWelcomeTextRow()),
            _buildEventNameRow(),
            _buildLocationRow(),
            _buildCategoryRow(),
            _buildDescriptionRow(),
            Expanded(flex: 1, child: _buildPublishButton())
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTextRow() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Text(
              'Add Event',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ],
        ));
  }

  Widget _buildEventNameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          eventName = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.book, color: Colors.blueGrey),
            labelText: 'username'),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          location = value;
        },
        decoration: InputDecoration(
            prefixIcon:
                Icon(FontAwesomeIcons.locationArrow, color: Colors.blueGrey),
            labelText: 'location'),
      ),
    );
  }

  Widget _buildDescriptionRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          location = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.archive, color: Colors.blueGrey),
            labelText: 'description'),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Please choose your Category: "),
        new Container(
          padding: new EdgeInsets.all(16.0),
        ),
        new DropdownButton(
          value: category,
          items: _dropDownMenuItems,
          onChanged: changedDropDownItem,
        )
      ],
    );
  }

  Widget _buildPublishButton() {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60, top: 10),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () async {
            print("test dodawania eventów");
          },
          child: Text(
            'Publish',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  void navigateTo(Widget screen, int animationTime) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: animationTime),
        transitionsBuilder: (context, animation, animationTime, child) {
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, animationTime) {
          return screen;
        },
      ),
    );
  }
}
