import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:comhub/screens/assets.dart';
import 'package:comhub/widgets/drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

class SettingsScreen extends StatelessWidget {
  int val = -1;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Settings",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5.0),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(avatars[4]),
                    ),
                    title: Text("Oguzhan KELES"),
                    onTap: () {},
                  ),
                  _buildDivider(),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "NOTIFICATION SETTINGS",
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    activeColor: Colors.purple,
                    value: true,
                    title: Text("Event Notifications"),
                    onChanged: (val) {},
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    value: true,
                    title: Text("News Notifications"),
                    onChanged: (val) {},
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    value: true,
                    title: Text("News Notifications"),
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            Text(
              "Language Settings",
              style: TextStyle(fontSize: 17.0),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  _buildDivider(),
                  ListTile(
                    title: Text("Türkçe"),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {},
                      activeColor: Colors.green,
                    ),
                  ),
                  _buildDivider(),
                  ListTile(
                    title: Text("English"),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {},
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade300,
  );
}
