import 'package:flutter/material.dart';
import 'package:flutter_project/API/auth.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ); // Transparant Statusbar
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boredom Destroyer',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Application(),
    ),
  );
}

class Application extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<Application> {
  bool isLogged = false;
  HttpAuth auth = new HttpAuth();

  Set<String> placesPreferences;
  List<String> eventCategory;

  double range;
  String city;

  Future<void> initDataStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  Future<void> checkDataStorageForUserCredentials() async {
    await initDataStorage();
    await loadPlacesPreferences();
    await loadEventPreferences();
    Box box = await Hive.openBox<User>('users');
    User user = await box.get('user');
    if (user != null) {
      String token = await auth.refreshToken(user);
      if (token != null) {
        user.accessToken = token;
        await box.put('user', user);
        isLogged = true;
      }
    }
  }

  Future<void> loadPlacesPreferences() async {
    Box placesBox = await Hive.openBox("places");
    placesPreferences = (await placesBox.get('preferences') as List).toSet();
    if (placesPreferences == null) {
      placesPreferences = {"restaurant"};
      await placesBox.put('preferences', ["restaurant"]);
    }
    range = (await placesBox.get('range') as int).toDouble();
    if (range == null) {
      await placesBox.put('range', 500.0);
      range = 500;
    }
  }

  Future<void> loadEventPreferences() async {
    Box eventsBox = await Hive.openBox("events");
    eventCategory = await eventsBox.get('category');
    if (eventCategory == null) {
      eventCategory = ["party"];
      await eventsBox.put('category', ["party"]);
    }
    city = await eventsBox.get('city');
    if (city == null) {
      city = "Łódź";
      await eventsBox.put('city', "Łódź");
    }
  }

  @override
  void initState() {
    super.initState();
    checkDataStorageForUserCredentials();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (context, animation, animationTime, child) {
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (context, animation, animationTime) {
              if (!isLogged) {
                return LoginScreen();
              } else
                return MainScreen(
                    currentCatrgories: eventCategory,
                    currentCity: city,
                    currentRange: range,
                    currentPreferences: placesPreferences.toList());
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen();
  }
}
