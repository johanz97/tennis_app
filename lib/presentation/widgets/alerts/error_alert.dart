import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_tennis.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
          Text('Error!', style: TextStyle(color: Colors.red)),
        ],
      ),
      content: Text(text),
      actions: [
        BtnTennis(text: 'Cerrar', onTap: context.pop),
      ],
    );
  }
}
