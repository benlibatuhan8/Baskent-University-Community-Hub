import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/screens/assets.dart';
import 'package:comhub/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../models/user.dart';
import '../routes/route.dart';
import '../services/user_services.dart';
import 'comlistpage.dart';

var loggedInUser;

class denememodpageScreen extends StatefulWidget {
  @override
  denememodpageState createState() => denememodpageState();
}

class denememodpageState extends State<denememodpageScreen> {
  final _auth = FirebaseAuth.instance;

  late String messageText;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    print(getCurrentUserModCom());
    super.initState();
  }

  Future getCurrentUserModCom() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<String>? result = user!.email?.split("@");
        String currentUserID = result![0];
        Users userfields = await User_Service().getUserById(currentUserID);

        var snap = await FirebaseFirestore.instance
            .collection("communities")
            .where('id', isEqualTo: userfields.mod_com)
            .get()
            .then((value) => value.docs[0]["name"]);
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
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<dynamic>(
        future:
            getCurrentUserModCom(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    snapshot.data.toString(),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.indigo.shade700,
                  elevation: 0,
                  // give the app bar rounded corners
                ),
                drawer: MyDrawer(),
                body: Column(
                  children: [
                    // construct the profile details widget here

                    // the tab bar with two items
                    SizedBox(
                      height: 50,
                      child: AppBar(
                        backgroundColor: Colors.indigo.shade700,
                        bottom: TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.event),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.announcement,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.chat,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.chat,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // create widgets for each tab bar here
                    Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget

                          Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Created Events",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Routes.modpage2);
                                        },
                                        child: Text(
                                          'Create New!',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 490,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('communities')
                                          .doc(snapshot.data.toString())
                                          .collection('events')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        final events = snapshot.data?.docs;

                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (ctx, index) =>
                                              Container(
                                            margin: EdgeInsets.symmetric(),
                                            child: Card(
                                              child: Column(
                                                //height: 120,
                                                children: [
                                                  Container(
                                                    height: 80,
                                                    child: Card(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 250,
                                                            child: Expanded(
                                                              child: TextButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                  events![index]
                                                                      .get(
                                                                          "event_id"),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.delete))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )),

                          // second tab bar view widget
                          Container(
                            color: Colors.indigo.shade700,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Card(
                                      child: SizedBox(
                                          height: 150.0,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\n14/11/2021",
                                                //textDirection: TextDirection.rtl,
                                                //textAlign: TextAlign.end,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "\nChairperson selection  will be held on 20 December.",
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Card(
                                      child: SizedBox(
                                          height: 150.0,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\n02/12/2021",
                                                //textDirection: TextDirection.rtl,
                                                //textAlign: TextAlign.end,
                                                textDirection:
                                                    TextDirection.ltr,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "\nMember registration can be done by filling a form pusplished just now.",
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ),
                          // third tab bar view widget
                          Container(),
                          // four tab bar view widget
                          Container(
                            color: Colors.indigo.shade700,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Card(
                                      child: SizedBox(
                                          height: 150.0,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\n14/11/2021",
                                                //textDirection: TextDirection.rtl,
                                                //textAlign: TextAlign.end,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "\nChairperson selection  will be held on 20 December.",
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Card(
                                      child: SizedBox(
                                          height: 150.0,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\n02/12/2021",
                                                //textDirection: TextDirection.rtl,
                                                //textAlign: TextAlign.end,
                                                textDirection:
                                                    TextDirection.ltr,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "\nMember registration can be done by filling a form pusplished just now.",
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ),

                          // third tab bar view widget
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
