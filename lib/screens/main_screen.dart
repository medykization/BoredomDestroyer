import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            FlatButton(
                onPressed: () {
                  // TO DO
                },
                child: Icon(Icons.menu),
                textColor: Colors.white),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Places'),
              Tab(text: 'Events'),
            ],
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: new Center(
            child: TabBarView(
          children: [
            _buildView('Places'),
            _buildView('Events'),
          ],
        )),
      ),
    );
  }

  ListView _buildView(String choice) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            ListTile(title: Text(choice + ' $index')));
  }
}
