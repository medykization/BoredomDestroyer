import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventCategory {
  int id;
  String name;
  String namePL;
  IconData iconData;

  EventCategory(int id, String name, IconData iconData) {
    this.id = id;
    this.name = name;
    this.iconData = iconData;
  }

  @override
  String toString() {
    return this.name;
  }
}

class EventCategories {
  final List<EventCategory> categories = [
    EventCategory(1, 'tournament', FontAwesomeIcons.trophy),
    EventCategory(2, 'party', FontAwesomeIcons.glassCheers),
    EventCategory(3, 'concert', FontAwesomeIcons.guitar),
    EventCategory(4, 'festival', FontAwesomeIcons.icons),
    EventCategory(5, 'conference', FontAwesomeIcons.comments),
    EventCategory(6, 'gala', FontAwesomeIcons.cameraRetro),
    EventCategory(7, 'charity', FontAwesomeIcons.handHoldingHeart),
    EventCategory(8, 'sport', FontAwesomeIcons.volleyballBall),
    EventCategory(9, 'expo', FontAwesomeIcons.store),
    EventCategory(10, 'community', FontAwesomeIcons.users),
    EventCategory(11, 'politics', FontAwesomeIcons.landmark),
    EventCategory(12, 'board games', FontAwesomeIcons.dice),
    EventCategory(13, 'karaoke', FontAwesomeIcons.microphoneAlt),
    EventCategory(14, 'other', FontAwesomeIcons.atom)
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

  IconData getIconByID(int id) {
    EventCategory cat =
        categories.firstWhere((element) => element.id == id, orElse: () {
      return null;
    });
    if (cat != null) {
      return cat.iconData;
    } else {
      return FontAwesomeIcons.atom;
    }
  }
}
