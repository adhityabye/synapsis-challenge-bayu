import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const PasswordField({
    Key? key,
    required this.obscureText,
    required this.onObscureTextChanged,
    required this.controller,
  }) : super(key: key);

  final bool obscureText;
  final ValueChanged<bool> onObscureTextChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password"),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller, // Bind the controller to the input field
          obscureText: obscureText,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "masukin password kamu",
          ),
        ),
      ],
    );
  }
}