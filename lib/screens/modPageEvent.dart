import 'package:comhub/services/event_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModPageEventScreen extends StatefulWidget {
  @override
  modPageEventState createState() => modPageEventState();
}

class modPageEventState extends State<ModPageEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Computer Society'),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade700,
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                          color: Colors.white,
                          child: Text("Create Event",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.black),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                color: Colors.indigo.shade500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                    ),
                    Card(
                      child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ex. Meeting Organization",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                color: Colors.indigo.shade500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                    ),
                    Card(
                      child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ex. Come and meet our members",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                color: Colors.indigo.shade500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Date",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                    ),
                    Card(
                      child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ex. 07.01.2022",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                color: Colors.indigo.shade500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                    ),
                    Card(
                      child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ex. 1-2 Hours",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              child: Card(
                color: Colors.indigo.shade500,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                    ),
                    Card(
                      child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ex. İhsan Doğramacı Conference Hall",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none)),
                    )
                  ],
                ),
              ),
            ),
            TextButton(onPressed: () {}, child: Text("Submit"))
          ],
        ));
  }
}
