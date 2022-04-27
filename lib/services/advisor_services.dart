import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/screens/register/state/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routes/route.dart';
import '../screens/comlistpage.dart';

class Advisor_Service {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // Future<Users> getUserById(String userId) async {
  //   DocumentSnapshot documentSnapshot =
  //       await _firestore.collection("users").doc(userId).get();
  //   print(Users.fromSnap(documentSnapshot));
  //   return Users.fromSnap(documentSnapshot);
  // }asdasdfasdf

  Future<void> signUpAdvisor(
      String advisor_mail, String password, String modcom) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: advisor_mail, password: password)
        .then((kullanici) async {
      Users user = new Users(
        department: '',
        //following_comms: [],
        user_name: '',
        mod_com: modcom,
        password: password,
        card_url: '',
        user_type: "advisor",
        user_id: advisor_mail,
      );
      await _firestore.collection("users").doc(user.user_id).set(user.toJson());
    });
  }

  Future<void> signInAdvisor(
      Users user, Widget okButton, BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: user.user_id,
      password: user.password,
    )
        .then((kullanici) {
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        if (DateTime.now().isAfter(FirebaseAuth
            .instance.currentUser!.metadata.creationTime!
            .add(const Duration(minutes: 5)))) {
          AlertDialog alert = AlertDialog(
            title: Text(
                "You must verify your account in time please register again"),
            actions: [
              okButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          var doc = FirebaseAuth.instance.currentUser!.email!;
          FirebaseFirestore.instance.collection('users').doc(doc).delete();
          FirebaseAuth.instance.currentUser!.delete();
        } else {
          AlertDialog alert = AlertDialog(
            title: Text(
                "You must verify your account before the timeout Hury UPP!! "),
            actions: [
              okButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.home, (route) => false);
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => ChatScreen()));
      }
    });
  }

  Future<void> updateUser(String user_id, String password) {
    return _firestore
        .doc(user_id)
        .update({
          'password': password,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
