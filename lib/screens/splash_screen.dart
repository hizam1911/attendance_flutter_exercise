import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/main.dart';
import 'package:flutter_attendance/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';

import '../services/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late final spService;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      spService = await context.read<SharedPreferencesService>();
      bool isLoggedIn = spService.getIsLoggedIn();
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      // bool isLoggedIn = spService.getIsLoggedIn();
      // if (isLoggedIn) {
      //   Navigator.pushNamed(context, '/home');
      // } else {
      //   Navigator.pushNamed(context, '/login');
      // }
    });

    return Center(child: CircularProgressIndicator());
  }
}
