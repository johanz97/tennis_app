import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/presentation/reserve_page.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/logo_login.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Epic Box',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.cloud_queue_rounded, size: 16),
                      SizedBox(width: 5),
                      Text('30%'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Cancha tipo A',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Row(
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Disponible',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.watch_later_outlined,
                        size: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '9:00 pm a 10:00 pm',
                        style: TextStyle(fontSize: 12),
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
                onTap: () => context.pushNamed(ReservePage.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
