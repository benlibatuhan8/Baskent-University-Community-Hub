import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/services/regexp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/services/user_services.dart';

class RegisterState {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<Users>(
            fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  static final provider =
      Provider.autoDispose<RegisterState>((ref) => RegisterState(ref.read));
  static final isButtonLoading = StateProvider.autoDispose<bool>((_) => false);

  final Reader _reader;

  RegisterState(this._reader);

  Future<void> addUser(Users user, BuildContext context) async {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    if (!validateUserId(user.user_id)) {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Your student id must consist 8 digits",
        ),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (!validatePassword(user.password)) {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Your password needs to",
          style: TextStyle(color: Colors.red.shade400),
        ),
        content: Text(
          "-Include both upper and lower characters \n-Be at least 8 characters long.",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: user.user_id + "@ogr.baskent.edu.tr",
                password: user.password)
            .then((kullanici) {
          var newRef = users.doc(user.user_id);
          return newRef.set({
            'user_id': newRef.id,
            'password': user.password,
            'user_type': user.user_type,
          });
        });
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Registiration Successful"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"))
                ]);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Widget okButton = TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
          AlertDialog alert = AlertDialog(
            title: Text("Student id already in use"),
            actions: [
              okButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
      } catch (e) {
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
        AlertDialog alert = AlertDialog(
          title: Text(e.toString()),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }
  }
}
