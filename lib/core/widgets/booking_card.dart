import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/authentication_provider.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationProvider>().user;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/authenticated_background.png',
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Epic Box',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Cancha tipo A',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '9 de Julio 2024',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Reservado por ${user?.displayName ?? ''}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 12,
                  ),
                  SizedBox(width: 2),
                  Text(
                    r'2 horas I $50',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Row(
          children: [
            Icon(Icons.cloud_queue_rounded, size: 16),
            SizedBox(width: 5),
            Text('30%'),
          ],
        ),
      ],
    );
  }
}
