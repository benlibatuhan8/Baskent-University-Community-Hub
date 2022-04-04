import 'dart:io';

import 'package:comhub/models/user.dart';
import 'package:comhub/screens/login/state/login.dart';
import 'package:comhub/screens/register/state/register.dart';
import 'package:comhub/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);
late final _im;

_getFromCamera() async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(
    source: ImageSource.camera,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (_file != null) {
    _im = await _file.readAsBytes();
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _switchValue = false;
  bool isAdvisor = false;
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordController2 = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Register",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
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
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: !isAdvisor,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white54))),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Student ID cant be empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Student ID',
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isAdvisor,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white54))),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: usernameController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Advisor Mail cant be empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'Advisor mail',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              ),
                            ),
                            Text(
                                "Choose the community you would like to advise"),
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white54))),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password cant be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.white54))),
                      child: TextFormField(
                        controller: passwordController2,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password cant be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Repeat Password',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        ),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          _getFromCamera();
                        },
                        icon: Icon(Icons.photo),
                        label: Text(
                            "Please upload an image of your student card")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Are you an advisor ?"),
                        Switch.adaptive(
                            value: _switchValue,
                            onChanged: (_switchValue) => setState(() {
                                  this._switchValue = _switchValue;
                                  isAdvisor = !isAdvisor;
                                })),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(RegisterState.provider);
                    return ElevatedButton(
                        onPressed: () {
                          if (isAdvisor) {
                            // addAdvisor ekle
                          } else if (passwordController.text ==
                              passwordController2.text) {
                            state.addUser(passwordController.text,
                                usernameController.text, context, _im);
                          } else {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );

                            AlertDialog alert = AlertDialog(
                              title: Text("Passwords dont match"),
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
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
