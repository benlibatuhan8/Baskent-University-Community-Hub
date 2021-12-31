import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/restart.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                ),
                child: Center(
                  child: const Image(
                    image: NetworkImage(
                        'https://www.baskent.edu.tr/img/logo_tr_standart.png'),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);

                },
              ),
              ListTile(
                title: const Text('My Communities'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).pushNamed(Routes.compage);
                },
              ),
              ListTile(
                title: const Text('Calendar'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                          Navigator.of(context).pushNamed(Routes.profile);
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
                title: const Text('Log Out'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
  
                },
              ),
            ],
          ),
        );
  }
}