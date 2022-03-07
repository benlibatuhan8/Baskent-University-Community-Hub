import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Event {
  final String event_id;
  final String name;
  final String community_name;
  final List participants;
  final String location;
  final DateTime date;
  final String description;

  Event({
    required this.event_id,
    required this.participants,
    required this.name,
    required this.community_name,
    required this.location,
    required this.date,
    required this.description,
  });

  static Event fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Event(
      community_name: snapshot["community_name"],
      date: snapshot["date"],
      description: snapshot["description"],
      event_id: snapshot["event_id"],
      location: snapshot["location"],
      name: snapshot["name"],
      participants: snapshot["participants"],
    );
  }

  Map<String, dynamic> toJson() => {
        'event_id': event_id,
        'community_name': community_name,
        'date': date,
        'description': description,
        'location': location,
        'name': name,
        'participants': participants,
      };
}
