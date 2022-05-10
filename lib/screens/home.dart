import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/screens/comlistpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/drawer.dart';

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
      body: ListView(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Yaklaşan Etkinlikler",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.topCenter,
          ),
          SizedBox(
            height: 20.0,
          ),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Card(
                color: Colors.indigo.shade700,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Computer Society",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text("MEETING EVENT"),
                      subtitle: Text(
                          "First even of semester. Come and meet with members!"),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/basres1.jpg",
                            scale: 50.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Avni Akyol Conference Hall\n\nFatih Sultan 06790\nEtimesgut/Ankara",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.assistant_direction_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("11:00")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.lightBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("07.01.2022")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Card(
                          child: Text(
                            "Join Event",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )),
                  ],
                ),
              ),

              //2nd image of slider
              Card(
                color: Colors.indigo.shade300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Computer Society",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text("BREAKFAST EVENT"),
                      subtitle: Text(
                          "Come and taste delicious food with our members!"),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/kahveci-efendi.jpg",
                            scale: 6.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Kahveci Efendi Kızılay\n\nAşkabat Cad. No:17/B\nÇankaya/Ankara",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.assistant_direction_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("10:00")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.lightBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("09.01.2022")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Card(
                          child: Text(
                            "Join Event",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )),
                  ],
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 450.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
      //  StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(currentUserID)
      //       .collection('following_coms')
      //       .snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final coms = snapshot.data?.docs;
      //     return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: ,);
      // ),
    );
  }
}
