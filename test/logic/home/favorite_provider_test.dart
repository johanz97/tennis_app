import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/home/favorite_provider.dart';
import 'package:tennis_app/models/court_model.dart';

import '../../mock_services/local_services/mock_favorite_service.dart';

void main() {
  late FavoriteProvider favoriteProvider;
  late MockFavoriteService mockFavoriteService;

  setUp(() {
    mockFavoriteService = MockFavoriteService();
    favoriteProvider = FavoriteProvider(service: mockFavoriteService);
  });

  group('FavoriteProvider Tests', () {
    test('Initial state is correct', () {
      expect(favoriteProvider.favoritesCourts, isEmpty);
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('addFavorite handles successful response', () async {
      // Arrange
      final court = CourtModel.toTest();
      when(() => mockFavoriteService.addFavorite(court: court)).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      final result = await favoriteProvider.addFavorite(court);

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('addFavorite handles error response', () async {
      // Arrange
      final court = CourtModel.toTest();
      const errorMessage = 'Failed to add favorite';
      when(() => mockFavoriteService.addFavorite(court: court)).thenAnswer(
        (_) async => left(errorMessage),
      );

      // Act
      final result = await favoriteProvider.addFavorite(court);

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('getFavorites handles successful response', () async {
      // Arrange
      final courts = [
        CourtModel.toTest(),
        CourtModel.toTest(),
      ];
      when(() => mockFavoriteService.readFavorites()).thenAnswer(
        (_) async => right(courts),
      );

      // Act
      final result = await favoriteProvider.getFavorites();

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(favoriteProvider.favoritesCourts, courts);
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('getFavorites handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to load favorites';
      when(() => mockFavoriteService.readFavorites()).thenAnswer(
        (_) async => left(errorMessage),
      );

      // Act
      final result = await favoriteProvider.getFavorites();

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(favoriteProvider.favoritesCourts, isEmpty);
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('deleteFavorite handles successful response', () async {
      // Arrange
      final court = CourtModel.toTest();
      when(() => mockFavoriteService.deleteFavorite(court: court)).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      final result = await favoriteProvider.deleteFavorite(court: court);

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('deleteFavorite handles error response', () async {
      // Arrange
      final court = CourtModel.toTest();
      const errorMessage = 'Failed to delete favorite';
      when(() => mockFavoriteService.deleteFavorite(court: court)).thenAnswer(
        (_) async => left(errorMessage),
      );

      // Act
      final result = await favoriteProvider.deleteFavorite(court: court);

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(favoriteProvider.isLoading, isFalse);
    });

    test('deleteAllFavorites handles successful response', () async {
      // Arrange
      when(() => mockFavoriteService.deleteAllFavorites()).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      final result = await favoriteProvider.deleteAllFavorites();

      // Assert
      expect(result, right<String, Unit>(unit));
    });

    test('isFavorite returns false for non-existing favorite', () {
      // Act
      final result = favoriteProvider.isFavorite('1');

      // Assert
      expect(result, isFalse);
    });
  });
}
