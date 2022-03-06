import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/screens/register/state/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class User_Service {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(Users user) {
    var newRef = users.doc(user.user_id);
    return newRef.set({
      'user_id': newRef.id,
      'password': user.password,
      'user_type': user.user_type,
    });
  }

  Future<Users> getUserById(String userId) async {
    DocumentSnapshot documentSnapshot = await users.doc(userId).get();
    return Users.fromSnap(documentSnapshot);
  }

  Future<void> updateUser(String user_id, String password) {
    return users
        .doc(user_id)
        .update({
          'password': password,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
