import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/weather_provider.dart';
import 'package:tennis_app/models/weather_model.dart';

import '../mock_services/local_services/mock_weather_services.dart';

void main() {
  late WeatherProvider weatherProvider;
  late MockWeatherService mockWeatherService;

  setUp(() {
    mockWeatherService = MockWeatherService();
    weatherProvider = WeatherProvider(service: mockWeatherService);
  });

  group('WeatherProvider Tests', () {
    test('Initial state is correct', () {
      expect(weatherProvider.weather, isNull);
      expect(weatherProvider.isLoading, isFalse);
    });

    test('getWeather handles successful response', () async {
      // Arrange
      final weather = WeatherModel.toSet();
      when(() => mockWeatherService.fetchWeather(any()))
          .thenAnswer((_) async => right(weather));

      // Act
      final result = await weatherProvider.getWeather('Test City');

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(weatherProvider.weather, weather);
      expect(weatherProvider.isLoading, isFalse);
    });

    test('getWeather handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to fetch weather';
      when(() => mockWeatherService.fetchWeather(any()))
          .thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await weatherProvider.getWeather('Test City');

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(weatherProvider.weather, isNull);
      expect(weatherProvider.isLoading, isFalse);
    });
  });
}
