import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/community.dart';
import 'package:comhub/models/dummycom.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/mycomlistpage.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/models/community.dart';

import '../models/user.dart';
import '../services/user_services.dart';

class ComListPageScreen extends StatefulWidget {
  @override
  comListPageState createState() => comListPageState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var currentUser = FirebaseAuth.instance.currentUser;
List<String>? result = currentUser!.email?.split("@");
String currentUserID = result![0];

class comListPageState extends State<ComListPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Communities"),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.indigo.shade700,
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('communities').snapshots(),
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
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        // title: Text(),
                        content: Text('Do you want to join the ' +
                            coms![index].get("name")),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              User_Service user_service = new User_Service();
                              Users currUser =
                                  await user_service.getUserById(currentUserID);

                              _firestore
                                  .collection('communities')
                                  .doc(coms[index].get("name"))
                                  .collection('participants')
                                  .doc(currentUserID)
                                  .set(currUser.toJson());

                              DummyCommunity dummyCommunity =
                                  new DummyCommunity(
                                      id: coms[index].get('id'),
                                      name: coms[index].get('name'));

                              _firestore
                                  .collection('users')
                                  .doc(currentUserID)
                                  .collection('following_coms')
                                  .doc(coms[index].get('id'))
                                  .set(dummyCommunity.toJson());

                              Navigator.pop(context, 'Send Join Request');
                            },
                            //Navigator.pop(context, 'Request Join'),
                            child: const Text('Join Society'),
                          ),
                        ],
                      ),
                    ),
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
