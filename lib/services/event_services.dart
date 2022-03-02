// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:comhub/models/event.dart';

// Future<String> uploadEvent(String description, File file, String user_id,
//     DateTime date, String Location, String commnity_id) async {
//   // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
//   String res = "Some error occurred";
//   try {
//     String photoUrl =
//         await StorageMethods().uploadImageToStorage('posts', file, true);
//     String postId = const Uuid().v1(); // creates unique id based on time
//     Post post = Post(
//       description: description,
//       uid: uid,
//       username: username,
//       likes: [],
//       postId: postId,
//       datePublished: DateTime.now(),
//       postUrl: photoUrl,
//       profImage: profImage,
//     );
//     _firestore.collection('posts').doc(postId).set(post.toJson());
//     res = "success";
//   } catch (err) {
//     res = err.toString();
//   }
//   return res;
// }
