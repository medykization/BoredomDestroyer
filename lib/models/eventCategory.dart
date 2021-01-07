import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventCategory {
  int id;
  String name;
  String namePL;
  Icon icon;

  EventCategory(int id, String name, Icon icon) {
    this.id = id;
    this.name = name;
    this.icon = icon;
  }

  @override
  String toString() {
    return this.name;
  }
}

class EventCategories {
  final List<EventCategory> categories = [
    EventCategory(
      1,
      'tournament',
      Icon(
        FontAwesomeIcons.trophy,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      2,
      'party',
      Icon(
        FontAwesomeIcons.glassCheers,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      3,
      'concert',
      Icon(
        FontAwesomeIcons.guitar,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      4,
      'festival',
      Icon(
        FontAwesomeIcons.icons,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      5,
      'conference',
      Icon(
        FontAwesomeIcons.comments,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      6,
      'gala',
      Icon(
        FontAwesomeIcons.cameraRetro,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      7,
      'charity',
      Icon(
        FontAwesomeIcons.handHoldingHeart,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      8,
      'sport',
      Icon(
        FontAwesomeIcons.volleyballBall,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      9,
      'expo',
      Icon(
        FontAwesomeIcons.store,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      10,
      'community',
      Icon(
        FontAwesomeIcons.users,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      11,
      'politics',
      Icon(
        FontAwesomeIcons.landmark,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      12,
      'board games',
      Icon(
        FontAwesomeIcons.dice,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      13,
      'karaoke',
      Icon(
        FontAwesomeIcons.microphoneAlt,
        color: Colors.blueAccent.shade100,
      ),
    ),
    EventCategory(
      14,
      'other',
      Icon(
        FontAwesomeIcons.atom,
        color: Colors.blueAccent.shade100,
      ),
    ),
  ];

  List<EventCategory> getEventCategories() {
    return categories;
  }

  int getIDbyName(String name) {
    EventCategory cat =
        categories.firstWhere((element) => element.name == name, orElse: () {
      return null;
    });

    if (cat != null) {
      return cat.id;
    } else {
      return 14;
    }
  }
}
