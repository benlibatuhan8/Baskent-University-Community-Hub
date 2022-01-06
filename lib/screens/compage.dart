import 'dart:math';

import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/widgets/drawer.dart';

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
                  Container(
                    color: Colors.indigo.shade700,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (messages[index].messageType ==
                                              "receiver1" ||
                                          messages[index].messageType ==
                                              "receiver2" ||
                                          messages[index].messageType ==
                                              "receiver3"
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (messages[index].messageType ==
                                              "receiver"
                                          ? Colors.green
                                          : messages[index].messageType ==
                                                  "receiver"
                                              ? Colors.yellow
                                              : messages[index].messageType ==
                                                      "receiver"
                                                  ? Colors.blue
                                                  : Colors.white),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          messages[index].messageSender + "\n",
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                              color: (messages[index]
                                                          .messageType ==
                                                      "receiver1"
                                                  ? Colors.green
                                                  : messages[index]
                                                              .messageType ==
                                                          "receiver2"
                                                      ? Colors.orange
                                                      : messages[index]
                                                                  .messageType ==
                                                              "receiver3"
                                                          ? Colors.blue
                                                          : Colors.grey)),
                                        ),
                                        Text(
                                          messages[index].messageContent,
                                          style: TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, bottom: 10, top: 10),
                              height: 60,
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Write message...",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    backgroundColor: Colors.blue,
                                    elevation: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
