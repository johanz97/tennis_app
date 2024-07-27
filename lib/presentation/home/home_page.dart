import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/logic/home/bookings_provider.dart';
import 'package:tennis_app/logic/home/court_provider.dart';
import 'package:tennis_app/logic/home/favorite_provider.dart';
import 'package:tennis_app/presentation/home/widgets/favorite_body.dart';
import 'package:tennis_app/presentation/home/widgets/home_body.dart';
import 'package:tennis_app/presentation/home/widgets/home_booking_body.dart';
import 'package:tennis_app/presentation/widgets/alerts/confirm_operation.dart';
import 'package:tennis_app/presentation/widgets/alerts/error_alert.dart';
import 'package:tennis_app/services/firebase_services/authenticated_service.dart';
import 'package:tennis_app/services/local_services/booking_service.dart';
import 'package:tennis_app/services/local_services/court_service.dart';
import 'package:tennis_app/services/local_services/favorite_service.dart';

enum NavBarEnum { home, bookings, favorite }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AuthenticationProvider(service: AuthenticatedService());
          },
        ),
        ChangeNotifierProvider(
          create: (context) => CourtProvider(service: CourtService()),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingsProvider(service: BookingService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(service: FavoriteService()),
        ),
      ],
      child: const _HomePageWidget(),
    );
  }
}

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget();

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget> {
  NavBarEnum _selectedIndex = NavBarEnum.home;

  Future<void> _getBookings() async {
    final response = await context.read<BookingsProvider>().getBookings();

    if (!mounted) return;
    response.fold(
      (errorMessage) {
        showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );
      },
      (_) {},
    );
  }

  Future<void> _getFavorites() async {
    final response = await context.read<FavoriteProvider>().getFavorites();

    if (!mounted) return;
    response.fold(
      (errorMessage) {
        showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );
      },
      (_) {},
    );
  }

  Future<void> _onCloseSession() async {
    final validateClose = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const ConfirmOperationAlert(
              text:
                  'Al cerrar sesión perdera todos sus registros, ¿Desea continuar?',
            );
          },
        ) ??
        false;

    if (!validateClose || !mounted) return;
    final response = await context.read<AuthenticationProvider>().logOutUser();

    if (!mounted) return;
    response.fold((errorMessage) {
      showDialog<void>(
        context: context,
        builder: (context) => ErrorAlert(text: errorMessage),
      );
    }, (unit) {
      context.read<BookingsProvider>().deleteAllBooking();
      context.read<FavoriteProvider>().deleteAllFavorites();
      context.go('/');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBookings();
      _getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              stops: const [0.1, 0.6],
              colors: [
                const Color(0xAA82BC00),
                Colors.green[700]!,
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            const Text(
              'Tennis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  stops: const [0.7, 1],
                  colors: [
                    const Color(0xAA82BC00),
                    Colors.green[700]!,
                  ],
                ),
              ),
              child: const Text(
                ' court ',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
        actions: [
          const Icon(Icons.person, color: Colors.white),
          const SizedBox(width: 5),
          const Icon(Icons.notifications_none, color: Colors.white),
          const SizedBox(width: 5),
          PopupMenuButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                onTap: _onCloseSession,
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: _selectedIndex == NavBarEnum.home
          ? const HomeBody()
          : _selectedIndex == NavBarEnum.bookings
              ? HomeBookingBody(
                  onNewBooking: () => setState(
                    () => _selectedIndex = NavBarEnum.home,
                  ),
                )
              : const FavoriteBody(),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BtnNavBar(
                label: 'Home',
                icon: Icons.home_filled,
                isActive: _selectedIndex == NavBarEnum.home,
                onTap: () => setState(() => _selectedIndex = NavBarEnum.home),
              ),
              _BtnNavBar(
                label: 'Reservas',
                icon: Icons.collections_bookmark_outlined,
                isActive: _selectedIndex == NavBarEnum.bookings,
                onTap: () => setState(
                  () => _selectedIndex = NavBarEnum.bookings,
                ),
              ),
              _BtnNavBar(
                label: 'Favoritos',
                icon: Icons.favorite_border,
                isActive: _selectedIndex == NavBarEnum.favorite,
                onTap: () => setState(
                  () => _selectedIndex = NavBarEnum.favorite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnNavBar extends StatelessWidget {
  const _BtnNavBar({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? const Color(0xAA82BC00) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.black),
            Text(
              label,
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
