import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/event.dart';
import 'package:uuid/uuid.dart';

class Event_Services {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Event> getEventById(String event_id) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(event_id).get();
    print(Event.fromSnap(documentSnapshot));
    return Event.fromSnap(documentSnapshot);
  }

  Future<String> uploadEvent(String event_name, String community_name,
      String location, DateTime date, String description) async {
    String event_id = event_name;
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