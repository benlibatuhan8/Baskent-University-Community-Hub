import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/event.dart';
import 'package:uuid/uuid.dart';

class Event_Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadEvent(String event_name, String community_name,
      String location, DateTime date, String description) async {
    String event_id = const Uuid().v1();
    String res = "Some error occured";
    try {
      Event event = new Event(
          event_id: event_id,
          participants: [],
          name: event_name,
          community_name: community_name,
          location: location,
          date: date,
          description: description);
      _firestore
          .collection('communities')
          .doc(community_name)
          .collection("events")
          .doc(event_id)
          .set(event.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
