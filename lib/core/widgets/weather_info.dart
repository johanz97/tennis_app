import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/weather_provider.dart';
import 'package:tennis_app/services/weather_service.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({required this.city, super.key});

  final String city;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(service: WeatherService(Dio())),
      builder: (context, child) => _WeatherInfoWidget(city: city),
    );
  }
}

class _WeatherInfoWidget extends StatefulWidget {
  const _WeatherInfoWidget({required this.city});

  final String city;

  @override
  State<_WeatherInfoWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<_WeatherInfoWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final response = await context.read<WeatherProvider>().getWeather(
            widget.city,
          );

      response.fold((errorMessage) {}, (_) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<WeatherProvider>().isLoading;
    final weather = context.watch<WeatherProvider>().weather;

    return isLoading
        ? const CircularProgressIndicator()
        : Row(
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
          );
  }
}
