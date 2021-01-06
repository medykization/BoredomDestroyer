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
  final _formKey = GlobalKey<FormState>();

  FocusNode dateTimeFocusNode;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    category = _dropDownMenuItems[0].value;
    dateTimeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    dateTimeFocusNode.dispose();

    super.dispose();
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
      body: new Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildLocationRow(),
                Divider(height: 20),
                _buildEventNameRow(),
                Divider(height: 20),
                _buildDateTimeBeginRow(),
                Divider(height: 20),
                _buildDateTimeEndRow(),
                Divider(height: 20),
                _buildDescriptionRow(),
                Divider(height: 40),
                _buildPublishButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventNameRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
          onChanged: (value) {
            eventName = value;
          },
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(FontAwesomeIcons.book,
                  color: Colors.blueAccent.shade100, size: 20),
              labelText: 'event name'),
          validator: (input) => input.isEmpty ? 'can\'t be empty' : null),
    );
  }

  Widget _buildDescriptionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLength: 254,
        maxLines: null,
        onChanged: (value) {
          location = value;
        },
        validator: (input) =>
            input.length < 30 ? 'must contain at least 30 characters' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(FontAwesomeIcons.info,
                color: Colors.blueAccent.shade100, size: 20),
            labelText: 'description'),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: SearchMapPlaceWidget(
        iconColor: Colors.blueAccent.shade100,
        hasClearButton: true,
        placeType: PlaceType.address,
        placeholder: 'event location',
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
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        onTap: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onConfirm: (date) {
            setState(() {
              inputDateTimeBegin = formatDate(date);
            });
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.pl);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        readOnly: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(FontAwesomeIcons.clock,
                color: Colors.blueAccent.shade100, size: 20),
            labelText: inputDateTimeBegin == null
                ? 'beginning of the event'
                : inputDateTimeBegin),
        validator: (input) =>
            inputDateTimeBegin == null ? 'can\'t be empty' : null,
      ),
    );
  }

  Widget _buildDateTimeEndRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Theme(
        data: ThemeData(disabledColor: Colors.blueAccent),
        child: TextFormField(
          autofocus: false,
          onTap: () {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
              setState(() {
                inputDateTimeEnd = formatDate(date);
              });
              print('confirm $date');
            }, currentTime: DateTime.now(), locale: LocaleType.pl);
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          readOnly: true,
          focusNode: dateTimeFocusNode,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(FontAwesomeIcons.clock,
                  color: Colors.blueAccent.shade100, size: 20),
              labelText: inputDateTimeEnd == null
                  ? 'end of the event'
                  : inputDateTimeEnd),
          validator: (input) =>
              inputDateTimeEnd == null ? 'can\'t be empty' : null,
        ),
      ),
    );
  }

  Widget _buildPublishButton() {
    return ButtonTheme(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10)),
      minWidth: 100.0,
      height: 50.0,
      child: FlatButton(
        height: 43,
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('VALID',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              backgroundColor: Colors.grey,
            ));
          }
        },
        child: Text('SUBMIT'),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
  }

  // OLD

  // ignore: unused_element
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
}
