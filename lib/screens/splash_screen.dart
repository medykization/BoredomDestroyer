import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(),
              ),
              Center(
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
              Center(
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
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Padding(padding: EdgeInsets.only(bottom: 50), child: spinkit),
            ],
          )
        ],
      ),
    );
  }
}

const spinkit = SpinKitCircle(
  color: Colors.white70,
  size: 30.0,
);
