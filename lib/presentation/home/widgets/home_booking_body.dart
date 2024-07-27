import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/booking_card.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/logic/bookings_provider.dart';

class HomeBookingBody extends StatelessWidget {
  const HomeBookingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<BookingsProvider>().isLoading;
    final bookings = context.watch<BookingsProvider>().bookings;

    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              BtnTennis(
                text: 'Programar Reservas',
                icon: Icons.calendar_today_outlined,
                onTap: () {},
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mis reservas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Flexible(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: bookings.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: BookingCard(booking: bookings[index]),
                  ),
                ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
