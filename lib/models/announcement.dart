import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Announcement {
  final DateTime created_date;
  final String description;
  final String community_name;

  Announcement(
      {required this.created_date,
      required this.description,
      required this.community_name});

  static Announcement fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Announcement(
        created_date: snapshot["created_date"],
        description: snapshot["description"],
        community_name: snapshot["community_name"]);
  }

  Map<String, dynamic> toJson() => {
        'created_date': created_date,
        'description': description,
        'community_name': community_name,
      };
}