import 'package:flutter/material.dart';

class BtnTennis extends StatelessWidget {
  const BtnTennis({
    required this.text,
    required this.onTap,
    super.key,
    this.btnColor,
  });

  final String text;
  final VoidCallback onTap;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            btnColor ?? const Color(0xAAAAF724),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
