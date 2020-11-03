import 'package:flutter/material.dart';
import 'elements/rounded_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            _buildPasswordRow(),
            _buildForgetPasswordButton(),
            _buildSignInButton(),
            _buildOrContainer(),
            _buildAuthButtons(),
            _buildCreateAccountContainer()
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTextRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40, top: 110),
      child: Column(
        children: [
          Container(
            child: new Text(
              'Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ),
          Container(
            child: new Text(
              'Sign In to continue',
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

  Widget _buildForgetPasswordButton() {
    return FlatButton(
      onPressed: () {
        // TO DO: Forget Password Button
      },
      child: Text(
        'Forgot Password?',
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60, top: 10),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () {
            //TO DO: Sign In Button
          },
          child: Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildOrContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Text(
        'OR',
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
    );
  }

  Widget _buildAuthButtons() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () {
              // TO DO: Google Login
            },
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.redAccent,
              size: 40,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
            ),
          ),
          FlatButton(
            onPressed: () {
              // TO DO: Facebook Login
            },
            child: Icon(
              FontAwesomeIcons.facebook,
              color: Colors.blueAccent,
              size: 40,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCreateAccountContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have any account? "),
          TextButton(
            child: Text(
              "Create New!",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              // TO DO: Create Account
            },
          )
        ],
      ),
    );
  }
}
