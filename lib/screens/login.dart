import 'package:comhub/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:comhub/main.dart';
import 'package:comhub/widgets/button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Image(
                    image: NetworkImage(
                        'https://www.baskent.edu.tr/img/logo_tr_standart.png'),
                  ),
                  Text(
                    "Community Hub",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
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
                          child: Column(children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white54))),
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Student ID",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none))),
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white54))),
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none)))
                          ])), //Container

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.home);
                        },
                        child: const Text("Login"),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.register);
                        },
                        child: const Text("Register"),
                      )
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
