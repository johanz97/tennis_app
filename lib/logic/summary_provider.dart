import 'package:flutter/material.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';

class SummaryProvider with ChangeNotifier {
  SummaryProvider(this.court);

  final CourtModel court;

  TrainerModel? _selectedTrainer;
  DateTime? _selectedDate;
  DateTime? _selectedFirstTime;
  DateTime? _selectedLastTime;

  TrainerModel? get selectedTrainer => _selectedTrainer;
  DateTime? get selectedDate => _selectedDate;
  DateTime? get selectedFirstTime => _selectedFirstTime;
  DateTime? get selectedLastTime => _selectedLastTime;

  int get timeToUse {
    final difference = _selectedLastTime!
        .difference(
          _selectedFirstTime!,
        )
        .inHours;

    return difference;
  }

  String get totalPrice {
    final price = double.parse(court.cost);

    return (timeToUse * price).toStringAsFixed(2);
  }

  set selectedTrainer(TrainerModel? value) {
    _selectedTrainer = value;
    notifyListeners();
  }

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  set selectedFirstTime(DateTime? value) {
    _selectedFirstTime = value;
    notifyListeners();
  }

  set selectedLastTime(DateTime? value) {
    _selectedLastTime = value;
    notifyListeners();
  }

  void clearData() {
    _selectedTrainer = null;
    _selectedDate = null;
    _selectedFirstTime = null;
    _selectedLastTime = null;
    notifyListeners();
  }
}
