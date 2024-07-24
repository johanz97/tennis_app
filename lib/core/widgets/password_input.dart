import 'package:flutter/material.dart';
import 'package:tennis_app/core/utils.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.passwordController,
    required this.label,
    super.key,
  });

  final TextEditingController passwordController;
  final String label;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: widget.passwordController,
      obscureText: _isObscured,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value?.isEmpty ?? true) return 'Campo requerido';

        return null;
      },
      decoration: decoration(
        context: context,
        label: widget.label,
        icon: Icons.lock_outline_rounded,
        suffixIcon: IconButton(
          onPressed: () => setState(
            () => _isObscured = !_isObscured,
          ),
          icon: Icon(
            !_isObscured
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }
}
