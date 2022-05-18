import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/screens/comlistpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';
import '../services/user_services.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

class HomeScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  Future getCurrentUserComs() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<String>? result = user.email?.split("@");
        String currentUserID = result![0];
        Users userfields = await User_Service().getUserById(currentUserID);
        var snap = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserID)
            .collection('followingcomms')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            print(element.data());
          });
        });

        print(snap);
        return snap;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Ana Sayfa",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      //drawer:
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserID)
            .collection("following_coms")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final comms = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                Text(
                  comms[index].get("name"),
                  style: Theme.of(context).textTheme.headline4,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("communities")
                      .doc(comms[index].get("name"))
                      .collection("events")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final events = snapshot2.data!.docs;
                    return Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 500,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot2.data!.docs.length,
                              itemBuilder: (ctx, index) => Card(
                                color: Colors.indigo.shade300,
                                child: Column(
                                  children: [
                                    Text(
                                      events[index].get("name"),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Card(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            width: 250,
                                            child: Expanded(
                                                child: RichText(
                                                    text: TextSpan(children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0),
                                                  text:
                                                      "Lokasyonu görmek için "),
                                              TextSpan(
                                                  style: TextStyle(
                                                    color:
                                                        Colors.indigo.shade700,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  text: "tıklayın",
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () async {
                                                          var url =
                                                              events[index].get(
                                                                  "location");
                                                          if (await canLaunch(
                                                              url)) {
                                                            await launch(url);
                                                          } else {
                                                            throw 'Could not launch $url';
                                                          }
                                                        }),
                                            ]))),
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Icon(
                                              Icons.assistant_direction_rounded)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
