import 'package:flutter/material.dart';
import 'package:flutter_attendance/enums/attendance_status.dart';
import 'package:flutter_attendance/models/attendance.dart';
import 'package:flutter_attendance/services/database_service.dart';
import 'package:flutter_attendance/utils/dialog_utils.dart';
import 'package:flutter_attendance/widgets/home_widget.dart';
import 'package:provider/provider.dart';

import '../services/shared_preferences_service.dart';
import '../widgets/dashboard_widget.dart';
import '../widgets/profile_widget.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = "";
  int selectedIndex = 0;
  late final spService;
  List<Attendance> attendance = [];

  @override
  void initState() {
    spService = context.read<SharedPreferencesService>();
    username = spService.getName();
    // WidgetsBinding.instance
    super.initState();
  }

  Future<void> fetchAttendanceList(int userId) async {
    print(await DatabaseService().getAttendanceList(userId));
  }

  void addAttendanceList() {
    Attendance attendanceObject =  Attendance(userId: 3, className: "Math", timeIn: DateTime.now(), status: AttendanceStatus.present);
    attendance.add(attendanceObject);
    setState(() {});
  }

  Future<void> addAttendanceToDb(Attendance attendance) async {
    bool success = await DatabaseService().addAttendance(attendance: attendance);
    if(success) {
      DialogUtils().showInfoPopup(context, "Info", "Attendance added successfully!");
    }
  }

  void clearAttendanceList() {
    attendance.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Welcome $username'),
            actions: [
              Visibility(
                visible: selectedIndex == 1
                ? true
                : false,
                child: IconButton(
                  onPressed: () {
                    addAttendanceList();
                  },
                  icon: Icon(Icons.qr_code),
                ),
              ),

              Visibility(
                visible: selectedIndex == 1
                    ? true
                    : false,
                child: IconButton(
                  onPressed: () {
                    clearAttendanceList();
                  },
                  icon: Icon(Icons.clear_all),
                ),
              ),
            ],
          ),
          body: Center(
            child: selectedIndex == 0
            ? HomeWidget()
            : selectedIndex == 1
            ? DashboardWidget(attendance: attendance,)
            : selectedIndex == 2
            ? ProfileWidget(sp: spService,)
            : Container(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            onTap: (i) {
                setState(() {
                  selectedIndex = i;
                });
            },
          ),
        ),
    );
  }
}
