import 'package:comhub/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComListPageScreen extends StatefulWidget {
  @override
  comListPageState createState() => comListPageState();
}

class comListPageState extends State<ComListPageScreen> {
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
        title: Text("Discover Communities"),
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
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
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
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
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
          Card(
              child: Container(
                height: 120,
            child: TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(soc3),
                  content: Text('Do you want to join the ' + soc3),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc3,
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
                  title: Text(soc4),
                  content: Text('Do you want to join the ' + soc4),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc4,
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
                  title: Text(soc5),
                  content: Text('Do you want to join the ' + soc5),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc5,
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
                  title: Text(soc6),
                  content: Text('Do you want to join the ' + soc6),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Request Join'),
                      child: const Text('Send Join Request'),
                    ),
                  ],
                ),
              ),
              child: Text(
                soc6,
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
