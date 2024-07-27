import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/home/court_provider.dart';
import 'package:tennis_app/models/court_model.dart';

import '../../mock_services/local_services/mock_court_service.dart';

void main() {
  late CourtProvider courtProvider;
  late MockCourtService mockCourtService;

  setUp(() {
    mockCourtService = MockCourtService();
    courtProvider = CourtProvider(service: mockCourtService);
  });

  group('CourtProvider Tests', () {
    test('Initial state is correct', () {
      expect(courtProvider.courts, isEmpty);
      expect(courtProvider.isLoading, isFalse);
    });

    test('getCourts handles successful response', () async {
      // Arrange
      final courts = [CourtModel.toTest(), CourtModel.toTest()];
      when(() => mockCourtService.readCourts()).thenAnswer(
        (_) async => right(courts),
      );

      // Act
      final result = await courtProvider.getCourts();

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(courtProvider.courts, courts);
      expect(courtProvider.isLoading, isFalse);
    });

    test('getCourts handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to load courts';
      when(() => mockCourtService.readCourts()).thenAnswer(
        (_) async => left(errorMessage),
      );

      // Act
      final result = await courtProvider.getCourts();

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(courtProvider.courts, isEmpty);
      expect(courtProvider.isLoading, isFalse);
    });
  });
}
