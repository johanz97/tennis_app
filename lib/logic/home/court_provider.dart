import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/services/local_services/court_service.dart';

class CourtProvider with ChangeNotifier {
  CourtProvider({required this.service});

  final CourtService service;

  final List<CourtModel> _courts = [];
  bool _isLoading = false;

  List<CourtModel> get courts => _courts;
  bool get isLoading => _isLoading;

  Future<Either<String, Unit>> getCourts() async {
    _courts.clear();
    _isLoading = true;
    notifyListeners();

    final response = await service.readCourts();

    return response.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();

      return left(errorMessage);
    }, (response) {
      _courts.addAll(response);
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }
}
