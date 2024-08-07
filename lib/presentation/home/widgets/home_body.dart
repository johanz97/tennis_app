import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/logic/home/bookings_provider.dart';
import 'package:tennis_app/logic/home/court_provider.dart';
import 'package:tennis_app/presentation/widgets/alerts/error_alert.dart';
import 'package:tennis_app/presentation/widgets/cards/booking_card.dart';
import 'package:tennis_app/presentation/widgets/cards/court_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Future<void> _getCourts() async {
    final response = await context.read<CourtProvider>().getCourts();

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCourts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final courts = context.watch<CourtProvider>().courts;
    final bookings = context.watch<BookingsProvider>().bookings;
    final userName = context.select<AuthenticationProvider, String>(
      (provider) => provider.user?.displayName ?? '',
    );
    final isLoading = context.select<CourtProvider, bool>(
      (provider) => provider.isLoading,
    );
    final isLoadingBookings = context.select<BookingsProvider, bool>(
      (provider) => provider.isLoading,
    );

    return ListView(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Hola $userName!',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(color: Colors.black12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Canchas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: courts.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                        itemBuilder: (context, index) {
                          return CourtCard(court: courts[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black12),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Reservas programadas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        if (isLoadingBookings)
          const Center(child: CircularProgressIndicator())
        else
          ListView.separated(
            itemCount: bookings.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: BookingCard(booking: bookings[index]),
            ),
          ),
      ],
    );
  }
}
