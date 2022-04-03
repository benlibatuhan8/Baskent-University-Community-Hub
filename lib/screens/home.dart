import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:comhub/routes/route.dart';
import 'package:comhub/widgets/drawer.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Home",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      //drawer:
      drawer: MyDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.topCenter,
          ),
          SizedBox(
            height: 20.0,
          ),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Card(
                color: Colors.indigo.shade700,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Computer Society",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text("MEETING EVENT"),
                      subtitle: Text("First even of semester. Come and meet with members!"),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/basres1.jpg",
                            scale: 50.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Avni Akyol Conference Hall\n\nFatih Sultan 06790\nEtimesgut/Ankara",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.assistant_direction_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("11:00")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.lightBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("07.01.2022")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Card(
                          child: Text(
                            "Join Event",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )),
                  ],
                ),
              ),

              //2nd image of slider
              Card(
                color: Colors.indigo.shade300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Computer Society",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text("BREAKFAST EVENT"),
                      subtitle: Text("Come and taste delicious food with our members!"),
                    ),
                    Card(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/kahveci-efendi.jpg",
                            scale: 6.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Kahveci Efendi Kızılay\n\nAşkabat Cad. No:17/B\nÇankaya/Ankara",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.assistant_direction_rounded)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("10:00")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Card(
                            color: Colors.lightBlue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("09.01.2022")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Card(
                          child: Text(
                            "Join Event",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )),
                  ],
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 450.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
