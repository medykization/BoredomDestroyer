import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: new Text(
                  'Boredom',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    fontFamily: 'Pacifico',
                    color: Colors.blueAccent,
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
              Center(
                child: new Text(
                  'Destroyer',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    fontFamily: 'Pacifico',
                    color: Colors.blueAccent,
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
