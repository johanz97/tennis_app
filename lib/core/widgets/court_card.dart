import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/btn_tennis.dart';
import 'package:tennis_app/logic/weather_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/reserve/reserve_page.dart';
import 'package:tennis_app/services/weather_service.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({required this.court, super.key});

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(service: WeatherService(Dio())),
      builder: (context, child) => _CourtCardWidget(court: court),
    );
  }
}

class _CourtCardWidget extends StatefulWidget {
  const _CourtCardWidget({required this.court});

  final CourtModel court;

  @override
  State<_CourtCardWidget> createState() => _CourtCardWidgetState();
}

class _CourtCardWidgetState extends State<_CourtCardWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final response = await context.read<WeatherProvider>().getWeather(
            widget.court.address,
          );

      response.fold((errorMessage) {}, (_) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<WeatherProvider>().isLoading;
    final weather = context.watch<WeatherProvider>().weather;

    return SizedBox(
      width: 250,
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.court.image.isNotEmpty
                  ? Image.network(
                      widget.court.image,
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
                        widget.court.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (isLoading)
                        const CircularProgressIndicator()
                      else
                        Row(
                          children: [
                            Icon(
                              (weather?.tempC ?? 0) < 15
                                  ? Icons.cloudy_snowing
                                  : (weather?.tempC ?? 0) > 30
                                      ? Icons.sunny
                                      : Icons.cloud_queue_rounded,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text('${weather?.tempC ?? 0}°C'),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Cancha tipo ${widget.court.type}',
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
                        widget.court.available,
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
                  extra: widget.court,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
