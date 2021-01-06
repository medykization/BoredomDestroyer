import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:hive/hive.dart';
import 'elements/rounded_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_project/API/auth.dart';
import 'package:flutter_project/models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String username, password, email;
  bool checkBoxValue = false;

  HttpAuth httpAuth = new HttpAuth();

  Box box;

  void initBoxValue() async {
    box = await Hive.openBox<User>('users');
  }

  @override
  void initState() {
    initBoxValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomPaint(
          size: Size(800, 150),
          painter: RoundedAppBar(),
        ),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Expanded(flex: 2, child: _buildWelcomeTextRow()),
            _buildUsernameRow(),
            _buildEmailRow(),
            _buildPasswordRow(),
            _buildCheckBox(),
            _buildSignUpButton(),
            Expanded(flex: 1, child: _buildSignInContainer()),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTextRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
          email = value;
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

  Widget _buildCheckBox() {
    return Padding(
      padding: EdgeInsets.only(left: 60, top: 15),
      child: Row(
        children: [
          Checkbox(
            value: checkBoxValue,
            onChanged: (bool value) {
              setState(() {
                checkBoxValue = value;
              });
            },
          ),
          Text(
              "By signing up I accept the Terms Of\nService and Privacy Policy")
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Padding(
      padding: EdgeInsets.only(left: 60, right: 60, top: 15),
      child: ButtonTheme(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10)),
        minWidth: 500.0,
        height: 50.0,
        child: FlatButton(
          onPressed: () async {
            if (checkBoxValue == true &&
                validatePassword() &&
                validateEmail() &&
                validateUsename()) {
              User user = await signUp();
              if (user.accessToken != null) {
                print(user.name);
                await _addUserDataToHive(user);
                navigateTo(MainScreen(), 200);
              } else {
                print("\nCan't create account");
              }
            } else {
              print("Please accept terms");
            }
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

  Widget _buildSignInContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account? "),
          TextButton(
            child: Text(
              "Sign In!",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              navigateTo(LoginScreen(), 200);
            },
          )
        ],
      ),
    );
  }

  Future<User> signUp() async {
    User data;
    await httpAuth.signUp(username, email, password).then(
          (val) => setState(
            () {
              data = val;
            },
          ),
        );
    return data;
  }

  void navigateTo(Widget screen, int animationTime) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: animationTime),
        transitionsBuilder: (context, animation, animationTime, child) {
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, animationTime) {
          return screen;
        },
      ),
    );
  }

  bool validatePassword() {
    return password != null && password.length > 8;
  }

  bool validateUsename() {
    return username != null && username.length > 8;
  }

  bool validateEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  _addUserDataToHive(User user) async {
    await box.put("user", user);
    await box.close();
  }
}
