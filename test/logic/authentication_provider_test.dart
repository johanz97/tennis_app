import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tennis_app/logic/authentication_provider.dart';

import '../mock_services/local_services/mock_authentication_service.dart';

void main() {
  late AuthenticationProvider authProvider;
  late MockAuthenticatedService mockService;

  setUp(() {
    mockService = MockAuthenticatedService();

    authProvider = AuthenticationProvider(service: mockService);
  });

  group('AuthenticationProvider Tests', () {
    test('Initial state is correct', () {
      expect(authProvider.isLoading, isFalse);
      expect(authProvider.user, isNull);
    });

    test('createUser handles successful response', () async {
      // Arrange
      when(
        () => mockService.createUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => right(unit));

      // Act
      final result = await authProvider.createUser(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(authProvider.isLoading, isFalse);
    });

    test('createUser handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to create user';
      when(
        () => mockService.createUser(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await authProvider.createUser(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(authProvider.isLoading, isFalse);
    });

    test('signInUser handles successful response', () async {
      // Arrange
      when(
        () => mockService.signInUser(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => right(unit));

      // Act
      final result = await authProvider.signInUser(
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(authProvider.isLoading, isFalse);
    });

    test('signInUser handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to sign in user';
      when(
        () => mockService.signInUser(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await authProvider.signInUser(
        email: 'test@example.com',
        password: 'password',
      );

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(authProvider.isLoading, isFalse);
    });

    test('logOutUser handles successful response', () async {
      // Arrange
      when(() => mockService.logOutUser()).thenAnswer((_) async => right(unit));

      // Act
      final result = await authProvider.logOutUser();

      // Assert
      expect(result, right<String, Unit>(unit));
      expect(authProvider.isLoading, isFalse);
    });

    test('logOutUser handles error response', () async {
      // Arrange
      const errorMessage = 'Failed to log out user';
      when(() => mockService.logOutUser())
          .thenAnswer((_) async => left(errorMessage));

      // Act
      final result = await authProvider.logOutUser();

      // Assert
      expect(result, left<String, Unit>(errorMessage));
      expect(authProvider.isLoading, isFalse);
    });
  });
}
