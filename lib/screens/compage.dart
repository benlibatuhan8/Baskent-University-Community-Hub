// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/screens/admin_page.dart' as prefix;
import 'package:comhub/screens/assets.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/mycomlistpage.dart';
import 'package:comhub/services/user_services.dart';
import 'package:comhub/utils/Filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class ComPageScreen extends StatefulWidget {
  @override
  comPageState createState() => comPageState();
}

class comPageState extends State<ComPageScreen> {
  final _auth = FirebaseAuth.instance;

  late String messageText;
  final messageTextController = TextEditingController();

  comPageState();
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

  Future getCurrentComName() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        List<String>? result = user.email?.split("@");
        String currentUserID = result![0];
        Users userfields = await User_Service().getUserById(currentUserID);

        var snap = await FirebaseFirestore.instance
            .collection("communities")
            .where('id', isEqualTo: currentCom)
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
          future: getCurrentComName(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Widget> children;
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
                  children: <Widget>[
                    // construct the profile details widget here

                    // the tab bar with two items
                    SizedBox(
                      height: 50,
                      child: AppBar(
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        "Etkinlikler",
                                        style: TextStyle(
                                            fontSize: 42,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Spacer(),
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
                                              color: Colors.indigo.shade700,
                                              child: Column(
                                                //height: 120,
                                                children: [
                                                  Container(
                                                    height: 280,
                                                    child: Card(
                                                      child: Column(
                                                        children: [
                                                          // Etkinlik ismi BAŞLANGIÇ
                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Container(
                                                                width: 350,
                                                                child: Expanded(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      events![index]
                                                                          .get(
                                                                              "event_id"),
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              24.0,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          // Etkinlik ismi BİTİŞ
                                                          // Etkinlik açıklaması BAŞLANGIÇ

                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Container(
                                                                width: 350,
                                                                child: Expanded(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      events[index]
                                                                          .get(
                                                                              "description"),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.0,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          // Etkinlik açıklaması BİTİŞ
                                                          // Etkinlik tarihi BAŞLANGIÇ

                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Container(
                                                                width: 250,
                                                                child: Expanded(
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      events[index]
                                                                          .get(
                                                                              "date")
                                                                          .toDate()
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.0,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Spacer()
                                                            ],
                                                          ),
                                                          // Etkinlik tarihi BİTİŞ
                                                          // Etkinlik adresi BAŞLANGIÇ

                                                          Row(
                                                            children: [
                                                              Spacer(),
                                                              Container(
                                                                width: 250,
                                                                child: Expanded(
                                                                    child: RichText(
                                                                        text: TextSpan(children: [
                                                                  TextSpan(
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18.0),
                                                                      text:
                                                                          "Lokasyonu görmek için "),
                                                                  TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .indigo
                                                                            .shade700,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      text:
                                                                          "tıklayın",
                                                                      recognizer:
                                                                          TapGestureRecognizer()
                                                                            ..onTap =
                                                                                () async {
                                                                              var url = events[index].get("location");
                                                                              if (await canLaunch(url)) {
                                                                                await launch(url);
                                                                              } else {
                                                                                throw 'Could not launch $url';
                                                                              }
                                                                            }),
                                                                ]))),
                                                              ),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          // Etkinlik adresi BİTİŞ
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
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Duyurular",
                                      style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Container(
                                  height: 490,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('communities')
                                        .doc(snapshot.data.toString())
                                        .collection('announcements')
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
                                      final anns = snapshot.data?.docs;

                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (ctx, index) => Container(
                                          margin: EdgeInsets.symmetric(),
                                          child: Card(
                                            color: Colors.indigo.shade700,
                                            child: Column(
                                              //height: 120,
                                              children: [
                                                Container(
                                                  height: 150,
                                                  child: Card(
                                                    child: Column(
                                                      children: [
                                                        // Duyuru açıklaması BAŞLANGIÇ
                                                        Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(
                                                              width: 350,
                                                              child: Expanded(
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    anns![index]
                                                                        .get(
                                                                            "description"),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer()
                                                          ],
                                                        ),
                                                        // Duyuru açıklaması BİTİŞ

                                                        // Duyuru tarihi BAŞLANGIÇ

                                                        Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(
                                                              width: 250,
                                                              child: Expanded(
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    anns[index]
                                                                        .get(
                                                                            "created_date")
                                                                        .toDate()
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18.0,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer()
                                                          ],
                                                        ),
                                                        // Duyuru tarihi BİTİŞ
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
                            ),
                          ),

                          // third tab bar view widget
                          SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                MessagesStream(
                                  com: snapshot.data.toString(),
                                ),
                                Container(
                                  decoration: kMessageContainerDecoration,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          controller: messageTextController,
                                          onChanged: (value) {
                                            messageText = value;
                                          },
                                          decoration:
                                              kMessageTextFieldDecoration,
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          messageTextController.clear();
                                          _firestore
                                              .collection('communities')
                                              .doc(
                                                snapshot.data.toString(),
                                              )
                                              .collection("chat")
                                              .add({
                                            'text': messageText,
                                            'sender': loggedInUser.email,
                                            'timestamp':
                                                FieldValue.serverTimestamp(),
                                          });
                                        },
                                        child: Text(
                                          'Send',
                                          style: kSendButtonTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
    // return FutureBuilder(
    //   future: FirebaseFirestore.instance
    //       .collection("communities")
    //       .where('id', isEqualTo: currentCom)
    //       .get()
    //       .then((value) {
    //     value.docs.forEach((element) {
    //       element.get("name");
    //     });
    //   }),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     List<Widget> children;
    //     if (snapshot.hasData) {
    //       return
    //     } else {
    //       children = const <Widget>[
    //         SizedBox(
    //           width: 60,
    //           height: 60,
    //           child: CircularProgressIndicator(),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(top: 16),
    //           child: Text('Awaiting result...'),
    //         )
    //       ];
    //     }
    //     return Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: children,
    //       ),
    //     );
    //   },
    // );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.com}) : super(key: key);
  final String com;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('communities')
          .doc(com)
          .collection("chat")
          .orderBy("timestamp")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message.get("text");
          final messageSender = message.get("sender");

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  late final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: FutureBuilder(
                future: Filter().filter(text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;

                  if (snapshot.hasData) {
                    String? newText = snapshot.data;
                    return Text(
                      newText!,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black54,
                        fontSize: 15.0,
                      ),
                    );
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

                // child: Text(
                //   text,
                //   style: TextStyle(
                //     color: isMe ? Colors.white : Colors.black54,
                //     fontSize: 15.0,
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
