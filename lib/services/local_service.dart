import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:tennis_app/models/booking_model.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';

class LocalService {
  Future<Either<String, Unit>> addBooking({
    required BookingModel booking,
  }) async {
    try {
      final box = await Hive.openBox<BookingModel>('bookings');
      await box.put(booking.id, booking);
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, List<BookingModel>>> readBookings() async {
    try {
      final box = await Hive.openBox<BookingModel>('bookings');
      final data = box.values.toList();
      await Hive.close();

      return right(data);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, Unit>> deleteBooking({
    required BookingModel booking,
  }) async {
    try {
      final box = await Hive.openBox<BookingModel>('bookings');
      await box.delete(booking.id);
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, Unit>> deleteAllBookings() async {
    try {
      final box = await Hive.openBox<BookingModel>('bookings');
      await box.deleteFromDisk();
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, List<CourtModel>>> readCourts() async {
    try {
      final response = await rootBundle.loadString('assets/json/courts.json');
      final data = await json.decode(response) as Map<String, dynamic>;

      return right(
        data['data'] == null
            ? []
            : (data['data'] as List).map(
                (itemWord) {
                  return CourtModel.fromMap(itemWord as Map<String, dynamic>);
                },
              ).toList(),
      );
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, List<TrainerModel>>> readTrainers() async {
    try {
      final response = await rootBundle.loadString('assets/json/trainers.json');
      final data = await json.decode(response) as Map<String, dynamic>;

      return right(
        data['data'] == null
            ? []
            : (data['data'] as List).map(
                (itemWord) {
                  return TrainerModel.fromMap(itemWord as Map<String, dynamic>);
                },
              ).toList(),
      );
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }
}
