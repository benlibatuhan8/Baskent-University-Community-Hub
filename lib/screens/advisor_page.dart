import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/models/dummycom.dart';
import 'package:comhub/models/dummyremove_requests.dart';
import 'package:comhub/models/dummyuser.dart';
import 'package:comhub/screens/assets.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/verify.dart';
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

class AdvisorPageScreen extends StatefulWidget {
  @override
  AdvisorPageState createState() => AdvisorPageState();
}

class AdvisorPageState extends State<AdvisorPageScreen> {
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
        Users userfields = await User_Service().getUserById(currentUser?.email);

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
                              icon: Icon(Icons.person),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.person_off,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.person,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.person_add,
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
                                      "Members",
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
                                                                        "user_id"),
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
                                                                          'Removing User!!!'),
                                                                      content: Text("Are you sure you want to remove member " +
                                                                          participants[index]
                                                                              .get("user_id") +
                                                                          " from the society"),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                            onPressed: () => Navigator.pop(context,
                                                                                'Cancel'),
                                                                            child:
                                                                                Text("Cancel")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              String userId = participants[index].get("user_id");
                                                                              print(userId);
                                                                              String comId = await FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: currentUser?.email).get().then((value) => value.docs[0]["mod_com"].toString());
                                                                              print(comId);
                                                                              String comName = await FirebaseFirestore.instance.collection('communities').where('id', isEqualTo: comId).get().then((value) => value.docs[0]["name"].toString());
                                                                              print(comName);
                                                                              FirebaseFirestore.instance.collection('communities').doc(comName).collection('participants').doc(userId).delete();
                                                                              FirebaseFirestore.instance.collection('users').doc(userId).collection('following_coms').doc(comId).delete();
                                                                            },
                                                                            child:
                                                                                Text("Remove")),
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

                          // second tab bar view widget
                          Container(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Remove Requests",
                                      style: TextStyle(
                                          fontSize: 26,
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
                                        .collection('remove_requests')
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
                                      final remove_requests =
                                          snapshot.data?.docs;

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
                                                              onPressed:
                                                                  () async {
                                                                String comId =
                                                                    remove_requests![
                                                                            index]
                                                                        .get(
                                                                            "com_id");
                                                                print(
                                                                    "ComId: " +
                                                                        comId);
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
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext context) => AlertDialog(
                                                                        title: Text(
                                                                            "User Information"),
                                                                        content: Text('User ID: ' +
                                                                            remove_requests[index].get(
                                                                                "user_id") +
                                                                            "\n\n" +
                                                                            "Society: " +
                                                                            comName),
                                                                        actions: <
                                                                            Widget>[]));
                                                              },
                                                              child: Text(
                                                                remove_requests![
                                                                        index]
                                                                    .get(
                                                                        "user_id"),
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
                                                        // Text(
                                                        //   remove_requests[index]
                                                        //       .get("com_id"),
                                                        //   textDirection:
                                                        //       TextDirection.ltr,
                                                        //   style:
                                                        //       TextStyle(fontSize: 18.0),
                                                        // ),
                                                        Spacer(),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              String comId =
                                                                  remove_requests[
                                                                          index]
                                                                      .get(
                                                                          "com_id");
                                                              print("ComId: " +
                                                                  comId);
                                                              String userId =
                                                                  remove_requests[
                                                                          index]
                                                                      .get(
                                                                          'user_id');
                                                              String comName = await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .where('id',
                                                                      isEqualTo:
                                                                          comId)
                                                                  .get()
                                                                  .then((value) => value
                                                                      .docs[0][
                                                                          "name"]
                                                                      .toString());
                                                              print(
                                                                  "ComName: " +
                                                                      comName);

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .doc(comName)
                                                                  .collection(
                                                                      'remove_requests')
                                                                  .doc(userId)
                                                                  .delete();

                                                              // var collection =
                                                              //     FirebaseFirestore
                                                              //         .instance
                                                              //         .collection(
                                                              //             'remove_requests');
                                                              // var snapshot = await collection
                                                              //     .where(
                                                              //         'com_id',
                                                              //         isEqualTo:
                                                              //             comId)
                                                              //     .where(
                                                              //         'user_id',
                                                              //         isEqualTo:
                                                              //             userId)
                                                              //     .get();
                                                              // await snapshot
                                                              //     .docs
                                                              //     .first
                                                              //     .reference
                                                              //     .delete();
                                                            },
                                                            icon: Icon(
                                                                Icons.cancel)),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              String comId =
                                                                  remove_requests[
                                                                          index]
                                                                      .get(
                                                                          "com_id");
                                                              print("ComId: " +
                                                                  comId);
                                                              String userId =
                                                                  remove_requests[
                                                                          index]
                                                                      .get(
                                                                          'user_id');
                                                              print("UserID: " +
                                                                  userId);
                                                              String comName = await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .where('id',
                                                                      isEqualTo:
                                                                          comId)
                                                                  .get()
                                                                  .then((value) => value
                                                                      .docs[0][
                                                                          "name"]
                                                                      .toString());
                                                              print(
                                                                  "ComName: " +
                                                                      comName);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .doc(comName)
                                                                  .collection(
                                                                      'participants')
                                                                  .doc(userId)
                                                                  .delete();
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(userId)
                                                                  .collection(
                                                                      'following_coms')
                                                                  .doc(comId)
                                                                  .delete();

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .doc(comName)
                                                                  .collection(
                                                                      'remove_requests')
                                                                  .doc(userId)
                                                                  .delete();

                                                              // var collection =
                                                              //     FirebaseFirestore
                                                              //         .instance
                                                              //         .collection(
                                                              //             'remove_requests');
                                                              // var snapshot = await collection
                                                              //     .where(
                                                              //         'com_id',
                                                              //         isEqualTo:
                                                              //             comId)
                                                              //     .where(
                                                              //         'user_id',
                                                              //         isEqualTo:
                                                              //             userId)
                                                              //     .get();
                                                              // await snapshot
                                                              //     .docs
                                                              //     .first
                                                              //     .reference
                                                              //     .delete();
                                                            },
                                                            icon: Icon(
                                                                Icons.check))
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
                                      "Members",
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
                                                                        "user_id"),
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
                                                                          'Removing User!!!'),
                                                                      content: Text("Are you sure you want to remove member " +
                                                                          participants[index]
                                                                              .get("user_id") +
                                                                          " from the society"),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                            onPressed: () => Navigator.pop(context,
                                                                                'Cancel'),
                                                                            child:
                                                                                Text("Cancel")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              String comId = await FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: currentUserID).get().then((value) => value.docs[0]["mod_com"].toString());
                                                                              print("ComId: " + comId);
                                                                              String userId = participants[index].get("user_id");
                                                                              print("UserId: " + userId);
                                                                              DummyRemoveRequests dummyRemoveRequests = new DummyRemoveRequests(user_id: userId, com_id: comId);
                                                                              FirebaseFirestore.instance.collection('remove_requests').doc(userId).set(dummyRemoveRequests.toJson());
                                                                              Navigator.pop(context, 'Cancel');
                                                                            },
                                                                            child:
                                                                                Text("Remove")),
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
                          Container(
                              //   alignment: Alignment.topCenter,
                              //   child: Column(
                              //     children: [
                              //       SizedBox(
                              //         height: 5.0,
                              //       ),
                              //       Row(
                              //         children: [
                              //           Text(
                              //             "Requests",
                              //             style: TextStyle(
                              //                 fontSize: 22,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontStyle: FontStyle.italic),
                              //           ),
                              //         ],
                              //       ),
                              //       SizedBox(
                              //         height: 5.0,
                              //       ),
                              //       Container(
                              //         height: 490,
                              //         child: StreamBuilder(
                              //           stream: FirebaseFirestore.instance
                              //               .collection('communities')
                              //               .doc(snapshot.data.toString())
                              //               .collection('join_requests')
                              //               .snapshots(),
                              //           builder: (context,
                              //               AsyncSnapshot<
                              //                       QuerySnapshot<
                              //                           Map<String, dynamic>>>
                              //                   snapshot) {
                              //             if (snapshot.connectionState ==
                              //                 ConnectionState.waiting) {
                              //               return const Center(
                              //                 child: CircularProgressIndicator(),
                              //               );
                              //             }
                              //             final join_requests = snapshot.data?.docs;

                              //             return ListView.builder(
                              //               itemCount: snapshot.data!.docs.length,
                              //               itemBuilder: (ctx, index) => Container(
                              //                 margin: EdgeInsets.symmetric(),
                              //                 child: Card(
                              //                   child: Column(
                              //                     //height: 120,
                              //                     children: [
                              //                       Container(
                              //                         height: 80,
                              //                         child: Card(
                              //                           child: Row(
                              //                             children: [
                              //                               Container(
                              //                                 width: 250,
                              //                                 child: Expanded(
                              //                                   child: TextButton(
                              //                                     onPressed: () {},
                              //                                     child: Text(
                              //                                       join_requests![
                              //                                               index]
                              //                                           .get(
                              //                                               "user_id"),
                              //                                       textDirection:
                              //                                           TextDirection
                              //                                               .ltr,
                              //                                       style: TextStyle(
                              //                                           fontSize:
                              //                                               18.0),
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                               Spacer(),
                              //                               IconButton(
                              //                                 onPressed: () async {
                              //                                   String userId =
                              //                                       join_requests[
                              //                                               index]
                              //                                           .get(
                              //                                               "user_id");
                              //                                   print("UserId: " +
                              //                                       userId);
                              //                                   String comId = await FirebaseFirestore
                              //                                       .instance
                              //                                       .collection(
                              //                                           'users')
                              //                                       .where(
                              //                                           'user_id',
                              //                                           isEqualTo:
                              //                                               currentUserID)
                              //                                       .get()
                              //                                       .then((value) => value
                              //                                           .docs[0][
                              //                                               "mod_com"]
                              //                                           .toString());
                              //                                   print("ComId: " +
                              //                                       comId);
                              //                                   DummyCommunity
                              //                                       dummyCommunity =
                              //                                       new DummyCommunity(
                              //                                           id: comId);
                              //                                   FirebaseFirestore
                              //                                       .instance
                              //                                       .collection(
                              //                                           'users')
                              //                                       .doc(userId)
                              //                                       .collection(
                              //                                           'following_coms')
                              //                                       .doc(comId)
                              //                                       .set(dummyCommunity
                              //                                           .toJson());
                              //                                   String comName = await FirebaseFirestore
                              //                                       .instance
                              //                                       .collection(
                              //                                           'communities')
                              //                                       .where('id',
                              //                                           isEqualTo:
                              //                                               comId)
                              //                                       .get()
                              //                                       .then((value) => value
                              //                                           .docs[0]
                              //                                               ["name"]
                              //                                           .toString());
                              //                                   print("ComName: " +
                              //                                       comName);
                              //                                   FirebaseFirestore
                              //                                       .instance
                              //                                       .collection(
                              //                                           'communities')
                              //                                       .doc(comName)
                              //                                       .collection(
                              //                                           'join_requests')
                              //                                       .doc(userId)
                              //                                       .delete();
                              //                                   DummyUser
                              //                                       dummyUser =
                              //                                       new DummyUser(
                              //                                           user_id:
                              //                                               userId);
                              //                                   FirebaseFirestore
                              //                                       .instance
                              //                                       .collection(
                              //                                           'communities')
                              //                                       .doc(comName)
                              //                                       .collection(
                              //                                           'participants')
                              //                                       .doc(userId)
                              //                                       .set(dummyUser
                              //                                           .toJson());
                              //                                 },
                              //                                 icon:
                              //                                     Icon(Icons.check),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             );
                              //           },
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              ),

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
