import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/models/community.dart';
import 'package:comhub/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comhub/models/community.dart';

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
    String soc8 = " ";

    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Communities"),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
      ),
      backgroundColor: Colors.indigo.shade700,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('communities').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final coms = snapshot.data?.docs;
          

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              
              margin: EdgeInsets.symmetric(),
              child: Card(
                child: Container(
                  height: 120,
                  child: TextButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        // title: Text(),
                        content: Text('Do you want to join the ' + soc1),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context, 'Request Join'),
                            child: const Text('Send Join Request'),
                          ),
                        ],
                      ),
                    ),
                    child: Text(
                      coms![index].get("id"),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // body: ListView(
      //   children: [
      //     SizedBox(
      //       height: 5.0,
      //     ),
      // Card(
      //     child: Container(
      //       height: 120,
      //   child: TextButton(
      //     onPressed: () => showDialog<String>(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //         title: Text(soc1),
      //         content: Text('Do you want to join the ' + soc1),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () => Navigator.pop(context, 'Cancel'),
      //             child: const Text('Cancel'),
      //           ),
      //           TextButton(
      //             onPressed: () => Navigator.pop(context, 'Request Join'),
      //             child: const Text('Send Join Request'),
      //           ),
      //         ],
      //       ),
      //     ),
      //     child: Text(
      //       soc1,
      //       style: TextStyle(fontSize: 40.0),
      //     ),
      //   ),
      // )),
      //     Card(
      //         child: Container(
      //           height: 120,
      //       child: TextButton(
      //         onPressed: () => showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //             title: Text(soc2),
      //             content: Text('Do you want to join the ' + soc2),
      //             actions: <Widget>[
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Cancel'),
      //                 child: const Text('Cancel'),
      //               ),
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Request Join'),
      //                 child: const Text('Send Join Request'),
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: Text(
      //           soc2,
      //           style: TextStyle(fontSize: 40.0),
      //         ),
      //       ),
      //     )),
      //     Card(
      //         child: Container(
      //           height: 120,
      //       child: TextButton(
      //         onPressed: () => showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //             title: Text(soc3),
      //             content: Text('Do you want to join the ' + soc3),
      //             actions: <Widget>[
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Cancel'),
      //                 child: const Text('Cancel'),
      //               ),
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Request Join'),
      //                 child: const Text('Send Join Request'),
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: Text(
      //           soc3,
      //           style: TextStyle(fontSize: 40.0),
      //         ),
      //       ),
      //     )),
      //     Card(
      //         child: Container(
      //           height: 120,
      //       child: TextButton(
      //         onPressed: () => showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //             title: Text(soc4),
      //             content: Text('Do you want to join the ' + soc4),
      //             actions: <Widget>[
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Cancel'),
      //                 child: const Text('Cancel'),
      //               ),
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Request Join'),
      //                 child: const Text('Send Join Request'),
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: Text(
      //           soc4,
      //           style: TextStyle(fontSize: 40.0),
      //         ),
      //       ),
      //     )),
      //     Card(
      //         child: Container(
      //           height: 120,
      //       child: TextButton(
      //         onPressed: () => showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //             title: Text(soc5),
      //             content: Text('Do you want to join the ' + soc5),
      //             actions: <Widget>[
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Cancel'),
      //                 child: const Text('Cancel'),
      //               ),
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Request Join'),
      //                 child: const Text('Send Join Request'),
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: Text(
      //           soc5,
      //           style: TextStyle(fontSize: 40.0),
      //         ),
      //       ),
      //     )),
      //     Card(
      //         child: Container(
      //           height: 120,
      //       child: TextButton(
      //         onPressed: () => showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => AlertDialog(
      //             title: Text(soc6),
      //             content: Text('Do you want to join the ' + soc6),
      //             actions: <Widget>[
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Cancel'),
      //                 child: const Text('Cancel'),
      //               ),
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context, 'Request Join'),
      //                 child: const Text('Send Join Request'),
      //               ),
      //             ],
      //           ),
      //         ),
      //         child: Text(
      //           soc6,
      //           style: TextStyle(fontSize: 40.0),
      //         ),
      //       ),
      //     ))
      //   ],
      // ),
    );
  }
}
