import 'package:comhub/models/user.dart';
import 'package:comhub/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/main.dart';
import 'package:comhub/widgets/button.dart';
import 'package:comhub/screens/login/state/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade800,
          Colors.blue.shade900,
          Colors.blue.shade900
        ]) // LinearGradient
            ), //BoxDecoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/images/logo.png')
                ], // Widget
              ), //Column
            ), //Padding
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ] //BoxShadow
                              ), //BoXDecoration
                          child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white54))),
                                child: TextFormField(
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Username cant be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: 'Student ID',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 20.0, 10.0),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white54))),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Password cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                  ),
                                ),
                              )
                            ]),
                          )), //Container

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Consumer(builder: (context, ref, child) {
                          final state = ref.watch(LoginState.provider);
                          final isButtonLoading = false;
                          return ElevatedButton(
                            onPressed: () {
                              Users newUser = new Users(
                                  password: passwordController.text,
                                  user_type: false,
                                  user_id: usernameController.text);
                              state.login(newUser, context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade900),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)))),
                            child: isButtonLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text('Log in',
                                    style: TextStyle(color: Colors.white)),
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.register);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue.shade900),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)))),
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                      ),

                      //Padding
                    ]), //Container
                  ) //Expanded
                  ),
            )
          ], // <Widget>
        ), //Column
      ), //Container
    );
  }
}
