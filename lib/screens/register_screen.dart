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

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
              prefixIcon: Icon(FontAwesomeIcons.userAlt,
                  color: Colors.blueAccent.shade100),
              labelText: 'username'),
          validator: (input) {
            String errorText;
            if (validateUsername()) {
              errorText = 'can\'t be empty';
            }
            /*  else if (await isUsernameOccupied()) {
              errorText = 'This username is already taken';
            }
            */
            return errorText;
          }
          /* (input) => validateUsername() ? 'can\'t be empty' : null, */
          ),
    );
  }

  bool validateUsername() {
    return username == null || username.length == 0;
  }
  /*
  Future<bool> isUsernameOccupied() async {
    return await httpAuth.checkUsername(username);
  }
  */

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(FontAwesomeIcons.solidEnvelope,
                color: Colors.blueAccent.shade100),
            labelText: 'e-mail'),
        validator: (input) => validateEmail() ? 'incorrect e-mail' : null,
      ),
    );
  }

  bool validateEmail() {
    if (email == null) return true;
    bool emailValid = !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  Future<bool> isEmailOccupied() async {
    return await httpAuth.checkEmail(email);
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
              color: Colors.blueAccent.shade100,
            ),
            labelText: 'password'),
        validator: (password) =>
            validatePassword() ? 'must contain at least 8 characters' : null,
      ),
    );
  }

  bool validatePassword() {
    return password == null || password.length < 8;
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

  bool validateCheckBox() {
    return checkBoxValue;
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
            if (_formKey.currentState.validate() && validateCheckBox()) {
              User user = await signUp();
              if (user.accessToken != null) {
                print(user.name);
                await _addUserDataToHive(user);
                navigateTo(MainScreen(), 200);
              } else {
                print("\nCan't create account");
              }
              print('validation test');
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

  _addUserDataToHive(User user) async {
    await box.put("user", user);
  }
}
