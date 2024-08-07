import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/presentation/authenticated/widgets/login_body.dart';
import 'package:tennis_app/presentation/authenticated/widgets/register_body.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_icon_tennis.dart';
import 'package:tennis_app/presentation/widgets/loading_overlay.dart';
import 'package:tennis_app/services/firebase_services/authenticated_service.dart';

enum LoginOrRegisterEnum { login, register }

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({required this.section, super.key});

  static String routeName = 'login-or-register';

  final LoginOrRegisterEnum section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          AuthenticationProvider(service: AuthenticatedService()),
      builder: (context, child) => _LoginOrRegisterPageWidget(section),
    );
  }
}

class _LoginOrRegisterPageWidget extends StatefulWidget {
  const _LoginOrRegisterPageWidget(this.section);

  final LoginOrRegisterEnum section;

  @override
  State<_LoginOrRegisterPageWidget> createState() {
    return _LoginOrRegisterPageWidgetState();
  }
}

class _LoginOrRegisterPageWidgetState
    extends State<_LoginOrRegisterPageWidget> {
  late LoginOrRegisterEnum _sectionSelected;

  @override
  void initState() {
    super.initState();
    setState(() => _sectionSelected = widget.section);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthenticationProvider, bool>(
      (provider) => provider.isLoading,
    );

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
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
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _sectionSelected == LoginOrRegisterEnum.login
                          ? 'Iniciar Sesión'
                          : 'Registro',
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 70,
                      child: Divider(color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 30),
                    if (_sectionSelected == LoginOrRegisterEnum.login)
                      LoginBody(
                        onChangeSection: () => setState(() {
                          _sectionSelected = LoginOrRegisterEnum.register;
                        }),
                      )
                    else
                      RegisterBody(
                        onChangeSection: () => setState(() {
                          _sectionSelected = LoginOrRegisterEnum.login;
                        }),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
