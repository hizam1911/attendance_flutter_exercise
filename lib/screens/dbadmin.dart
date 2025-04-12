import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/main.dart';
import 'package:flutter_attendance/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';

class DBAdmin extends StatefulWidget {
  static const String routeName = "/dbadmin";
  const DBAdmin({super.key});

  @override
  State<DBAdmin> createState() => _DBAdminState();
}

class _DBAdminState extends State<DBAdmin> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      await context.read<DatabaseService>().initialise();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: Text('Admin Console'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () async {
                  const email = "email";
                  bool isSuccess = await context.read<DatabaseService>().addStudent(name: "name", email: email, password: "password");
                  if (isSuccess) {
                    ElegantNotification.info(
                      title: Text("Success"),
                      description: Text("User created!"),
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      width: MediaQuery
                          .sizeOf(context)
                          .width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                  } else {
                    ElegantNotification.info(
                      title:  Text("Error"),
                      description:  Text("User exist!"),
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                  }
                },
                child: const Text("Add Student")
            ),
            ElevatedButton(
                onPressed: () async {
                  const name = "Administrator";
                  const email = "dbadmin";
                  const pass = "dbadmin";
                  bool isSuccess = await context.read<DatabaseService>().addAdmin(name: name, email: email, password: pass);
                  if (isSuccess) {
                    ElegantNotification.info(
                      title:  Text("Success"),
                      description:  Text("User created!"),
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                  } else {
                    ElegantNotification.info(
                      title:  Text("Error"),
                      description:  Text("User exist!"),
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                  }
                },
                child: const Text("Add Admin")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const DatabaseList()));
                },
                child: const Text("View Database Listing")
            ),
          ],
        ),
      ),
    );
  }
}
