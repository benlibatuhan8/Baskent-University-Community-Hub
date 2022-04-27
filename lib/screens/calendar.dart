import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const PrimaryColor = Color(0xffECFEF3);

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Takvim"),
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.blue.shade100,
      body: SfCalendar(
        view: CalendarView.month,
      ),
    );
  }
}
