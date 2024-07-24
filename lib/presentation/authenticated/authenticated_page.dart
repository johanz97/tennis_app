import 'package:flutter/material.dart';

import 'package:tennis_app/core/widgets/btn_tennis.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({super.key});

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
            child: Column(
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
                        onTap: () {},
                      ),
                      const SizedBox(height: 5),
                      BtnTennis(
                        text: 'Registrarme',
                        btnColor: const Color(0xAA9B9C9D),
                        onTap: () {},
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
