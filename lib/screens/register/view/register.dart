import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/screens/login/state/login.dart';
import 'package:comhub/screens/register/state/register.dart';
import 'package:comhub/services/user_services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

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

Future<List> getComms() async {
  List list = [];
  var snap = await FirebaseFirestore.instance
      .collection("communities")
      .orderBy('name')
      .get()
      .then((value) => value.docs.forEach((element) {
            list.add(element["name"]);
          }));
  // print(list);
  return list;
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  String? name = "";
  String? studentID = "";

  bool _switchValue = false;
  bool isAdvisor = false;
  String dropdownvalue = 'Item 1';

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
                        child: Column(
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  getImage(ImageSource.camera);
                                },
                                icon: Icon(Icons.camera_alt),
                                label: Text("Camera")),
                            TextButton.icon(
                                onPressed: () {
                                  getImage(ImageSource.gallery);
                                },
                                icon: Icon(Icons.photo),
                                label: Text("Gallery")),
                            Container(
                              child: Text(
                                "Student ID: " +
                                    studentID.toString() +
                                    "\nName: " +
                                    name.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )),
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
                            Divider(),
                            FutureBuilder(
                                future: getComms(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  List<Widget> children;
                                  if (snapshot.hasData) {
                                    List<String> items = [];

                                    List Items = snapshot.data;
                                    Items.forEach((element) {
                                      items.add(element.toString());
                                    });

                                    return DropdownSearch<String>(
                                      mode: Mode.BOTTOM_SHEET,
                                      items: items,
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: "Select Society",
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 12, 0, 0),
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      selectedItem: "Computer Society",
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(12, 12, 8, 0),
                                          labelText: "Search a Society",
                                        ),
                                      ),
                                      popupTitle: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Topluluklar',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      popupShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24),
                                        ),
                                      ),
                                    );
                                  } else {
                                    children = const <Widget>[
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: CircularProgressIndicator(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Awaiting result...'),
                                      )
                                    ];
                                  }
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: children,
                                    ),
                                  );
                                })
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
                          if (isAdvisor &&
                              passwordController.text ==
                                  passwordController2.text) {
                            state.addAdvisor(
                                passwordController.text,
                                usernameController.text,
                                context,
                                dropdownvalue);
                          } else if (passwordController.text ==
                              passwordController2.text) {
                            state.addUser(
                                passwordController.text,
                                studentID.toString(),
                                name.toString(),
                                context,
                                _im);
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

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
        _im = await pickedImage.readAsBytes();
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    parseImageText(scannedText);
    textScanning = false;
    setState(() {});
  }

  void parseImageText(String text) {
    RegExp numExp = RegExp(r"2[0-9]{7}");
    RegExp strExp = RegExp(r"ADI SOYADI.*\n");
    studentID = numExp.firstMatch(text)?.group(0).toString();
    name = strExp.firstMatch(text)?.group(0).toString();
    name = name.toString().replaceAll("ADI SOYADI", "");
  }
}
