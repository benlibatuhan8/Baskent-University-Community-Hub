import 'dart:ffi';
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

import '../models/user.dart';
import '../routes/route.dart';
import '../services/user_services.dart';
import 'comlistpage.dart';

var loggedInUser;

class adminpageScreen extends StatefulWidget {
  @override
  adminpageState createState() => adminpageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var currentUser = FirebaseAuth.instance.currentUser;
List<String>? result = currentUser!.email?.split("@");
String currentUserID = result![0];

class adminpageState extends State<adminpageScreen> {
  final _auth = FirebaseAuth.instance;

  late String messageText;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final comController = TextEditingController();
    late String comId;
    late String userId;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Page',
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade700,
          elevation: 0,
          // give the app bar rounded corners
        ),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
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
                                "Users",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              /*Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.modpage2);
                                },
                                child: Text(
                                  'Create New!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),*/
                            ],
                          ),
                          Container(
                            height: 490,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final users = snapshot.data?.docs;

                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (ctx, index) => Container(
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
                                                        onPressed: () =>
                                                            showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: Text(users![
                                                                    index]
                                                                .get(
                                                                    "user_id")),
                                                            content: Text(
                                                                'What do you want to do with this user? '),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: Text(
                                                                      "Cancel")),
                                                              //2.SAYFA TEXT BUTTON
                                                              //**********************
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      showDialog<
                                                                          String>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                AlertDialog(
                                                                          title:
                                                                              Text(users![index].get("user_id")),
                                                                          content:
                                                                              Text('Which community do you want to set a moderator?'),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextField(
                                                                              decoration: InputDecoration(
                                                                                border: OutlineInputBorder(),
                                                                                hintText: 'Enter a Community Name',
                                                                              ),
                                                                              controller: comController,
                                                                            ),
                                                                            TextButton(
                                                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                child: Text("Cancel")),
                                                                            TextButton(
                                                                              onPressed: () async => {
                                                                                print(comController.text),
                                                                                userId = users[index].get("user_id"),
                                                                                comId = await FirebaseFirestore.instance.collection('communities').where('name', isEqualTo: comController.text).get().then((value) => value.docs[0]["id"].toString()),
                                                                                print(comId),
                                                                                print(userId),
                                                                                FirebaseFirestore.instance.collection('users').doc(userId).update({
                                                                                  'mod_com': comId
                                                                                }),
                                                                                FirebaseFirestore.instance.collection('users').doc(userId).update({
                                                                                  'user_type': 'mod'
                                                                                }),
                                                                                Navigator.pop(context),
                                                                                Navigator.pop(context)
                                                                              },
                                                                              child: Text("Complete"),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                  child: Text(
                                                                      "Set this user to society moderator")),
                                                            ],
                                                          ),
                                                        ),
                                                        child: Text(
                                                          users![index]
                                                              .get("user_id"),
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          style: TextStyle(
                                                              fontSize: 18.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.delete))
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n14/11/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\nChairperson selection  will be held on 20 December.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n02/12/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "\nMember registration can be done by filling a form pusplished just now.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n14/11/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\nChairperson selection  will be held on 20 December.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n02/12/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "\nMember registration can be done by filling a form pusplished just now.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
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
  }
}
