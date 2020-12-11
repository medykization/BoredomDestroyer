import 'dart:io';

import 'package:flutter_project/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class EventsApi {
  static const getEventsURL =
      "https://boredom-server.herokuapp.com/events/local";

  Future<List<Event>> getEventsNearby(String city) async {
    List<Event> results = new List();

    Map cityMap = {'city': city};
    String body = convert.json.encode(cityMap);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    try {
      http.Response response = await http.post(getEventsURL,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      print(response.statusCode);
      print("Events response body: \n" + response.body);

      Event testEvent = new Event(name: "nazwa");
      results.add(testEvent);
    } catch (e) {
      print(e.toString());
    }
    return results;
  }

  Future<void> addEvent(Event event) async {}
}
