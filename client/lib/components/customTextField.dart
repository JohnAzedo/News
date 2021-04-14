import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final bool isPassword;

  CustomTextField(
      {this.controller,
      @required this.label,
      @required this.icon,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          labelText: label,
        ),
      ),
    );
  }
}
