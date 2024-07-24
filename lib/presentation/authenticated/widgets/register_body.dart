import 'package:flutter/material.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/core/widgets/email_input.dart';
import 'package:tennis_app/core/widgets/password_input.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({required this.onChangeSection, super.key});

  final VoidCallback onChangeSection;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            controller: _nameController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Campo requerido';

              return null;
            },
            decoration: decoration(
              context: context,
              label: 'Nombre y apellido',
              icon: Icons.person_outline_sharp,
            ),
          ),
          const SizedBox(height: 5),
          EmailInput(emailController: _emailController),
          const SizedBox(height: 5),
          TextFormField(
            maxLength: 50,
            controller: _phoneController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Campo requerido';

              return null;
            },
            decoration: decoration(
              context: context,
              label: 'Teléfono',
              icon: Icons.phone_android,
            ),
          ),
          const SizedBox(height: 5),
          PasswordInput(
            passwordController: _passwordController,
            label: 'Contraseña',
          ),
          const SizedBox(height: 5),
          PasswordInput(
            passwordController: _confirmPasswordController,
            label: 'Confirmar contraseña',
          ),
          const SizedBox(height: 30),
          BtnTennis(
            text: 'Regístrarme',
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
                'Ya tengo cuenta',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: widget.onChangeSection,
                child: const Text(
                  'Iniciar sesión',
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
