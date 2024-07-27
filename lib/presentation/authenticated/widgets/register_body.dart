import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_tennis.dart';
import 'package:tennis_app/presentation/widgets/inputs/email_input.dart';
import 'package:tennis_app/presentation/widgets/inputs/password_input.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/presentation/home/home_page.dart';

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

  Future<void> _onCreateUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;

    final response = await context.read<AuthenticationProvider>().createUser(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

    if (!context.mounted) return;
    response.fold((errorMessage) {}, (unit) {
      context.goNamed(HomePage.routeName);
    });
  }

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
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[a-z A-Z á-ú Á-Ú 0-9 ]'),
              ),
              FilteringTextInputFormatter.deny('  '),
            ],
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
            maxLength: 10,
            controller: _phoneController,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
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
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _passwordController,
            builder: (context, value, child) {
              return PasswordInput(
                validatePassword: value.text,
                passwordController: _confirmPasswordController,
                label: 'Confirmar contraseña',
              );
            },
          ),
          const SizedBox(height: 30),
          BtnTennis(
            text: 'Regístrarme',
            onTap: _onCreateUser,
          ),
          const SizedBox(height: 30),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
