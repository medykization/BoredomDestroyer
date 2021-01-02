import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/search_places_screen.dart';

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
            _buildCategoryBar('Account', Icons.person),
            Divider(height: 15, thickness: 2),
            _buildChangePasswordButton(),
            SizedBox(height: 20),
            _buildCategoryBar('App', Icons.settings),
            Divider(height: 15, thickness: 2),
            _buildNotificationSwitch(),
            SizedBox(height: 30),
            _buildSignOutButton(),
          ],
        ),
      ),
    );
  }

  // CATEGORY BAR
  Widget _buildCategoryBar(String categoryName, IconData categoryIcon) {
    return Row(
      children: [
        Icon(categoryIcon, color: Colors.blueAccent),
        SizedBox(width: 8),
        Text(
          categoryName,
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

// ACCOUNT SETTINGS

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

// APP SETTINGS

  Widget _buildNotificationSwitch() {
    return FlatButton(
      onPressed: () {
        print('Preferences Button');
        // TO DO
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notifications',
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Transform.scale(
              child: CupertinoSwitch(
                onChanged: (bool value) {
                  // TO DO
                },
                value: true,
              ),
              scale: 0.8)
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Center(
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        onPressed: () {
          print("Sign Out Button");
          // TO DO
        },
        child: Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 2.2,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
