import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/booking/summary_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';

class MockCourtModel extends Mock implements CourtModel {}

class MockTrainerModel extends Mock implements TrainerModel {}

void main() {
  late SummaryProvider summaryProvider;
  late CourtModel court;
  late TrainerModel trainer;

  setUp(() {
    court = MockCourtModel();
    trainer = MockTrainerModel();

    // Mock properties of court
    when(() => court.id).thenReturn('court_id');
    when(() => court.image).thenReturn('image_url');
    when(() => court.name).thenReturn('Court Name');
    when(() => court.type).thenReturn('Court Type');
    when(() => court.address).thenReturn('Court Address');
    when(() => court.cost).thenReturn('10.0');

    summaryProvider = SummaryProvider(court: court);
  });

  group('SummaryProvider Tests', () {
    test('Initial state is correct', () {
      expect(summaryProvider.selectedTrainer, isNull);
      expect(summaryProvider.selectedDate, isNull);
      expect(summaryProvider.selectedFirstTime, isNull);
      expect(summaryProvider.selectedLastTime, isNull);
    });

    test('Setting and getting selectedTrainer works correctly', () {
      // Arrange
      when(() => trainer.name).thenReturn('Trainer Name');

      // Act
      summaryProvider.selectedTrainer = trainer;

      // Assert
      expect(summaryProvider.selectedTrainer, trainer);
    });

    test('Setting and getting selectedDate works correctly', () {
      // Arrange
      final date = DateTime(2024);

      // Act
      summaryProvider.selectedDate = date;

      // Assert
      expect(summaryProvider.selectedDate, date);
    });

    test('Setting and getting selectedFirstTime works correctly', () {
      // Arrange
      final firstTime = DateTime(2024, 1, 1, 10);

      // Act
      summaryProvider.selectedFirstTime = firstTime;

      // Assert
      expect(summaryProvider.selectedFirstTime, firstTime);
    });

    test('Setting and getting selectedLastTime works correctly', () {
      // Arrange
      final lastTime = DateTime(2024, 1, 1, 12);

      // Act
      summaryProvider.selectedLastTime = lastTime;

      // Assert
      expect(summaryProvider.selectedLastTime, lastTime);
    });

    test('timeToUse calculates the correct difference', () {
      // Arrange
      summaryProvider
        ..selectedFirstTime = DateTime(2024, 1, 1, 10)
        ..selectedLastTime = DateTime(2024, 1, 1, 12);

      // Act
      final timeToUse = summaryProvider.timeToUse;

      // Assert
      expect(timeToUse, 2); // 2 hours difference
    });

    test('totalPrice calculates the correct total cost', () {
      // Arrange
      summaryProvider
        ..selectedFirstTime = DateTime(2024, 1, 1, 10)
        ..selectedLastTime = DateTime(2024, 1, 1, 12);
      when(() => trainer.name).thenReturn('Trainer Name');

      // Act
      final totalPrice = summaryProvider.totalPrice;

      // Assert
      expect(totalPrice, '20.00'); // 2 hours * $10.0 per hour
    });

    test('clearData resets all fields to null', () {
      // Arrange
      summaryProvider
        ..selectedTrainer = trainer
        ..selectedDate = DateTime(2024)
        ..selectedFirstTime = DateTime(2024, 1, 1, 10)
        ..selectedLastTime = DateTime(2024, 1, 1, 12)

        // Act
        ..clearData();

      // Assert
      expect(summaryProvider.selectedTrainer, isNull);
      expect(summaryProvider.selectedDate, isNull);
      expect(summaryProvider.selectedFirstTime, isNull);
      expect(summaryProvider.selectedLastTime, isNull);
    });
  });
}
