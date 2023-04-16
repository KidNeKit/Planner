import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChangedFunc;
  final String labelText;
  final bool obscureText;

  const CustomTextField(
      {required this.onChangedFunc,
      required this.labelText,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style:
          Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
      onChanged: onChangedFunc,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
