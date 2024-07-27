import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/trainer_model.dart';
import 'package:tennis_app/services/local_services/court_service.dart';

class TrainerProvider with ChangeNotifier {
  TrainerProvider({required this.service});

  final CourtService service;

  final List<TrainerModel> _trainers = [];
  bool _isLoading = false;

  List<TrainerModel> get trainers => _trainers;
  bool get isLoading => _isLoading;

  Future<Either<String, Unit>> getTrainers() async {
    _trainers.clear();
    _isLoading = true;
    notifyListeners();

    final response = await service.readTrainers();

    return response.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();

      return left(errorMessage);
    }, (response) {
      _trainers.addAll(response);
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }
}
