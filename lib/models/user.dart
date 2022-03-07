import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Users {
  final String password;
  late final String user_id;
  final bool user_type;
  late final String card_url;
  final List following_comms;
  final String department;
  final String mod_com;
  final String user_name;

  Users({
    required this.department,
    required this.following_comms,
    required this.user_name,
    required this.mod_com,
    required this.password,
    required this.card_url,
    required this.user_type,
    required this.user_id,
  });

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
        user_name: snapshot["user_name"],
        following_comms: snapshot["following_comms"],
        mod_com: snapshot["mod_com"],
        department: snapshot["department"],
        card_url: snapshot["card_url"],
        user_id: snapshot["user_id"],
        user_type: snapshot["user_type"],
        password: snapshot["password"]);
  }

  Map<String, dynamic> toJson() => {
        'department': department,
        'following_comms': following_comms,
        'mod_com': mod_com,
        'user_name': user_name,
        'card_url': card_url,
        'user_id': user_id,
        'user_type': user_type,
        'password': password,
      };
}
