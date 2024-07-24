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
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  );
}
