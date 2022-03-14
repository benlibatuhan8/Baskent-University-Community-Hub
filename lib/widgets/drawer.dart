import 'package:comhub/models/user.dart';
import 'package:comhub/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/restart.dart';

class MyDrawer extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
            ),
            child: Center(
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() == "/home") {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushNamed(Routes.home);
              }
            },
          ),
          ListTile(
            title: const Text('My Communities'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pushNamed(Routes.mycompage);
            },
          ),
          ListTile(
            title: const Text('All Communities'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pushNamed(Routes.allcompage);
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pushNamed(Routes.calendarscreen);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() ==
                  "/profile") {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushNamed(Routes.profile);
              }
            },
          ),
          ListTile(
            title: const Text('Settings'),
            
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.of(context).pushNamed(Routes.settings);
            },
          ),
          ListTile(
            
            title: const Text('Moderator Page'),
            onTap: () async {
              if (currentUser != null) {
                print(currentUser.email);
                List<String>? result = currentUser.email?.split("@");
                String currentUserID = result![0];
                User_Service user_service = new User_Service();
                Users currUser = await user_service.getUserById(currentUserID);
                print(currUser.user_type.toString());
                if (currUser.user_type == "mod") {
                  Navigator.of(context).pushNamed(Routes.modpage1);
                } else {
                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text("Permission Denied !"),
                    content: Text("You are not a society moderator"),
                    actions: [
                      okButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              }
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                (value) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
