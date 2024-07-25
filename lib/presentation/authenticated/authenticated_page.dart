import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/presentation/authenticated/login_or_register_page.dart';
import 'package:tennis_app/presentation/home/home_page.dart';

class AuthenticatedPage extends StatefulWidget {
  const AuthenticatedPage({super.key});

  @override
  State<AuthenticatedPage> createState() {
    return _AuthenticatedPageState();
  }
}

class _AuthenticatedPageState extends State<AuthenticatedPage> {
  bool _isLoading = true;

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() => _isLoading = false);

      if (user != null) {
        context.goNamed(HomePage.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset(
              'assets/images/authenticated_background.png',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            BtnTennis(
                              text: 'Iniciar sesión',
                              onTap: () => context.pushNamed(
                                LoginOrRegisterPage.routeName,
                                extra: LoginOrRegisterEnum.login,
                              ),
                            ),
                            const SizedBox(height: 5),
                            BtnTennis(
                              text: 'Registrarme',
                              btnColor: const Color(0xAA9B9C9D),
                              onTap: () => context.pushNamed(
                                LoginOrRegisterPage.routeName,
                                extra: LoginOrRegisterEnum.register,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
