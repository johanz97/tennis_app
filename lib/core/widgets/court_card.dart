import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/reserve/reserve_page.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({required this.court, super.key});

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: court.image.isNotEmpty
                  ? Image.network(
                      court.image,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/logo_login.png',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        court.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.cloud_queue_rounded, size: 16),
                      const SizedBox(width: 5),
                      const Text('30%'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Cancha tipo ${court.type}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Disponible',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.watch_later_outlined,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        court.available,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 40,
                maxWidth: 150,
              ),
              child: BtnTennis(
                text: 'Reservar',
                onTap: () => context.pushNamed(
                  ReservePage.routeName,
                  extra: court,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
