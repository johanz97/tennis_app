import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/core/dio_interceptors.dart';
import 'package:tennis_app/core/environment.dart';
import 'package:tennis_app/models/weather_model.dart';

class WeatherService extends DioInterceptors {
  WeatherService(super.dioClient);

  Future<Either<String, WeatherModel?>> fetchWeather(String city) async {
    try {
      final response = await dioWithInterceptors.get<Map<String, dynamic>>(
        'http://api.weatherapi.com/v1/current.json?key=${Environment.apiWeather}&q=$city&aqi=no',
      );

      return right(
        response.data?['current'] == null
            ? null
            : WeatherModel.fromMap(
                response.data!['current']! as Map<String, dynamic>,
              ),
      );
    } on DioException catch (err) {
      debugPrint(err.toString());

      return left('Error del servidor.');
    } catch (err) {
      debugPrint(err.toString());
      return left('Error inesperado.');
    }
  }
}
