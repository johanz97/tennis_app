import 'package:flutter/material.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/core/widgets/email_input.dart';
import 'package:tennis_app/core/widgets/password_input.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({required this.onChangeSection, super.key});

  final VoidCallback onChangeSection;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSavedPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailInput(emailController: _emailController),
          const SizedBox(height: 30),
          PasswordInput(
            passwordController: _passwordController,
            label: 'Contraseña',
          ),
          Row(
            children: [
              Checkbox(
                value: _isSavedPassword,
                onChanged: (value) {
                  setState(() => _isSavedPassword = value ?? false);
                },
              ),
              const Text(
                'Recordar contraseña',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 20),
          BtnTennis(
            text: 'Iniciar sesión',
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (!_formKey.currentState!.validate()) return;
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¿Aun no tienes una cuenta?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: widget.onChangeSection,
                child: const Text(
                  'Regístrate',
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
