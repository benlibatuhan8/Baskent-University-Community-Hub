import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Users {
  late final String user_id;
  final String password;
  final String user_name;
  final String user_type;
  late final String card_url;
  final String department;
  final List following_comms;
  final List my_events;
  final String mod_com;

  Users({
    required this.user_id,
    required this.password,
    required this.user_name,
    required this.user_type,
    required this.card_url,
    required this.department,
    required this.following_comms,
    required this.my_events,
    required this.mod_com,
  });

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
      user_id: snapshot["user_id"],
      password: snapshot["password"],
      user_name: snapshot["user_name"],
      user_type: snapshot["user_type"],
      card_url: snapshot["card_url"],
      department: snapshot["department"],
      following_comms: snapshot["following_comms"],
      mod_com: snapshot["mod_com"],
      my_events: snapshot["my_events"],
    );
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
