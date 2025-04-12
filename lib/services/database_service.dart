import 'package:flutter_attendance/models/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_attendance/utils/database_utils.dart';
import 'package:flutter_attendance/models/user.dart';
import 'package:flutter_attendance/enums/user_role.dart';
import 'package:flutter_attendance/services/shared_preferences_service.dart';

class DatabaseService {
  late Database database;

  Future<void> initialise() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'attendance-db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        Batch batch = db.batch();
        batch.execute(DatabaseUtils.getCreateUsersTableQuery());
        batch.execute(DatabaseUtils.getCreateAttendanceTableQuery());
        await batch.commit();
      },
    );
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    return await database.insert(table, values);
  }

  Future<bool> addStudent({
    required String name,
    required String email,
    required String password
  }) async {
    final user = User(
        name: name, email: email, password: password, role: UserRole.student);
    try{
      await insert(User.table, user.toMap());
    } catch (e) {
      print("Error: User Existed");
      print("Error: $e");
      return false;
    }
    return true;
  }

  Future<bool> addAdmin({
    required String name,
    required String email,
    required String password
  }) async {
    final user = User(
        name: name, email: email, password: password, role: UserRole.admin);
    try{
      await insert(User.table, user.toMap());
    } catch (e) {
      print("Error: User Existed");
      print("Error: $e");
      return false;
    }
    return true;
  }

  Future<bool> addAttendance({
    required Attendance attendance
  }) async {
    try{
      await insert(Attendance.table, attendance.toMap());
    } catch (e) {
      print("Error: Attendance Existed");
      print("Error: $e");
      return false;
    }
    return true;
  }

  Future<bool> login(SharedPreferencesService sp, String email, String pass) async {
    final list;
    User user;
    try {
      list = await database.rawQuery(DatabaseUtils.getUserByEmailAndPasswordQuery(email, pass));
      user = User.fromMap(list[0]);
      if (user.id == null) return false;
      SharedPreferencesService(sp.sharedPreferences).setEmail(user.email);
      SharedPreferencesService(sp.sharedPreferences).setName(user.name);
      SharedPreferencesService(sp.sharedPreferences).setRole(user.role.name);
      SharedPreferencesService(sp.sharedPreferences).setIsLoggedIn(true);
    } catch (e) {
      print("Error: $e");
      return false;
    }
    return true;
}

  Future<User> getUserByEmail(String email) async {
    final list = await database.rawQuery(DatabaseUtils.getUserByEmailQuery(email));
    return User.fromMap(list[0]);
  }

  Future<Attendance> getAttendanceList(int userId) async {
    final list = await database.rawQuery(DatabaseUtils.getAttendanceListQuery(userId));
    return Attendance.fromMap(list[0]);
  }

}