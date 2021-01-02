import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

String eventName, location, description;
DateTime startTime, endTime;
String category;

var _currentSelectedCategory;
List<String> _categories = [
  "tournament",
  "party",
  "concert",
  "festival",
  "other",
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

  String _apiKey = "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I";
  String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
  String inputDateTimeBegin;
  String inputDateTimeEnd;

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
      body: SingleChildScrollView(
        child: new Center(
          child: Column(
            children: <Widget>[
              _buildCategoryRowNew(),
              _buildLocationRow(),
              _buildEventNameRow(),
              _buildDateTimeBeginRow(),
              _buildDateTimeEndRow(),
              _buildDescriptionRow(),
              _buildPublishButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventNameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          eventName = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.bookmark, color: Colors.blueGrey),
            labelText: 'event name'),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
      child: SearchMapPlaceWidget(
        hasClearButton: true,
        placeType: PlaceType.address,
        placeholder: 'Enter event location',
        language: 'pl',
        apiKey: _apiKey,
        onSelected: (Place place) {
          print(place.fullJSON);
        },
      ),
    );
  }

  Widget _buildDateTimeBeginRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 45.0),
      child: FlatButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onConfirm: (date) {
            //TO DO ON CONFIRM
            setState(() {
              inputDateTimeBegin = formatDate(date);
            });
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.pl);
        },
        child: TextFormField(
          enabled: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.clock, color: Colors.blueGrey),
              labelText: inputDateTimeBegin == null
                  ? formatDate(DateTime.now())
                  : inputDateTimeBegin),
        ),
      ),
    );
  }

  Widget _buildDateTimeEndRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 45.0),
      child: FlatButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onConfirm: (date) {
            //TO DO ON CONFIRM
            setState(() {
              inputDateTimeEnd = formatDate(date);
            });
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.pl);
        },
        child: TextFormField(
          enabled: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.clock, color: Colors.blueGrey),
              labelText: inputDateTimeEnd == null
                  ? formatDate(DateTime.now())
                  : inputDateTimeEnd),
        ),
      ),
    );
  }

  Widget _buildDescriptionRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (value) {
          location = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.info, color: Colors.blueGrey),
            labelText: 'description'),
      ),
    );
  }

  Widget _buildCategoryRowNew() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelStyle: null,
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            ),
            isEmpty: _currentSelectedCategory == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedCategory,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _currentSelectedCategory = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPublishButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 130),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () async {
            print("test dodawania eventów: " + _currentSelectedCategory);
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

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
  }
}
