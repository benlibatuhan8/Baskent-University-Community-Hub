import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/services/advisor_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:comhub/services/user_services.dart';

import '../../verify.dart';

class LoginState {
  static final provider =
      Provider.autoDispose<LoginState>((ref) => LoginState(ref.read));
  static final isButtonLoading = StateProvider.autoDispose<bool>((_) => false);

  final Reader _reader;

  LoginState(this._reader);

  Future<void> login(Users user, BuildContext context) async {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    try {
      await User_Service().signInUser(user, okButton, context);
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        print(currentUser.email);
        List<String>? result = currentUser.email?.split("@");
        String currentUserID = result![0];
        User_Service user_service = new User_Service();
        Users currUser = await user_service.getUserById(currentUserID);
        print(currUser.user_type.toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertDialog alert = AlertDialog(
          title: Text("Kullanıcı bulunamadı"),
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
      } else if (e.code == 'wrong-password') {
        AlertDialog alert = AlertDialog(
          title: Text("Yanlış Şifre"),
          actions: [okButton],
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

  Future<void> loginAdvisor(Users user, BuildContext context) async {
    Widget okButton = TextButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    try {
      await Advisor_Service().signInAdvisor(user, okButton, context);
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        print(currentUser.email);
        User_Service user_service = new User_Service();
        Users currUser = await user_service.getUserById(user.user_id);
        print(currUser.user_type.toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertDialog alert = AlertDialog(
          title: Text("Kullanıcı bulunamadı"),
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
      } else if (e.code == 'wrong-password') {
        AlertDialog alert = AlertDialog(
          title: Text("Yanlış Şifre"),
          actions: [okButton],
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
