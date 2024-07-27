import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/booking/trainer_provider.dart';
import 'package:tennis_app/models/trainer_model.dart';

import '../../mock_services/local_services/mock_court_service.dart';

void main() {
  late TrainerProvider trainerProvider;
  late MockCourtService mockCourtService;

  setUp(() {
    mockCourtService = MockCourtService();
    trainerProvider = TrainerProvider(service: mockCourtService);
  });

  group('TrainerProvider Tests', () {
    test('getTrainers handles successful response', () async {
      // Arrange
      final trainers = [TrainerModel.toTest(), TrainerModel.toTest()];
      when(() => mockCourtService.readTrainers()).thenAnswer(
        (_) async => right(trainers),
      );

      // Act
      final result = await trainerProvider.getTrainers();

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(trainerProvider.trainers, trainers);
      expect(trainerProvider.isLoading, isFalse);
    });

    test('getTrainers handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to load trainers';
      when(() => mockCourtService.readTrainers()).thenAnswer(
        (_) async => left(errorMessage),
      );

      // Act
      final result = await trainerProvider.getTrainers();

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(trainerProvider.trainers, isEmpty);
      expect(trainerProvider.isLoading, isFalse);
    });

    test('getTrainers updates loading state', () async {
      // Arrange
      when(() => mockCourtService.readTrainers()).thenAnswer(
        (_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return right([]);
        },
      );

      // Act
      final Future<void> future = trainerProvider.getTrainers();

      // Assert
      expect(trainerProvider.isLoading, isTrue);
      await future;
      expect(trainerProvider.isLoading, isFalse);
    });
  });
}
