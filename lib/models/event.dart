import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Event {
  final String id;
  final String name;
  final String community;
  final String location;
  final String date;
  final String hour;
  final String description;

  Event({
    required this.id,
    required this.name,
    required this.community,
    required this.location,
    required this.date,
    required this.hour,
    required this.description,
  });
}
