import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';

class User_Service {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) {
    return users
        .add({'id': user.id, 'password': user.password, 'image': user.image})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
