import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comhub/screens/comlistpage.dart';
import 'package:comhub/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:comhub/services/event_services.dart';

import '../models/user.dart';
import '../services/user_services.dart';

class ModPageEventScreen extends StatefulWidget {
  const ModPageEventScreen({Key? key}) : super(key: key);

  @override
  modPageEventState createState() => modPageEventState();
}

class modPageEventState extends State<ModPageEventScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String location = '';
  DateTime dateTime = DateTime.now();

  double maxValue = 0;

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return intl.DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  _submit() async {
    // BURDA SUBMİTE BASINCA YAPILCAKLAR Yazılır
    Users userfields = await User_Service().getUserById(currentUserID);
    var snap = await FirebaseFirestore.instance
        .collection("communities")
        .where('id', isEqualTo: userfields.mod_com)
        .get()
        .then((value) => value.docs[0]["name"]);
    print(dateTime);
    print(Event_Services().getEventById("Computer Societydeneme"));
    Event_Services().uploadEvent(title, snap, location, dateTime, description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Oluştur'),
      ),
      body: Form(
        key: _formKey,
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
                            hintText: 'Bir Başlık Girin...',
                            labelText: 'Başlık',
                          ),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Bir Açıklama Girin...',
                            labelText: 'Açıklama',
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                          maxLines: 5,
                        ),
                        ButtonHeaderWidget(
                          title: 'DateTime',
                          text: getText(),
                          onClicked: () => pickDateTime(context),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Lütfen lokasyon linkinizi buraya kopyalayın',
                            labelText: 'Konum',
                          ),
                          onChanged: (value) {
                            location = value;
                          },
                          maxLines: 5,
                        ),
                        ElevatedButton(
                            onPressed: _submit, child: Text("Oluştur"))
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
    );
  }
}