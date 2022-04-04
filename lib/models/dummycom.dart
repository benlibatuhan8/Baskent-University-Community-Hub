import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DummyCommunity {
  final String id;
  final String name;

  const DummyCommunity({
    required this.id,
    required this.name,
  });

  static DummyCommunity fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DummyCommunity(id: snapshot["id"], name: snapshot["name"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
