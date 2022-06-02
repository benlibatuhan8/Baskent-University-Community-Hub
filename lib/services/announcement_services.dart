import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/announcement.dart';
import 'package:uuid/uuid.dart';

class Announcement_Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadAnnouncement(
      DateTime created_date, String description, String community_name) async {
    String res = "Some error occured";
    try {
      Announcement announcement = new Announcement(
          created_date: created_date,
          community_name: community_name,
          description: description);
      _firestore
          .collection('communities')
          .doc(community_name)
          .collection("announcements")
          .doc(description)
          .set(announcement.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}