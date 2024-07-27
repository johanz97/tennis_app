import 'package:flutter/material.dart';

class BtnIconTennis extends StatelessWidget {
  const BtnIconTennis({
    required this.icon,
    required this.onTap,
    super.key,
    this.btnColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          btnColor ?? const Color(0xAAAAF724),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
    );
  }
}
