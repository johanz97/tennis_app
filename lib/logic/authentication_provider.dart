import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/services/firebase_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({required this.service});

  final FirebaseService service;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<Either<String, Unit>> createUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.createUser(email: email, password: password);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> signInUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.signInUser(email: email, password: password);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> logOutUser() async {
    _isLoading = true;
    notifyListeners();

    final response = await service.logOutUser();

    _isLoading = false;
    notifyListeners();

    return response;
  }
}
