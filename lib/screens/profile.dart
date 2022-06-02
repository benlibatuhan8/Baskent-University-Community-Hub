import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/user.dart';
import 'package:comhub/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/drawer.dart';

final appHeight = 650.0;
final appWidth = 350.0;
final topSectionHeight = 250.0;
final middleSectionHeight = 110.0;
final List<String> urls = [];

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var currentUser = FirebaseAuth.instance.currentUser;
List<String>? result = currentUser!.email?.split("@");
String currentUserID = result![0];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKeyProfile = GlobalKey<FormState>();
  String oldpassword = '';
  String newpassword = '';
  String confirmnewpassword = '';

  _submit() async {
    if (newpassword == confirmnewpassword) {
      final oldPassword = await FirebaseFirestore.instance
          .collection("users")
          .where('user_id', isEqualTo: currentUserID)
          .get()
          .then((value) => value.docs[0]["password"]);

      if (oldPassword == oldpassword) {
        print("lolsadgfasgfasdgfsdfgdsfg");
        User_Service().updateUser(currentUserID, newpassword);
        print(oldPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: topSectionHeight,
              ),
              Container(
                height: topSectionHeight,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff022711).withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/pp.png",
                      scale: 10.0,
                    ),
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(currentUserID)
                        .get()
                        .then((value) {
                      print(value.get("user_name"));
                      return value.get("user_name");
                    }),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        return Container(
                            child: Text(snapshot.data,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Futura')));
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    },
                  ),
                ])),
                decoration: BoxDecoration(
                    color: PrimaryColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70.0))),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ), //BoXDecoration
            child: Form(
              key: _formKeyProfile,
              child: Scrollbar(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...[
                              TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  hintText: 'Eski Şifreyi Giriniz',
                                  labelText: 'Eski Şifre',
                                ),
                                onChanged: (value) {
                                  oldpassword = value;
                                },
                                maxLines: 1,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  hintText: 'Yeni Şifrenizi Giriniz',
                                  labelText: 'Yeni Şifre',
                                ),
                                onChanged: (value) {
                                  newpassword = value;
                                },
                                maxLines: 1,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  hintText: 'Yeni Şifrenizi Tekrar Giriniz',
                                  labelText: 'Yeni Şifre Tekrar',
                                ),
                                onChanged: (value) {
                                  confirmnewpassword = value;
                                },
                                maxLines: 1,
                              ),
                              ElevatedButton(
                                  onPressed: _submit, child: Text("Onayla"))
                            ].expand(
                              (widget) => [
                                widget,
                                const SizedBox(
                                  height: 24,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String url;
  final int index;

  ImageWidget(this.url, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(this.url)),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      alignment: Alignment.center,
      width: 200.0,
    );
  }
}