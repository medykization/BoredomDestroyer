import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade800, Colors.lightBlueAccent.shade100],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: new Text(
                  'Boredom',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    fontFamily: 'Pacifico',
                    color: Colors.white70,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 8.0,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: new Text(
                  'Destroyer',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    fontFamily: 'Pacifico',
                    color: Colors.white70,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 8.0,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
