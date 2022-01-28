import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/screens/assets.dart';
import 'package:comhub/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/widgets/drawer.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class ComPageScreen extends StatefulWidget {
  @override
  comPageState createState() => comPageState();
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Merhaba",
      messageType: "receiver2",
      messageSender: "Burak"),
  ChatMessage(
      messageContent: "Hoşgeldin Burak",
      messageType: "receiver1",
      messageSender: "Batuhan"),
  ChatMessage(
      messageContent: "Bugün etkinlik var mı ?",
      messageType: "sender",
      messageSender: "Oğuzhan"),
  ChatMessage(
      messageContent: "Hayır,yok.",
      messageType: "receiver3",
      messageSender: "İrem"),
];

class comPageState extends State<ComPageScreen> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Computer Society',
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
                      color: Colors.indigo.shade700,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '\nAbout Society...\n',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Center(
                              child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Computer Society",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                ListTile(
                                  title: Text("MEETING EVENT"),
                                  subtitle: Text(
                                      "First even of semester. Come and meet with members!"),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/basres1.jpg",
                                      scale: 25.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Avni Akyol Conference Hall\n\nFatih Sultan 06790\nEtimesgut/Ankara",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Icon(Icons.assistant_direction_rounded)
                                  ],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                )
                              ],
                            ),
                          )),
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
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MessagesStream(),
                        Container(
                          decoration: kMessageContainerDecoration,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: messageTextController,
                                  onChanged: (value) {
                                    messageText = value;
                                  },
                                  decoration: kMessageTextFieldDecoration,
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  messageTextController.clear();
                                  _firestore
                                      .collection('communities')
                                      .doc("Computer Society")
                                      .collection("chat")
                                      .add({
                                    'text': messageText,
                                    'sender': loggedInUser.email,
                                    'timestamp': FieldValue.serverTimestamp(),
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
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('communities')
          .doc("Computer Society")
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
  final String text;
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
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
