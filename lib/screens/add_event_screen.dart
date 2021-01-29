import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/event.dart';
import 'package:flutter_project/models/event_category.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

String inputEventName,
    inputEventLocationCity,
    inputEventLocationAddress,
    inputEventDescription,
    inputBeginTime,
    inputEndTime,
    inputEventCategory;

int inputCategoryID;

var _currentSelectedCategory;

EventCategories categories;
List<EventCategory> _categories;

List<DropdownMenuItem<String>> _dropDownMenuItems;

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  FocusNode dateTimeFocusNode;

  var beginDTtextController = new TextEditingController();
  var endDTtextController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    categories = new EventCategories();
    _categories = categories.getEventCategories();

    // Dropdown Menu
    _dropDownMenuItems = getDropDownMenuItems();
    inputEventCategory = _dropDownMenuItems[0].value;

    dateTimeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    dateTimeFocusNode.dispose();
    beginDTtextController.dispose();
    endDTtextController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (EventCategory category in _categories) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: category.name, child: new Text(category.name)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCategory) {
    if (this.mounted) {
      setState(() {
        inputEventCategory = selectedCategory;
      });
    }
  }

  String _apiKey = "AIzaSyDuNDK_ogM5AnrMqawuqZQYzDVXkVnE45I";
  String displayBeginTime;
  String displayEndTime;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
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
                _buildCategoryRow(),
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
            inputEventName = value;
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
        maxLength: 250,
        maxLines: null,
        onChanged: (value) {
          inputEventDescription = value;
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
          List<String> splitted = place.description.split(", ");
          if (splitted.length == 0) {
            inputEventLocationAddress = '';
            inputEventLocationCity = '';
          } else if (splitted.length == 1) {
            inputEventLocationCity = splitted[0];
            inputEventLocationAddress = '';
          } else {
            inputEventLocationAddress = splitted[0];
            inputEventLocationCity = splitted[1];
          }
          print('City: ' +
              inputEventLocationCity +
              '\nAddress: ' +
              inputEventLocationAddress);
        },
      ),
    );
  }

  Widget _buildDateTimeBeginRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        controller: beginDTtextController,
        onTap: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onConfirm: (date) {
            if (this.mounted) {
              setState(() {
                inputBeginTime = formatDateToSend(date);
                displayBeginTime = formatDateToDisplay(date);
              });
            }
            beginDTtextController.text = displayBeginTime;
          }, currentTime: DateTime.now(), locale: LocaleType.pl);
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        readOnly: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(FontAwesomeIcons.clock,
                color: Colors.blueAccent.shade100, size: 20),
            labelText: 'beginning of the event'),
        validator: (input) =>
            displayBeginTime == null ? 'can\'t be empty' : null,
      ),
    );
  }

  Widget _buildDateTimeEndRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Theme(
        data: ThemeData(disabledColor: Colors.blueAccent),
        child: TextFormField(
            controller: endDTtextController,
            autofocus: false,
            onTap: () {
              DatePicker.showDateTimePicker(context, showTitleActions: true,
                  onConfirm: (date) {
                if (this.mounted) {
                  setState(() {
                    inputEndTime = formatDateToSend(date);
                    print(inputEndTime);
                    displayEndTime = formatDateToDisplay(date);
                  });
                }
                endDTtextController.text = displayEndTime;
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
                labelText: 'end of the event'),
            validator: (input) {
              String errorText;
              if (displayEndTime == null) {
                errorText = 'can\'t be empty';
              } else if (DateTime.parse(displayEndTime)
                  .isBefore(DateTime.parse(displayBeginTime))) {
                return 'the end must be after the beginning';
              }
              return errorText;
            }),
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
        onPressed: () async {
          if (_formKey.currentState.validate() &&
              inputEventLocationAddress.isNotEmpty &&
              inputEventLocationCity.isNotEmpty) {
            Event event = new Event(
              name: inputEventName,
              categoryID: inputCategoryID,
              categoryName: inputEventCategory,
              description: inputEventDescription,
              locationCity: inputEventLocationCity,
              locationAddress: inputEventLocationAddress,
              dateTimeBegin: inputBeginTime,
              dateTimeEnd: inputEndTime,
              userRating: 0,
            );
            eventsApi.addEvent(event).then((value) => {
                  if (value) {Navigator.pop(context)}
                });
          }
        },
        child: Text('SUBMIT'),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: 'Category',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(
                Icons.ac_unit,
                color: Colors.blueAccent.shade100,
              ),
              labelStyle: null,
            ),
            isEmpty: _currentSelectedCategory == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedCategory,
                isDense: true,
                onChanged: (String newValue) {
                  if (this.mounted) {
                    setState(() {
                      _currentSelectedCategory = newValue;
                      inputCategoryID =
                          categories.getIDbyName(_currentSelectedCategory);
                      state.didChange(newValue);
                    });
                  }
                },
                items: _categories.map((EventCategory value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  String formatDateToDisplay(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
  }

  String formatDateToSend(DateTime dateTime) {
    List<String> splittedTime = dateTime.toString().split(" ");
    String result = splittedTime[0] + 'T' + splittedTime[1] + 'Z';
    return result;
  }
}
