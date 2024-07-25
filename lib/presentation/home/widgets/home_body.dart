import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/booking_card.dart';
import 'package:tennis_app/core/widgets/court_card.dart';
import 'package:tennis_app/logic/authentication_provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationProvider>().getUser();

    return ListView(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Hola ${user?.displayName ?? ''}!',
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (context, index) => const CourtCard(),
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
        ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: const BookingCard(),
          ),
        ),
      ],
    );
  }
}
