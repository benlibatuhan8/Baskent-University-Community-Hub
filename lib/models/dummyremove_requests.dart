import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DummyRemoveRequests {
  final String user_id;
  final String com_id;
  

  const DummyRemoveRequests({
    required this.user_id,
    required this.com_id,
    
  });

  static DummyRemoveRequests fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DummyRemoveRequests(
      user_id: snapshot["user_id"],
      com_id: snapshot["com_id"],
      
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "com_id" : com_id,
        
      };
}