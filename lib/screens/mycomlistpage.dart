import 'package:comhub/routes/route.dart';
import 'package:comhub/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyComListPageScreen extends StatefulWidget {
  @override
  myComListPageState createState() => myComListPageState();
}

class myComListPageState extends State<MyComListPageScreen> {
  @override
  Widget build(BuildContext context) {
    String soc1 = 'Computer Society';
    String soc2 = 'Productivity Society';
    String soc3 = 'IEEE Society';
    String soc4 = 'Mechanical Engineering Society';
    String soc5 = 'Law Society';
    String soc6 = 'Ahbap Society';
    String soc7 = 'Biomedical Engineering Society';

    return Scaffold(
      appBar: AppBar(
        title: Text("My Communities"),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.indigo.shade700,
      body: ListView(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Card(
              child: Container(
            height: 120,
            child: TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(soc1),
                  content: Text('Do you want to join the ' + soc1),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(Routes.computersocietypage),
                      child: Text('Go to '+ soc1 + ' home page',style: TextStyle(fontSize: 16.0),),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child:  Text('Leave this society',style: TextStyle(fontSize: 16.0),),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc1,
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          )),
          Card(
              child: Container(
            height: 120,
            child: TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(soc2),
                  content: Text('Do you want to join the ' + soc2),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('Go to '+ soc2 + ' home page',style: TextStyle(fontSize: 16.0),),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Leave this society',style: TextStyle(fontSize: 16.0),),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc2,
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
