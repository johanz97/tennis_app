import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/weather_info.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/logic/bookings_provider.dart';
import 'package:tennis_app/models/booking_model.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({required this.booking, super.key});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationProvider>().user;

    return Dismissible(
      key: Key(booking.id),
      onDismissed: (direction) async {
        final bookingsProvider = context.read<BookingsProvider>();
        final response = await bookingsProvider.deleteBooking(
          booking: booking,
        );

        response.fold(
          (errorMessage) {},
          (unit) {
            bookingsProvider.getBookings();
          },
        );
      },
      background: Container(color: Colors.red),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: booking.image.isNotEmpty
                ? Image.network(
                    booking.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
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
                Text(
                  booking.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Cancha tipo ${booking.type}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      booking.date,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Reservado por ${user?.displayName ?? ''}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${booking.time} horas I \$${booking.totalCost}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          WeatherInfo(city: booking.address),
        ],
      ),
    );
  }
}
