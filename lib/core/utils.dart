import 'package:flutter/material.dart';

InputDecoration decoration({
  required BuildContext context,
  required String label,
  required IconData icon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,
    counter: const Offstage(),
    suffixIcon: suffixIcon,
    prefixIcon: Icon(icon, size: 20),
    focusedBorder: const UnderlineInputBorder(),
    enabledBorder: const UnderlineInputBorder(),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    border: const UnderlineInputBorder(),
    labelStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  );
}
