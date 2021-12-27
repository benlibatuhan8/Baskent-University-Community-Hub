import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

const PrimaryColor = Color(0xffECFEF3);
const SecondaryColor = Color(0xffD9FDE8);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Home",
          textAlign: TextAlign.center,
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      //drawer:
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              //1st Image of Slider
              Card(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Computer Society",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 350.0,
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
