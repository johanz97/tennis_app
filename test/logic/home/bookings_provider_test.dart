import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/home/bookings_provider.dart';
import 'package:tennis_app/models/booking_model.dart';

import '../../mock_services/local_services/mock_booking_service.dart';

void main() {
  late BookingsProvider bookingsProvider;
  late MockBookingService mockBookingService;

  setUp(() {
    mockBookingService = MockBookingService();
    bookingsProvider = BookingsProvider(service: mockBookingService);
  });

  group('BookingsProvider Tests', () {
    test('Initial state is correct', () {
      expect(bookingsProvider.bookings, isEmpty);
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('addBooking handles successful response', () async {
      // Arrange
      final booking = BookingModel.toTest();
      when(() => mockBookingService.addBooking(booking: booking))
          .thenAnswer((_) async => right(unit));

      // Act
      final result = await bookingsProvider.addBooking(booking);

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('addBooking handles error response', () async {
      // Arrange
      final booking = BookingModel.toTest();
      const errorMessage = 'Failed to add booking';
      when(() => mockBookingService.addBooking(booking: booking))
          .thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await bookingsProvider.addBooking(booking);

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('getBookings handles successful response', () async {
      // Arrange
      final bookings = [
        BookingModel.toTest(),
        BookingModel.toTest(),
      ];
      when(() => mockBookingService.readBookings())
          .thenAnswer((_) async => right(bookings));

      // Act
      final result = await bookingsProvider.getBookings();

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(bookingsProvider.bookings, equals(bookings));
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('getBookings handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to load bookings';
      when(() => mockBookingService.readBookings())
          .thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await bookingsProvider.getBookings();

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(bookingsProvider.bookings, isEmpty);
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('deleteBooking handles successful response', () async {
      // Arrange
      final booking = BookingModel.toTest();
      when(() => mockBookingService.deleteBooking(booking: booking))
          .thenAnswer((_) async => right(unit));

      // Act
      final result = await bookingsProvider.deleteBooking(booking: booking);

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('deleteBooking handles error response', () async {
      // Arrange
      final booking = BookingModel.toTest();
      const errorMessage = 'Failed to delete booking';
      when(() => mockBookingService.deleteBooking(booking: booking))
          .thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await bookingsProvider.deleteBooking(booking: booking);

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(bookingsProvider.isLoading, isFalse);
    });

    test('deleteAllBooking handles successful response', () async {
      // Arrange
      when(() => mockBookingService.deleteAllBookings())
          .thenAnswer((_) async => right(unit));

      // Act
      final result = await bookingsProvider.deleteAllBooking();

      // Assert
      expect(result, right<String, Unit>(unit));
    });
  });
}
