import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/chatMessageModel.dart';
import 'package:comhub/screens/assets.dart';
import 'package:comhub/screens/home.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/widgets/drawer.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../routes/route.dart';
import '../services/user_services.dart';
import 'comlistpage.dart';

var loggedInUser;

class adminpageScreen extends StatefulWidget {
  @override
  adminpageState createState() => adminpageState();
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

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var currentUser = FirebaseAuth.instance.currentUser;
List<String>? result = currentUser!.email?.split("@");
String currentUserID = result![0];

class adminpageState extends State<adminpageScreen> {
  final _auth = FirebaseAuth.instance;

  late String messageText;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final comController = TextEditingController();
    late String comId;
    late String userId;
    String dropdownvalue = '';
    String dropdownvalueforcomms = '';

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Ayarları',
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo.shade700,
          elevation: 0,
          // give the app bar rounded corners
        ),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            // construct the profile details widget here

            // the tab bar with two items
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Colors.indigo.shade700,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.remove_circle,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.chat,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.chat,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget

                  Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(
                                "Users",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              /*Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.modpage2);
                                },
                                child: Text(
                                  'Create New!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),*/
                            ],
                          ),
                          Divider(),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final users = snapshot.data!.docs.map((doc) {
                                  final data = doc.data();
                                  return data['user_id'] as String;
                                }).toList();

                                return DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  items: users,
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Select User",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 0, 0),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                      String isModControlModCom;
                                      String userName;
                                      String comName;
                                      String isModControlUserType;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(newValue),
                                          content: Text(
                                              'Bu kullanıcı hakkında ne yapmak istiyorsunuz?'),
                                          actions: <Widget>[
                                            //1.SAYFA TEXT BUTTON
                                            //**********************
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Text("İptal")),

                                            //2.SAYFA TEXT BUTTON
                                            //**********************
                                            TextButton(
                                                onPressed:
                                                    () => showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title:
                                                                Text(newValue),
                                                            content: Text(
                                                                'Which community do you want to set a moderator?'),
                                                            actions: <Widget>[
                                                              FutureBuilder(
                                                                  future:
                                                                      getComms(),
                                                                  builder: (BuildContext
                                                                          context,
                                                                      AsyncSnapshot<
                                                                              dynamic>
                                                                          snapshot) {
                                                                    List<Widget>
                                                                        children;
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      List<String>
                                                                          items =
                                                                          [];

                                                                      List
                                                                          Items =
                                                                          snapshot
                                                                              .data;
                                                                      Items.forEach(
                                                                          (element) {
                                                                        items.add(
                                                                            element.toString());
                                                                      });

                                                                      return DropdownSearch<
                                                                          String>(
                                                                        mode: Mode
                                                                            .BOTTOM_SHEET,
                                                                        items:
                                                                            items,
                                                                        dropdownSearchDecoration:
                                                                            InputDecoration(
                                                                          labelText:
                                                                              "Select Society",
                                                                          contentPadding: EdgeInsets.fromLTRB(
                                                                              12,
                                                                              12,
                                                                              0,
                                                                              0),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                        ),
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            dropdownvalueforcomms =
                                                                                newValue!;
                                                                          });
                                                                        },
                                                                        selectedItem:
                                                                            "Please select a community",
                                                                        showSearchBox:
                                                                            true,
                                                                        searchFieldProps:
                                                                            TextFieldProps(
                                                                          decoration:
                                                                              InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            contentPadding: EdgeInsets.fromLTRB(
                                                                                12,
                                                                                12,
                                                                                8,
                                                                                0),
                                                                            labelText:
                                                                                "Search a Society",
                                                                          ),
                                                                        ),
                                                                        popupTitle:
                                                                            Container(
                                                                          height:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Theme.of(context).primaryColorDark,
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              topRight: Radius.circular(20),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'Topluluklar',
                                                                              style: TextStyle(
                                                                                fontSize: 24,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        popupShape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(24),
                                                                            topRight:
                                                                                Radius.circular(24),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      children =
                                                                          const <
                                                                              Widget>[
                                                                        SizedBox(
                                                                          width:
                                                                              60,
                                                                          height:
                                                                              60,
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 16),
                                                                          child:
                                                                              Text('Awaiting result...'),
                                                                        )
                                                                      ];
                                                                    }
                                                                    return Center(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children:
                                                                            children,
                                                                      ),
                                                                    );
                                                                  }),
                                                              TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          'Cancel'),
                                                                  child: Text(
                                                                      "Cancel")),
                                                              TextButton(
                                                                onPressed:
                                                                    () async =>
                                                                        {
                                                                  print(
                                                                      dropdownvalueforcomms),
                                                                  userId =
                                                                      newValue,
                                                                  comId = await FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'communities')
                                                                      .where(
                                                                          'name',
                                                                          isEqualTo:
                                                                              dropdownvalueforcomms)
                                                                      .get()
                                                                      .then((value) => value
                                                                          .docs[
                                                                              0]
                                                                              [
                                                                              "id"]
                                                                          .toString()),
                                                                  print(comId),
                                                                  print(userId),
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(
                                                                          userId)
                                                                      .update({
                                                                    'mod_com':
                                                                        comId
                                                                  }),
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(
                                                                          userId)
                                                                      .update({
                                                                    'user_type':
                                                                        'mod'
                                                                  }),
                                                                  Navigator.pop(
                                                                      context),
                                                                  Navigator.pop(
                                                                      context)
                                                                },
                                                                child: Text(
                                                                    "Complete"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                child: Text(
                                                    "Set this user to society moderator")),
                                            TextButton(
                                                onPressed: () async => {
                                                      isModControlModCom =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .where('user_id',
                                                                  isEqualTo:
                                                                      newValue)
                                                              .get()
                                                              .then((value) => value
                                                                  .docs[0][
                                                                      "mod_com"]
                                                                  .toString()),
                                                      isModControlUserType =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .where('user_id',
                                                                  isEqualTo:
                                                                      newValue)
                                                              .get()
                                                              .then((value) => value
                                                                  .docs[0][
                                                                      "user_type"]
                                                                  .toString()),
                                                      print(
                                                          isModControlUserType),
                                                      userName =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .where('user_id',
                                                                  isEqualTo:
                                                                      newValue)
                                                              .get()
                                                              .then((value) => value
                                                                  .docs[0][
                                                                      "user_name"]
                                                                  .toString()),
                                                      print(userName),

                                                      print(isModControlModCom),
                                                      // KULLANICI MOD İSE İF KONTROLU
                                                      // ************************
                                                      if (isModControlModCom !=
                                                              "" &&
                                                          isModControlUserType ==
                                                              "mod")
                                                        {
                                                          comName = await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'communities')
                                                              .where('id',
                                                                  isEqualTo:
                                                                      isModControlModCom)
                                                              .get()
                                                              .then((value) => value
                                                                  .docs[0]
                                                                      ["name"]
                                                                  .toString()),
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: Text(
                                                                  userName),
                                                              content: Text(
                                                                  'Kullanıcının moderatörü olduğu topluluk: ' +
                                                                      comName +
                                                                      "\n\n" +
                                                                      "Bu kullanıcıyı moderatörlükten almak istiyor musunuz?"),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child: Text(
                                                                        "İptal")),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async =>
                                                                          {
                                                                    userId =
                                                                        newValue,
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(
                                                                            userId)
                                                                        .update({
                                                                      'mod_com':
                                                                          ""
                                                                    }),
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(
                                                                            userId)
                                                                        .update({
                                                                      'user_type':
                                                                          'user'
                                                                    }),
                                                                    Navigator.pop(
                                                                        context),
                                                                    Navigator.pop(
                                                                        context)
                                                                  },
                                                                  child: Text(
                                                                      "Evet"),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        }
                                                      else
                                                        {
                                                          showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: Text(
                                                                  newValue),
                                                              content: Text(
                                                                  'Bu kullanıcı herhangi bir topluluğun moderatörü değil.'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        "Tamam"))
                                                              ],
                                                            ),
                                                          )
                                                        },
                                                    },
                                                child:
                                                    Text("Moderatörlüğünü Al")),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  selectedItem: "Please select a user",
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Find user",
                                    ),
                                  ),
                                  popupTitle: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Users',
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
                              })
                        ],
                      )),

                  // second tab bar view widget
                  Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(
                                "Users",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              /*Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.modpage2);
                                },
                                child: Text(
                                  'Create New!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),*/
                            ],
                          ),
                          Divider(),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final users = snapshot.data!.docs.map((doc) {
                                  final data = doc.data();
                                  return data['user_id'] as String;
                                }).toList();

                                return DropdownSearch<String>(
                                  mode: Mode.BOTTOM_SHEET,
                                  items: users,
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Select User",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 0, 0),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(newValue),
                                          content: Text(
                                              'What do you want to do with this user? '),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Text("Cancel")),
                                            //2.SAYFA TEXT BUTTON
                                            //**********************
                                            TextButton(
                                                onPressed: () =>
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: Text(newValue),
                                                        content: Text(
                                                            'Which community do you want to set a moderator?'),
                                                        actions: <Widget>[
                                                          TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Enter a Community Name',
                                                            ),
                                                            controller:
                                                                comController,
                                                          ),
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Cancel'),
                                                              child: Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                            onPressed:
                                                                () async => {
                                                              print(
                                                                  comController
                                                                      .text),
                                                              userId = newValue,
                                                              comId = await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'communities')
                                                                  .where('name',
                                                                      isEqualTo:
                                                                          comController
                                                                              .text)
                                                                  .get()
                                                                  .then((value) => value
                                                                      .docs[0]
                                                                          ["id"]
                                                                      .toString()),
                                                              print(comId),
                                                              print(userId),
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(userId)
                                                                  .update({
                                                                'mod_com': comId
                                                              }),
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(userId)
                                                                  .update({
                                                                'user_type':
                                                                    'mod'
                                                              }),
                                                              Navigator.pop(
                                                                  context),
                                                              Navigator.pop(
                                                                  context)
                                                            },
                                                            child: Text(
                                                                "Complete"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                child: Text(
                                                    "Set this user to society moderator")),
                                          ],
                                        ),
                                      );
                                    });
                                  },
                                  selectedItem: "Please select a user",
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 12, 8, 0),
                                      labelText: "Find user",
                                    ),
                                  ),
                                  popupTitle: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Users',
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
                              })
                        ],
                      )),
                  // third tab bar view widget
                  Container(),
                  // four tab bar view widget
                  Container(
                    color: Colors.indigo.shade700,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Card(
                              child: SizedBox(
                                  height: 150.0,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n14/11/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\nChairperson selection  will be held on 20 December.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          SizedBox(
                            height: 5.0,
                          ),
                          Card(
                              child: SizedBox(
                                  height: 150.0,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\n02/12/2021",
                                        //textDirection: TextDirection.rtl,
                                        //textAlign: TextAlign.end,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "\nMember registration can be done by filling a form pusplished just now.",
                                            style: TextStyle(fontSize: 16.0),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ),

                  // third tab bar view widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
