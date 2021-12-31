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

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: Column(children: [
        Stack(
          children: <Widget>[
            Container(
              color: SecondaryColor,
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-Clipart.png'),
                      radius: 35.0,
                    )),
                Container(
                    child: Text('Ahmet Oğuzhan KELEŞ',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1B4B3D),
                            fontFamily: 'Futura'))),
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
              Text("Change Password"),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.white54))),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Old Passoword",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none))),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.white54))),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: " New Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none)))
            ])),
      ]),
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
