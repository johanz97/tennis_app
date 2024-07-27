import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tennis_app/models/booking_model.dart';

class BookingService {
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
}
