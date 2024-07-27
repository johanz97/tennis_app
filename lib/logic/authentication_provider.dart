import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/services/firebase_services/authenticated_service.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationProvider({required this.service});

  final AuthenticatedService service;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? get user => service.user;

  Future<Either<String, Unit>> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.createUser(
      name: name,
      email: email,
      password: password,
    );

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
