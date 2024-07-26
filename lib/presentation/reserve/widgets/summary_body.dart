import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/widgets/btn_outline_tennis.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';

class SummaryBody extends StatelessWidget {
  const SummaryBody({required this.onChangeState, super.key});

  final VoidCallback onChangeState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumen',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ItemSummary(
                          icon: Icons.sports_tennis,
                          text: 'Cancha tipo A',
                        ),
                        SizedBox(height: 5),
                        _ItemSummary(
                          icon: Icons.person_outline_outlined,
                          text: 'Instructor',
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
                          text: '10 de julio',
                        ),
                        SizedBox(height: 5),
                        _ItemSummary(
                          icon: Icons.watch_later_outlined,
                          text: '2 horas',
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total a pagar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$50',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Por 2 horas',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
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
                      onTap: () {
                        context.pop();
                      },
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
