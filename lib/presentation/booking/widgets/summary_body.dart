import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/booking/summary_provider.dart';
import 'package:tennis_app/logic/home/bookings_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';
import 'package:tennis_app/presentation/widgets/alerts/error_alert.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_outline_tennis.dart';
import 'package:tennis_app/presentation/widgets/buttons/btn_tennis.dart';

class SummaryBody extends StatelessWidget {
  const SummaryBody({
    required this.onChangeState,
    required this.court,
    super.key,
  });

  final VoidCallback onChangeState;
  final CourtModel court;

  Future<void> _onPayBooking(BuildContext context) async {
    final summaryProvider = context.read<SummaryProvider>();
    final bookingsProvider = context.read<BookingsProvider>();
    final hasBooking = bookingsProvider.hasBooking(
      courtId: court.id,
      date: summaryProvider.selectedDate!,
    );

    if (!hasBooking) {
      unawaited(
        showDialog<void>(
          context: context,
          builder: (context) => const ErrorAlert(
            text: 'Cancha ocupada por el dia de hoy',
          ),
        ),
      );

      return;
    }

    final response = await bookingsProvider.addBooking(
      summaryProvider.booking,
    );

    if (!context.mounted) return;
    response.fold(
      (errorMessage) {
        showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );
      },
      (unit) {
        bookingsProvider.getBookings();
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTrainer = context.select<SummaryProvider, TrainerModel?>(
      (provider) => provider.selectedTrainer,
    );
    final selectedDate = context.select<SummaryProvider, DateTime?>(
      (provider) => provider.selectedDate,
    );
    final timeToUse = context.select<SummaryProvider, int>(
      (provider) => provider.timeToUse,
    );
    final totalPrice = context.select<SummaryProvider, String>(
      (provider) => provider.totalPrice,
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resumen', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ItemSummary(
                          icon: Icons.sports_tennis,
                          text: 'Cancha tipo ${court.type}',
                        ),
                        const SizedBox(height: 5),
                        _ItemSummary(
                          icon: Icons.person_outline_outlined,
                          text: selectedTrainer?.name ?? '',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ItemSummary(
                          icon: Icons.calendar_today_outlined,
                          text: selectedDate.toString().substring(0, 10),
                        ),
                        const SizedBox(height: 5),
                        _ItemSummary(
                          icon: Icons.watch_later_outlined,
                          text: '$timeToUse horas',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total a pagar', style: TextStyle(fontSize: 18)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$totalPrice',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Por $timeToUse horas',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: BtnOutlineTennis(
                  text: 'Reprogramar reserva',
                  color: Colors.blue[400],
                  icon: Icons.calendar_today_outlined,
                  onTap: onChangeState,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    BtnTennis(
                      text: 'Pagar',
                      onTap: () => _onPayBooking(context),
                    ),
                    const SizedBox(height: 10),
                    SafeArea(
                      top: false,
                      child: BtnOutlineTennis(
                        text: 'Cancelar',
                        onTap: context.pop,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemSummary extends StatelessWidget {
  const _ItemSummary({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }
}
