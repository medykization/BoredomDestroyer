import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: Text('Settings'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [
            SizedBox(height: 20),
            _buildAccountCategoryRow(),
            Divider(height: 15, thickness: 2),
            _buildChangePasswordButton(),
            Divider(height: 15, thickness: 2),
            _buildPreferencesButton(),
          ],
        ),
      ),
    );
  }
}

// ACCOUNT

Widget _buildAccountCategoryRow() {
  return Row(
    children: [
      Icon(Icons.person, color: Colors.blueAccent),
      SizedBox(width: 8),
      Text(
        'Account',
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _buildChangePasswordButton() {
  return FlatButton(
    onPressed: () {
      print('Change Password Button');
      // TO DO
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Change Password',
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 20.0,
        )
      ],
    ),
  );
}

Widget _buildPreferencesButton() {
  return FlatButton(
    onPressed: () {
      print('Preferences Button');
      // TO DO
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Preferences',
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
          size: 20.0,
        )
      ],
    ),
  );
}
