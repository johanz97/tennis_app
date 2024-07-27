import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_outline_tennis.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_tennis.dart';

class ConfirmOperationAlert extends StatelessWidget {
  const ConfirmOperationAlert({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alerta!'),
      content: Text(text),
      actions: [
        BtnTennis(text: 'Aceptar', onTap: () => context.pop(true)),
        BtnOutlineTennis(text: 'Cancelar', onTap: () => context.pop(false)),
      ],
    );
  }
}
