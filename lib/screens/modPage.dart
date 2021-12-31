import 'package:comhub/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModPageScreen extends StatefulWidget {
  @override
  modPageState createState() => modPageState();
}

class modPageState extends State<ModPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Society'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
      ),
      body: (Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Card(
                  color: Colors.grey.shade400,
                  child: Text(
                    'EVENTS',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              SizedBox(width: 35.0),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Meeting Event",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(width: 25.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Network Event",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(width: 25.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.modpage2);
                      },
                      child: Text('Create New!'))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.grey.shade700,
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Card(
                  color: Colors.grey.shade400,
                  child: Text(
                    'NEWS',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              SizedBox(width: 80.0),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Chairmen",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(width: 55.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Registration",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(width: 35.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.modpage3);
                      },
                      child: Text('Create New!'))
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey.shade700,
            height: 15.0,
          ),
          Row(
            children: [
              Container(
                height: 50.0,
                alignment: Alignment.center,
                child: Card(
                  color: Colors.grey.shade400,
                  child: Text(
                    'MEMBERS',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Batuhan Benli",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(width: 45.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Burak Şahin",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(width: 60.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "İrem Nur Dukan",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(width: 35.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Oğuzhan Keleş",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(width: 40.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tülin Erçelebi",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(width: 45.0),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
