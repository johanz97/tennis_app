import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/trainer_model.dart';
import 'package:tennis_app/services/local_service.dart';

class TrainerProvider with ChangeNotifier {
  TrainerProvider({required this.service});

  final LocalService service;

  final List<TrainerModel> _trainers = [];
  TrainerModel? _selectedTrainer;
  bool _isLoading = false;

  List<TrainerModel> get trainers => _trainers;
  TrainerModel? get selectedTrainer => _selectedTrainer;
  bool get isLoading => _isLoading;

  set selectedTrainer(TrainerModel? value) {
    _selectedTrainer = value;
    notifyListeners();
  }

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
      if (trainers.isNotEmpty) _selectedTrainer = _trainers.first;
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }
}
