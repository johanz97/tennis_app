import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/weather_provider.dart';
import 'package:tennis_app/presentation/widgets/alerts/error_alert.dart';
import 'package:tennis_app/services/dio_services/weather_service.dart';

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

      if (!mounted) return;
      response.fold(
        (errorMessage) {
          showDialog<void>(
            context: context,
            builder: (context) => ErrorAlert(text: errorMessage),
          );
        },
        (_) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final precipitation = context.select<WeatherProvider, double>(
      (provider) => (provider.weather?.precipitation ?? 0) * 100,
    );
    final isLoading = context.select<WeatherProvider, bool>(
      (provider) => provider.isLoading,
    );

    return isLoading
        ? const CircularProgressIndicator()
        : Row(
            children: [
              Icon(
                precipitation < 15
                    ? Icons.wb_sunny_outlined
                    : precipitation > 30
                        ? Icons.cloudy_snowing
                        : Icons.cloud_queue_rounded,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text('$precipitation%'),
            ],
          );
  }
}
