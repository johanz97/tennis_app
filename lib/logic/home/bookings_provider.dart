import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/booking_model.dart';
import 'package:tennis_app/services/local_services/booking_service.dart';

class BookingsProvider with ChangeNotifier {
  BookingsProvider({required this.service});

  final BookingService service;

  final List<BookingModel> _bookings = [];
  bool _isLoading = false;

  List<BookingModel> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<Either<String, Unit>> addBooking(BookingModel booking) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.addBooking(booking: booking);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> getBookings() async {
    _bookings.clear();
    _isLoading = true;
    notifyListeners();

    final response = await service.readBookings();

    return response.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();

      return left(errorMessage);
    }, (response) {
      _bookings.addAll(response);
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }

  Future<Either<String, Unit>> deleteBooking({
    required BookingModel booking,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.deleteBooking(booking: booking);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> deleteAllBooking() async {
    final response = await service.deleteAllBookings();

    return response;
  }
}
