import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/login/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer, timer2;
  late bool canResendEmail = true;

  CountDownController controller = CountDownController();

  @override
  void initState() {
    try {
      user = auth.currentUser!;
      user.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
      super.initState();
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Verification",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification email has been sent to ${user.email}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            CircularCountDownTimer(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              isReverseAnimation: true,
              isReverse: true,
              duration: 300,
              fillColor: Colors.blueAccent[100]!,
              backgroundColor: Colors.blue[500],
              ringColor: Colors.grey[300]!,
              onComplete: () {
                List<String>? result = user.email?.split("@");
                String currentUserID = result![0];
                users.doc(currentUserID).delete().then((value) {
                  FirebaseAuth.instance.currentUser!.delete();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(
                Icons.email,
                size: 32,
              ),
              label: Text(
                'Resent Email',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                if (canResendEmail == true) {
                  user.sendEmailVerification();
                  canResendEmail = false;
                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    title: Text(
                      "You can't resent email more than twice",
                      textAlign: TextAlign.center,
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future checkEmailVerified() async {
    var user2 = auth.currentUser!;
    await user2.reload();
    if (user2.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
