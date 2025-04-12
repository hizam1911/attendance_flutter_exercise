import 'package:flutter/material.dart';
import 'package:flutter_attendance/models/attendance.dart';
import 'package:intl/intl.dart';

class DashboardWidget extends StatelessWidget {
  List<Attendance> attendance = [];
  DashboardWidget({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ListView.builder(
        itemCount: attendance.length,
          itemBuilder: (context, index) {
            final attend = attendance[index];

            // Define the desired format
            String formattedDate = DateFormat('EEEE, MMMM d, y, h a z').format(attend.timeIn);

            return ListTile(
              title: Text("${attend.className} : $formattedDate".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(attend.status.name),
            );
          }
      ),
    );
  }
}