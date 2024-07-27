import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_app/core/utils.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({required this.emailController, super.key});

  final TextEditingController emailController;

  String? _validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value?.isEmpty ?? true
        ? 'Campo requerido'
        : !regex.hasMatch(value!)
            ? 'Email no válido'
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: emailController,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9@a-zA-Z.]')),
      ],
      validator: _validateEmail,
      decoration: decoration(
        context: context,
        label: 'Email',
        icon: Icons.email_outlined,
      ),
    );
  }
}
