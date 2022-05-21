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
import 'package:intl/intl.dart';
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    comms[index].get("name"),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("communities")
                      .doc(comms[index].get("name"))
                      .collection("events")
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var events = snapshot2.data!.docs;
                    for (var i = 0; i < events.length; i++) {
                      if (DateTime.now()
                          .isAfter(events[i].get("date").toDate())) {
                        events.removeWhere((element) =>
                            element.get("date") == (events[i].get("date")));
                        i = 0;
                      }
                    }

                    // final events = snapshot2.data!.docs;
                    if (events.isEmpty) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Şuanda görüntülenecek etkinlik bulunmamaktadır.",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 350,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 450.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 2000),
                                viewportFraction: 0.8,
                              ),
                              itemCount: events.length,
                              itemBuilder: (BuildContext ctx, int index, _) {
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(events[index].get("date").toDate());
                                String formattedTime = DateFormat('kk:mm')
                                    .format(events[index].get("date").toDate());
                                print(formattedTime);
                                Color cardColor;
                                if (index % 2 == 1) {
                                  cardColor = Colors.indigo.shade700;
                                } else {
                                  cardColor = Colors.indigo.shade300;
                                }
                                ;
                                // if (DateTime.now().isAfter(
                                //     events[index].get("date").toDate())) {
                                //   if (index != snapshot2.data!.docs.length) {
                                //     index = index + 1;
                                //   }
                                // }

                                return Card(
                                  color: cardColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          events[index].get("name"),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 15),
                                        width: 270,
                                        height: 100,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            events[index].get("description"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            child: Card(
                                              color: Colors.yellow,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.access_time),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(formattedTime),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .calendar_today_outlined),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(formattedDate)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Card(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            LocationContainer(
                                              events: events,
                                              index: index,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Icon(Icons
                                                .assistant_direction_rounded)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
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

class LocationContainer extends StatelessWidget {
  const LocationContainer({
    Key? key,
    required this.events,
    required this.index,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> events;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Expanded(
          child: RichText(
              text: TextSpan(children: [
        TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            text: "Lokasyonu görmek için "),
        TextSpan(
            style: TextStyle(
              color: Colors.indigo.shade700,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            text: "tıklayın",
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                var url = events[index].get("location");
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
      ]))),
    );
  }
}