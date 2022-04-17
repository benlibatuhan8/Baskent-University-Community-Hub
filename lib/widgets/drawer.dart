import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/screens/admin_page.dart';
import 'package:comhub/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/restart.dart';

import '../screens/denememodpage.dart';

var loggedInUser;

class MyDrawer extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;

  final _auth = FirebaseAuth.instance;

  bool _isVisible = false;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<String>? result = currentUser!.email?.split("@");
        String currentUserID = result![0];
        Users userfields = await User_Service().getUserById(currentUserID);
        if (userfields.user_type == 'mod') {
          _isVisible = true;
        }
        var snap = FirebaseFirestore.instance
            .collection("communities")
            .where('mod_com', isEqualTo: userfields.mod_com)
            .get()
            .then((value) {
          return value;
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
            title: const Text('Ana Sayfa'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() == "/home") {
                Navigator.pop(context);
              } else {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.home, (route) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Topluluklarım'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() ==
                  "/mycompage") {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.mycompage, (route) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Tüm Topluluklar'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() ==
                  "/allcompage") {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.allcompage, (route) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Takvim'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() ==
                  "/calendarscreen") {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.calendarscreen, (route) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Profil'),
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
            title: const Text('Ayarlar'),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name.toString() ==
                  "/settings") {
                Navigator.pop(context);
              } else {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.settings, (route) => false);
              }
            },
          ),
          ListTile(
            title: const Text('Moderatör Ayarları'),
            onTap: () async {
              if (currentUser != null) {
                print(currentUser.email);
                List<String>? result = currentUser.email?.split("@");
                String currentUserID = result![0];
                User_Service user_service = new User_Service();
                Users currUser = await user_service.getUserById(currentUserID);
                print(currUser.user_type.toString());
                if (currUser.user_type == "mod") {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.modpage1, (route) => false);
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
            title: const Text('Danışman Ayarları'),
            onTap: () async {
              if (currentUser != null) {
                print(currentUser.email);
                List<String>? result = currentUser.email?.split("@");
                String currentUserID = result![0];
                User_Service user_service = new User_Service();
                Users currUser = await user_service.getUserById(currentUserID);
                print(currUser.user_type.toString());
                if (currUser.user_type == "advisor") {
                  Navigator.of(context).pushNamed(Routes.advisorpagescreen);
                } else {
                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text("Permission Denied !"),
                    content: Text("You are not a society Advisor"),
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
            title: const Text('Admin Ayarları'),
            onTap: () async {
              if (currentUser != null) {
                print(currentUser.email);
                List<String>? result = currentUser.email?.split("@");
                String currentUserID = result![0];
                User_Service user_service = new User_Service();
                Users currUser = await user_service.getUserById(currentUserID);
                print(currUser.user_type.toString());
                if (currUser.user_type == "admin") {
                  Navigator.of(context).pushNamed(Routes.adminpagescreen);
                } else {
                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text("Permission Denied !"),
                    content: Text("You are not an Admin!"),
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
            title: const Text('Çıkış yap'),
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
