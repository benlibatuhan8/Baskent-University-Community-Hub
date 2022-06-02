import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DummyUser {
  final String user_id;
  

  const DummyUser({
    required this.user_id,
    
  });

  static DummyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DummyUser(
      user_id: snapshot["user_id"],
      
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        
      };
}