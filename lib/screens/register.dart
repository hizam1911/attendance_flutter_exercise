import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/database_service.dart';
import '../widgets/email_text_form_field.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  // name, email, pass, confirm pass
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  bool isObscurePass = true;
  bool isObscureCPass = true;

  late final dbService;

  @override
  void initState() {
    dbService = context.read<DatabaseService>();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      await dbService.initialise();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerName,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    EmailTextFormField(controller: controllerEmail,),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controllerPassword,
                            obscureText: isObscurePass,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isObscurePass = !isObscurePass;
                            });
                          },
                          icon: Icon(isObscurePass ? Icons.visibility_off : Icons.visibility),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controllerConfirmPassword,
                            obscureText: isObscureCPass,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isObscureCPass = !isObscureCPass;
                              });
                            },
                            icon: Icon(isObscureCPass ? Icons.visibility_off : Icons.visibility),
                        ),
                      ],
                    )
                  ],
                )
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  bool valid = formKey.currentState?.validate() ?? false;
                  if(!valid) return null;
                  if(controllerPassword.text != controllerConfirmPassword.text) {
                    ElegantNotification.info(
                      title:  Text("Error"),
                      description:  Text("Password didnt match!"),
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                    return null;
                  };
                  bool isSuccess = await dbService.addStudent(name: controllerName.text, email: controllerEmail.text, password: controllerPassword.text);
                  if(!isSuccess) {
                    ElegantNotification.info(
                      title:  Text("Error"),
                      description:  Text("User already exist!"),
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                    return null;
                  } else {
                    ElegantNotification.info(
                      title: Text("Success"),
                      description:  Text("User created!"),
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      width: MediaQuery.sizeOf(context).width - 40,
                      toastDuration: Duration(seconds: 3),
                    ).show(context);
                  };
                  setState(() {
                    controllerName.clear();
                    controllerEmail.clear();
                    controllerPassword.clear();
                    controllerConfirmPassword.clear();
                  });
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
