import 'package:flutter_project/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EventsApi {
  // ignore: missing_return
  Future<List<Event>> getEventsNearby() async {
    List<Event> result = new List();
  }

  Future<void> addEvent(Event event) async {}
}
