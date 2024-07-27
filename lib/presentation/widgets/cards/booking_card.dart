import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/authentication_provider.dart';
import 'package:tennis_app/logic/home/bookings_provider.dart';
import 'package:tennis_app/models/booking_model.dart';
import 'package:tennis_app/presentation/widgets/alerts/confirm_operation.dart';
import 'package:tennis_app/presentation/widgets/image_tennis.dart';
import 'package:tennis_app/presentation/widgets/weather_info.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({required this.booking, super.key});

  final BookingModel booking;

  Future<void> _onDeleteBooking(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.select<AuthenticationProvider, String>(
      (provider) => provider.user?.displayName ?? '',
    );

    return Dismissible(
      key: Key(booking.id),
      confirmDismiss: (direction) async => showDialog(
        context: context,
        builder: (context) => const ConfirmOperationAlert(
          text: '¿Desea eliminar la reserva?',
        ),
      ),
      onDismissed: (direction) => _onDeleteBooking(context),
      background: Container(color: Colors.red),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageTennis(urlImage: booking.image, width: 50, height: 50),
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
                      DateFormat('dd MMM yyyy').format(booking.date),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Reservado por $userName',
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
