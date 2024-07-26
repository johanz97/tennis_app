import 'package:flutter/material.dart';

class BtnOutlineTennis extends StatelessWidget {
  const BtnOutlineTennis({
    required this.text,
    required this.onTap,
    super.key,
    this.color,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: color ?? Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(icon, color: color ?? Colors.black),
              ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
