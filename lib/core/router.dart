import 'package:go_router/go_router.dart';
import 'package:tennis_app/presentation/authenticated/authenticated_page.dart';
import 'package:tennis_app/presentation/authenticated/login_or_register_page.dart';
import 'package:tennis_app/presentation/home/home_page.dart';
import 'package:tennis_app/presentation/reserve_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthenticatedPage(),
    ),
    GoRoute(
      name: LoginOrRegisterPage.routeName,
      path: '/${LoginOrRegisterPage.routeName}',
      builder: (context, state) {
        final sectionSelected = state.extra! as LoginOrRegisterEnum;

        return LoginOrRegisterPage(section: sectionSelected);
      },
    ),
    GoRoute(
      name: HomePage.routeName,
      path: '/${HomePage.routeName}',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: ReservePage.routeName,
      path: '/${ReservePage.routeName}',
      builder: (context, state) => const ReservePage(),
    ),
  ],
);
