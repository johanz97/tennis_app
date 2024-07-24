import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/utils.dart';
import 'package:tennis_app/core/widgets/btn_icon_tennis.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';

enum LoginOrRegisterEnum {
  login,
  register,
}

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({
    super.key,
    this.section = LoginOrRegisterEnum.login,
  });

  static String routeName = 'login-or-register';

  final LoginOrRegisterEnum section;

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  late LoginOrRegisterEnum _sectionSelected;

  @override
  void initState() {
    super.initState();
    setState(() => _sectionSelected = widget.section);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/logo_login.png',
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BtnIconTennis(
                    icon: Icons.arrow_back,
                    onTap: context.pop,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _sectionSelected == LoginOrRegisterEnum.login
                ? _LoginBody(
                    () => setState(() {
                      _sectionSelected = LoginOrRegisterEnum.register;
                    }),
                  )
                : const _RegisterBody(),
          ),
        ],
      ),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody(this.onChangeSection);

  final VoidCallback onChangeSection;

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Iniciar Sesión", style: TextStyle(fontSize: 25)),
          const SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            maxLength: 50,
            decoration: decoration(
              context: context,
              label: "Email",
              icon: Icons.email_outlined,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _passwordController,
            maxLength: 50,
            obscureText: _isObscured,
            decoration: decoration(
              context: context,
              label: 'Contraseña',
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
                "Recordar contraseña",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              "¿Olvidaste tu contraseña?",
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 20),
          BtnTennis(
            text: 'Iniciar sesión',
            onTap: () {},
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿Aun no tienes una cuenta?",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: widget.onChangeSection,
                child: const Text(
                  "Regístrate",
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RegisterBody extends StatefulWidget {
  const _RegisterBody();

  @override
  State<_RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<_RegisterBody> {
  @override
  Widget build(BuildContext context) {
    return const Offstage();
  }
}
