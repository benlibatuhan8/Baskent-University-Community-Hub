import 'package:flutter/material.dart';

final appHeight = 650.0;
final appWidth = 350.0;
final topSectionHeight = 250.0;
final middleSectionHeight = 110.0;
final List<String> urls = [];

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu, color: PrimaryColor),
            onPressed: () {},
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileInfo("Profile Info"),
                  Stack(children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                        child: Text(''),
                        width: appWidth / 2,
                        height: middleSectionHeight,
                        decoration: BoxDecoration(
                          color: Color(0xffECFEF3),
                        ),
                      ),
                      Container(
                        child: Text(''),
                        width: appWidth / 2,
                        height: middleSectionHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ]),
                    ProfileStats("Profile Stats"),
                  ]),
                  Container(
                    height: 70.0,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: SecondaryColor,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text('Posts',
                                style: TextStyle(
                                    fontFamily: 'Futura', fontSize: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              sliver: Container(
                child: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 175.0,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                          padding: (index % 2 == 0
                              ? EdgeInsets.only(left: 20.0)
                              : EdgeInsets.only(right: 20.0)),
                          child: ImageWidget('${urls[index]}', index));
                    },
                    childCount: urls.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String text;

  ProfileInfo(this.text);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30.0),
                child: Text('My Profile',
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff205A48),
                        fontFamily: 'Futura'))),
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
                      'https://instagram.fyei6-3.fna.fbcdn.net/v/t51.2885-19/s320x320/21909584_120180178660604_8422845834311237632_n.jpg?_nc_ht=instagram.fyei6-3.fna.fbcdn.net&_nc_cat=108&_nc_ohc=p6SodrtxerkAX_rR8uq&tn=Oytbs-12iV9bZNf9&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT_XIGG7ry3_2ysf7HCSDoq4xrXCXoRZkcdeqbsi6VYVLQ&oe=61C73264&_nc_sid=7bff83'),
                  radius: 35.0,
                )),
            Container(
                child: Text('Oguzhan',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1B4B3D),
                        fontFamily: 'Futura'))),
            Container(
                margin: EdgeInsets.only(top: 12.0),
                child: Text('@Ogz_memes',
                    style: TextStyle(
                        color: Color(0xff35977A),
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Futura')))
          ])),
          decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(70.0))),
        )
      ],
    );
  }
}

class ProfileStats extends StatelessWidget {
  final String text;

  ProfileStats(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: middleSectionHeight,
      padding: EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text('Photos',
                          style: TextStyle(
                              color: Color(0xff35977A),
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Futura')),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text('567',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1B4B3D),
                                fontFamily: 'Futura')))
                  ]),
                  Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text('Followers',
                          style: TextStyle(
                              color: Color(0xff35977A),
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Futura')),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text('12,454',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1B4B3D),
                                fontFamily: 'Futura')))
                  ]),
                  Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text('Follows',
                          style: TextStyle(
                              color: Color(0xff35977A),
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Futura')),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text('127',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1B4B3D),
                                fontFamily: 'Futura')))
                  ]),
                ])
          ]),
      decoration: BoxDecoration(
        color: SecondaryColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(70.0), topLeft: Radius.circular(70.0)),
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: appWidth,
                            height: appHeight,
                            child: Center(child: ProfileScreen()),
                          )
                        ])
                  ]))),
      debugShowCheckedModeBanner: false,
    );
  }
}
