import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModPageAnnScreen extends StatefulWidget {
  @override
  modPageAnnState createState() => modPageAnnState();
}

class modPageAnnState extends State<ModPageAnnScreen> {
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
                          child: Text("Create Announcement",
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
                              hintText: "Ex. Meeting Organization",
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
