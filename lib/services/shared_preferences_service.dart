import 'package:flutter_attendance/constants/shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;
  SharedPreferencesService(this.sharedPreferences);

  Future<bool> setEmail(String value) async {
    return sharedPreferences.setString(SharedPreferencesConstants.prefEmail, value);
  }

  Future<bool> setName(String value) async {
    return sharedPreferences.setString(SharedPreferencesConstants.prefName, value);
  }

  Future<bool> setRole(String value) async {
    return sharedPreferences.setString(SharedPreferencesConstants.prefRole, value);
  }

  Future<bool> setIsLoggedIn(bool value) async {
    return sharedPreferences.setBool(SharedPreferencesConstants.prefIsLoggedIn, value);
  }

  String getEmail() {
    return sharedPreferences.getString(SharedPreferencesConstants.prefEmail) ?? "";
  }

  String getName() {
    return sharedPreferences.getString(SharedPreferencesConstants.prefName) ?? "";
  }

  String getRole() {
    return sharedPreferences.getString(SharedPreferencesConstants.prefRole) ?? "";
  }

  bool getIsLoggedIn() {
    return sharedPreferences.getBool(SharedPreferencesConstants.prefIsLoggedIn) ?? false;
  }

  Future<bool> clear() async {
    return sharedPreferences.clear();
  }

}