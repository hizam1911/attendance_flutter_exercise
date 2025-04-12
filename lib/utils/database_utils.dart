import 'package:flutter_attendance/models/attendance.dart';
import 'package:flutter_attendance/models/user.dart';

class DatabaseUtils {
  static String getCreateUsersTableQuery() {
    return "CREATE TABLE IF NOT EXISTS ${User.table} "
        "("
        "${User.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${User.columnName} TEXT NOT NULL, "
        "${User.columnEmail} TEXT NOT NULL UNIQUE, "
        "${User.columnPassword} TEXT NOT NULL, "
        "${User.columnRole} TEXT NOT NULL "
        ")";
  }

  static String getCreateAttendanceTableQuery() {
    return "CREATE TABLE IF NOT EXISTS ${Attendance.table} "
        "("
        "${Attendance.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${Attendance.columnUserId} INTEGER TEXT NOT NULL, "
        "${Attendance.columnClassName} TEXT NOT NULL, "
        "${Attendance.columnTimeIn} TEXT NOT NULL, "
        "${Attendance.columnStatus} TEXT NOT NULL "
        ")";
  }

  static String getUserByEmailQuery(String value) {
    return "select * "
    "from ${User.table} "
    "where ${User.columnEmail} = '$value'";
  }

  static String getUserByEmailAndPasswordQuery(String email, String pass) {
    return "select * "
        "from ${User.table} "
        "where ${User.columnEmail} = '$email' AND ${User.columnPassword} = '$pass'";
  }

  static String getAttendanceListQuery(int userId) {
    return "select * "
        "from ${Attendance.table} "
        "where ${Attendance.columnId} = $userId"
        "order by ${Attendance.columnId} desc ";
  }

}