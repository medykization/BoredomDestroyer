import 'package:flutter/material.dart';
import 'elements/rounded_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomPaint(
          size: Size(800, 150),
          painter: RoundedAppBar(),
        ),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            _buildWelcomeTextRow(),
            _buildUsernameRow(),
            _buildEmailRow(),
            _buildPasswordRow(),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTextRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40, top: 80),
      child: Column(
        children: [
          Container(
            child: new Text(
              'Quick and Easy',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ),
          Container(
            child: new Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          username = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.userAlt, color: Colors.blueGrey),
            labelText: 'username'),
      ),
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          username = value;
        },
        decoration: InputDecoration(
            prefixIcon:
                Icon(FontAwesomeIcons.solidEnvelope, color: Colors.blueGrey),
            labelText: 'e-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 60, right: 60),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.lock,
              color: Colors.blueGrey,
            ),
            labelText: 'password'),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60, top: 10),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () {
            //TO DO: Sign Up Button
          },
          child: Text(
            'SIGN UP',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
