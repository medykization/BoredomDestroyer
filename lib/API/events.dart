import 'package:flutter_project/models/event.dart';
import 'package:flutter_project/models/user.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EventsApi {
  static const getEventsURL =
      "https://boredom-server.herokuapp.com/events/local";
  static const addEventsURL = "https://boredom-server.herokuapp.com/events/add";

  Future<List<Event>> getEventsNearby(String city) async {
    List<Event> results = [];

    Map cityMap = {'city': city};
    String body = convert.json.encode(cityMap);

    Box box = await Hive.openBox<User>('users');
    User user = await box.get('user');
    String token = user.accessToken;

    try {
      http.Response response = await http.post(getEventsURL,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      var jsonResponse = convert.json.decode(response.body)['results'] as List;
      results = jsonResponse.map((val) => Event.fromJson(val)).toList();

      print("getEventsNearby():" + response.statusCode.toString());
    } catch (e) {
      print(e.toString());
    }
    return results;
  }

  Future<bool> addEvent(Event event) async {
    // Get body
    Map eventMap = {
      'event_name': event.name,
      'category_id': event.categoryID,
      'description': event.description,
      'location_city': event.locationCity,
      'location_address': event.locationAddress,
      'begin_time': event.dateTimeBegin,
      'end_time': event.dateTimeEnd,
      'rating': event.userRating
    };

    String body = convert.json.encode(eventMap);

    // Get token
    Box box = await Hive.openBox<User>('users');
    User user = await box.get('user');
    await box.close();

    String token = user.accessToken;

    // Send data
    try {
      http.Response response = await http.post(addEventsURL,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      print("Add Event: . " +
          "Status Code:" +
          response.statusCode.toString()); // for debugging
      return response.statusCode == 200;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
