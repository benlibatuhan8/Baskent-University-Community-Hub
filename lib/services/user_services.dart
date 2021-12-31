import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User_Service {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<void> addUser(User user) {
    var newRef = users.doc(user.user_id);
    return newRef.set({
      'user_id': newRef.id,
      'password': user.password,
      'user_type': user.user_type,
    });
  }

  Future<User> getUserById(String userId) async {
    var user = await usersRef.doc(userId).get().then((value) {
      if (value.exists) {
        return value.data();
      } else {
        print("Veri bulunamadi");
      }
    });
    bool boolfunc() {
      if ("${user?.user_type}" == "true") {
        return true;
      } else
        return false;
    }

    User user2 = new User(
        password: "${user?.password}",
        user_type: boolfunc(),
        user_id: "${user?.user_id}");

    return user2;
  }

  Future<Map<String, dynamic>?> getUserList() async {
    var data = await usersRef.doc().get().then((value) {
      if (value.exists) {
        return value.data() as Map<String, dynamic>;
      } else {
        print("Veri bulunamadı");
      }
    });

    print("${data!['user_id']}");
    return data;
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
