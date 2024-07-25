import 'package:flutter/material.dart';
import 'package:tennis_app/core/widgets/booking_card.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';

class BookingBody extends StatelessWidget {
  const BookingBody({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const BookingCard(),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
