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

InputDecoration decorationDate({
  required BuildContext context,
  required String label,
}) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    counter: const Offstage(),
    suffixIcon: const Icon(Icons.arrow_drop_down, size: 20),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white),
    ),
    labelStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  );
}
