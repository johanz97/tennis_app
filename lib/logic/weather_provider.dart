import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/weather_model.dart';
import 'package:tennis_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider({required this.service});

  final WeatherService service;
  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<Either<String, Unit>> getWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.fetchWeather(city);

    return response.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();

      return left(errorMessage);
    }, (response) {
      _weather = response;
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }
}
