// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Community_Services {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String> createCommunity({
//     required com_id,
//     required description,
//     required members,
//     required mods,
//     required events,
//     required com_form,
//     required logo_image,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty ||
//           password.isNotEmpty ||
//           username.isNotEmpty ||
//           bio.isNotEmpty ||
//           file != null) {
//         // registering user in auth with email and password
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         String photoUrl = await StorageMethods()
//             .uploadImageToStorage('profilePics', file, false);

//         model.User _user = model.User(
//           username: username,
//           uid: cred.user!.uid,
//           photoUrl: photoUrl,
//           email: email,
//           bio: bio,
//           followers: [],
//           following: [],
//         );

//         // adding user in our database
//         await _firestore
//             .collection("users")
//             .doc(cred.user!.uid)
//             .set(_user.toJson());

//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }
// }
