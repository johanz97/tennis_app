import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/core/widgets/image_tennis.dart';
import 'package:tennis_app/core/widgets/weather_info.dart';
import 'package:tennis_app/logic/bookings_provider.dart';
import 'package:tennis_app/logic/favorite_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/booking/booking_page.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({required this.court, super.key});

  final CourtModel court;

  void _onBooking(BuildContext context) {
    context.pushNamed(
      BookingPage.routeName,
      extra: BookingArg(
        court: court,
        bookingsProvider: context.read<BookingsProvider>(),
        favoriteProvider: context.read<FavoriteProvider>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Column(
          children: [
            ImageTennis(urlImage: court.image, height: 150),
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
                      WeatherInfo(city: court.address),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Cancha tipo ${court.type}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat('dd MMM yyyy').format(DateTime.now()),
                        style: const TextStyle(fontSize: 12),
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
                onTap: () => _onBooking(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
