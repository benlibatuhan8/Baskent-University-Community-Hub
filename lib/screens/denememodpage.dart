import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/models/dummycom.dart';
import 'package:comhub/models/dummyremove_requests.dart';
import 'package:comhub/models/dummyuser.dart';
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
        List<String>? result = user.email?.split("@");
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
            .collection('following_comms');
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
              length: 3,
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
                                Icons.person,
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
                                        "Mevcut Etkinlikler",
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
                                          'Yeni Oluştur!',
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
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    selectedeventid =
                                                                    events[index]
                                                                        .get(
                                                                            "event_id");
                                                                print(
                                                                    selectedeventid);

                                                                String comId = await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .where(
                                                                        'user_id',
                                                                        isEqualTo:
                                                                            currentUserID)
                                                                    .get()
                                                                    .then((value) => value
                                                                        .docs[0]
                                                                            [
                                                                            "mod_com"]
                                                                        .toString());
                                                                String comName = await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'communities')
                                                                    .where('id',
                                                                        isEqualTo:
                                                                            comId)
                                                                    .get()
                                                                    .then((value) => value
                                                                        .docs[0]
                                                                            [
                                                                            "name"]
                                                                        .toString());
                                                                print(
                                                                    "ComName: " +
                                                                        comName);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'communities')
                                                                    .doc(
                                                                        comName)
                                                                    .collection(
                                                                        "events")
                                                                    .doc(
                                                                        selectedeventid)
                                                                    .delete();
                                                              },
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
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Mevcut Duyurular",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Routes.modpage3);
                                        },
                                        child: Text(
                                          'Yeni Oluştur!',
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
                                          .collection('announcements')
                                          .orderBy("created_date")
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
                                        final announcements =
                                            snapshot.data?.docs;

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
                                                    height: 200,
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
                                                                  announcements![
                                                                          index]
                                                                      .get(
                                                                          "description"),
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
                                                              onPressed: () async {
                                                                String
                                                                    selectedeventid =
                                                                    announcements[index]
                                                                        .get(
                                                                            "description");
                                                                print(
                                                                    selectedeventid);

                                                                String comId = await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .where(
                                                                        'user_id',
                                                                        isEqualTo:
                                                                            currentUserID)
                                                                    .get()
                                                                    .then((value) => value
                                                                        .docs[0]
                                                                            [
                                                                            "mod_com"]
                                                                        .toString());
                                                                String comName = await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'communities')
                                                                    .where('id',
                                                                        isEqualTo:
                                                                            comId)
                                                                    .get()
                                                                    .then((value) => value
                                                                        .docs[0]
                                                                            [
                                                                            "name"]
                                                                        .toString());
                                                                print(
                                                                    "ComName: " +
                                                                        comName);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'communities')
                                                                    .doc(
                                                                        comName)
                                                                    .collection(
                                                                        "announcements")
                                                                    .doc(
                                                                        selectedeventid)
                                                                    .delete();
                                                              },
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
                          // third tab bar view widget
                          //*************************
                          //****************************
                          Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Üyeler",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 490,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('communities')
                                        .doc(snapshot.data.toString())
                                        .collection('participants')
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
                                      final participants = snapshot.data?.docs;

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
                                                              onPressed: () {},
                                                              child: Text(
                                                                participants![
                                                                        index]
                                                                    .get(
                                                                        "user_name"),
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
                                                            onPressed: () => {
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      title: Text(
                                                                          'Topluluktan Çıkartma Talebi'),
                                                                      content: Text(
                                                                          participants[index].get("user_name") +
                                                                              " kullanıcısı için topluluktan çıkartma talebi oluşturmak istiyor musunuz?"),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                            onPressed: () => Navigator.pop(context,
                                                                                'Cancel'),
                                                                            child:
                                                                                Text("İptal")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              String comId = await FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: currentUserID).get().then((value) => value.docs[0]["mod_com"].toString());
                                                                              print("ComId: " + comId);

                                                                              String userId = participants[index].get("user_id");
                                                                              print("UserId: " + userId);
                                                                              //
                                                                              String userName = await FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: userId).get().then((value) => value.docs[0]["user_name"].toString());
                                                                              print("ComId: " + comId);
                                                                              //
                                                                              String comName = await FirebaseFirestore.instance.collection('communities').where('id', isEqualTo: comId).get().then((value) => value.docs[0]["name"].toString());
                                                                              DummyRemoveRequests dummyRemoveRequests = new DummyRemoveRequests(user_id: userId, com_id: comId, user_name: userName);
                                                                              FirebaseFirestore.instance.collection('communities').doc(comName).collection('remove_requests').doc(userId).set(dummyRemoveRequests.toJson());
                                                                              Navigator.pop(context, 'Cancel');
                                                                              
                                                                            },
                                                                            child:
                                                                                Text("Oluştur")),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                },
                                                            icon: Icon(
                                                                Icons.close))
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
                                ),
                              ],
                            ),
                          ),
                          //************************
                          //************************

                          // four tab bar view widget
                          //**************************
                          //******************************

                          //four tab view sonu
                          //****************************
                          //******************************
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
