import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Users {
  final String password;
  late final String user_id;
  final bool user_type;
  final String card_url;
  Users({
    required this.password,
    required this.card_url,
    required this.user_type,
    required this.user_id,
  });

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
        card_url: snapshot["card_url"],
        user_id: snapshot["user_id"],
        user_type: snapshot["user_type"],
        password: snapshot["password"]);
  }

  Map<String, Object?> toJson() {
    return {
      'card_url': card_url,
      'user_id': user_id,
      'user_type': user_type,
      'password': password,
    };
  }
}
