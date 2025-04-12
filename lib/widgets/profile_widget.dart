import 'package:flutter/material.dart';
import 'package:flutter_attendance/services/database_service.dart';
import 'package:flutter_attendance/services/shared_preferences_service.dart';
import 'package:flutter_attendance/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  SharedPreferencesService sp;
  ProfileWidget({super.key, required this.sp});

  Future<void> getUser(BuildContext context) async {
    final email = sp.getEmail();
    final user = await context.read<DatabaseService>().getUserByEmail(email);
    DialogUtils.showDialogPopup(context, "Current User", "${user.id}, ${user.email}, ${user.name}, ${user.role}");
    print("user is: $user");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.jpg'),
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              await getUser(context);
            },
            child: Text('Test Fetch User'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool? ok = await DialogUtils.showDialogPopup(context, "Logout", "Are you sure to logout?");
              if (ok == null) return;
              if (!ok) return;
              if (!context.mounted) return;
              await SharedPreferencesService(sp.sharedPreferences).clear();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
              // Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
            },
            child: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
