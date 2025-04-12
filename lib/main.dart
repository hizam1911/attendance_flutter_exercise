import 'package:flutter/material.dart';
import 'package:flutter_attendance/screens/check_in.dart';
import 'package:flutter_attendance/screens/dbadmin.dart';
import 'package:flutter_attendance/screens/faq.dart';
import 'package:flutter_attendance/screens/home.dart';
import 'package:flutter_attendance/screens/login.dart';
import 'package:flutter_attendance/screens/panel_clinic.dart';
import 'package:flutter_attendance/screens/qr_page.dart';
import 'package:flutter_attendance/screens/register.dart';
import 'package:flutter_attendance/screens/splash_screen.dart';
import 'package:flutter_attendance/services/database_service.dart';
import 'package:flutter_attendance/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_attendance/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SharedPreferencesService>(
          create: (_) => SharedPreferencesService(sharedPreferences),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          routes: {
            SplashScreen.routeName: (_) => const SplashScreen(), // '/'
            DBAdmin.routeName: (_) => const DBAdmin(), // '/dbadmin'
            Login.routeName: (_) => Login(), // '/login'
            Home.routeName: (_) => Home(), // '/home'
            Register.routeName: (_) => Register(), // '/register'
            QrPage.routeName: (_) => QrPage(), // '/qr_page'
            CheckIn.routeName: (_) => CheckIn(), // '/check_in'
            PanelClinic.routeName: (_) => PanelClinic(), // '/panel_clinic'
            Faq.routeName: (_) => Faq(), // '/faq'
          }
      ),
    );
  }
}
