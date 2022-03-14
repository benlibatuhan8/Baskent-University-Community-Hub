import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Community {
  final String com_id;
  final String description;
  final String name;
  final List members;
  final List mods;
  final List events;
  final Form com_form;
  final File logo_image;
  final List news;
  final List forms;

  const Community({
    required this.com_id,
    required this.description,
    required this.name,
    required this.members,
    required this.mods,
    required this.events,
    required this.com_form,
    required this.logo_image,
    required this.news,
    required this.forms,
  });

  static Community fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Community(
      com_id: snapshot["com_id"],
      description: snapshot["description"],
      name: snapshot["name"],
      members: snapshot["members"],
      mods: snapshot["mods"],
      events: snapshot["events"],
      news: snapshot["news"],
      com_form: snapshot["com_form"],
      logo_image: snapshot['logo_image'],
      forms: snapshot['forms'],
    );
  }

  Map<String, dynamic> toJson() => {
        "com_id": com_id,
        "description": description,
        "name":name,
        "members": members,
        "mods": mods,
        "events": events,
        "com_form": com_form,
        "logo_image": logo_image,
        "forms": forms
      };
}
