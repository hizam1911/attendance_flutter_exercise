import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  const EmailTextFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return "Required";
        final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
        if(!emailRegex.hasMatch(value)) return "Invalid Email";
        return null;
      },
    );
  }
}
