import 'dart:ffi';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Event {
  final String event_id;
  final String name;
  final String community_id;
  final List participants;
  final Location location;
  final DateTime date;

  final String description;

  Event({
    required this.event_id,
    required this.participants,
    required this.name,
    required this.community_id,
    required this.location,
    required this.date,
    required this.description,
  });
}
