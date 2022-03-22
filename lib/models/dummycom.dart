import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DummyCommunity {
  final String id;
  

  const DummyCommunity({
    required this.id,
    
  });

  static DummyCommunity fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DummyCommunity(
      id: snapshot["id"],
      
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        
      };
}