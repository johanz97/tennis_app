import 'package:go_router/go_router.dart';
import 'package:tennis_app/presentation/authenticated/authenticated_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthenticatedPage(),
    ),
  ],
);
