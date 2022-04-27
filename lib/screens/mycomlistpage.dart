import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/community.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/mycomlistpage.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/models/community.dart';

import '../models/user.dart';
import '../services/user_services.dart';

class MyComListPageScreen extends StatefulWidget {
  @override
  MyComListPageState createState() => MyComListPageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var currentUser = FirebaseAuth.instance.currentUser;
List<String>? result = currentUser!.email?.split("@");
String currentUserID = result![0];

class MyComListPageState extends State<MyComListPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topluluklarım"),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.indigo.shade700,
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserID)
            .collection('following_coms')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final coms = snapshot.data?.docs;

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(),
              child: Card(
                child: Container(
                  height: 120,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.compage);
                      late String currCom = "0";
                      currCom = coms![index].get('id');
                      print(currCom);
                    },
                    child: Text(
                      coms![index].get("name"),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
