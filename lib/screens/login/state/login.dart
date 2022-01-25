import 'package:comhub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comhub/routes/route.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:comhub/services/user_services.dart';

import '../../chat.dart';
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: user.user_id + "@mail.baskent.edu.tr",
              password: user.password)
          .then((kullanici) {
        if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
          AlertDialog alert = AlertDialog(
            title: Text("You must verify your account"),
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
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.home, (route) => false);
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => ChatScreen()));
        }
      });
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
          title: Text("User not found"),
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
          title: Text("Invalid password"),
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
