import 'package:flutter_project/models/event.dart';
import 'package:flutter_project/models/user.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EventsApi {
  static const getEventsURL =
      "https://boredom-server.herokuapp.com/events/local";

  Future<List<Event>> getEventsNearby(String city) async {
    List<Event> results = [];

    Map cityMap = {'city': city};
    String body = convert.json.encode(cityMap);

    Box box = await Hive.openBox<User>('users');
    User user = await box.get('user');
    await box.close();

    String token = user.accessToken;

    try {
      http.Response response = await http.post(getEventsURL,
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      print(response.statusCode);

      var jsonResponse = convert.json.decode(response.body)['results'] as List;

      results = jsonResponse.map((val) => Event.fromJson(val)).toList();

      //print(results.toString());
    } catch (e) {
      print(e.toString());
    }
    return results;
  }

  Future<void> addEvent(Event event) async {}
}
