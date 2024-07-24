import 'package:flutter/material.dart';
import 'package:tennis_app/core/utils.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({required this.emailController, super.key});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: emailController,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Campo requerido';

        return null;
      },
      decoration: decoration(
        context: context,
        label: 'Email',
        icon: Icons.email_outlined,
      ),
    );
  }
}
