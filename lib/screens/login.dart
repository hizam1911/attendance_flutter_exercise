import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_attendance/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool isObscure = true;

  late final dbService;
  late final spService;

  @override
  void initState() {
    spService = context.read<SharedPreferencesService>();
    dbService = context.read<DatabaseService>();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      await dbService.initialise();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("SMART Attendance System"),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dbadmin');
              },
            child: Icon(Icons.admin_panel_settings),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  Text("HELLO AND WELCOME!", style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                    child: Image.asset('assets/images/logo.png', scale: 2,),
                  ),
                  const SizedBox(height: 10,),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controllerEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Required";
                              return null;
                            },
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                    controller: controllerPassword,
                                    obscureText: isObscure,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return "Required";
                                      return null;
                                    },
                                  ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          bool valid = formKey.currentState?.validate() ?? false;
                          if (!valid) return null;
                          //login backend here
                          bool isUserExist = await dbService.login(spService, controllerEmail.text, controllerPassword.text);
                          if (!isUserExist) {
                            ElegantNotification.info(
                              title:  Text("Error"),
                              description:  Text("Email and Password didnt match or user not exist!"),
                              icon: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              width: MediaQuery.sizeOf(context).width - 40,
                              toastDuration: Duration(seconds: 3),
                            ).show(context);
                            return null;
                          };
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Text("Log In"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text("Register", style: TextStyle(decoration: TextDecoration.underline),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
