import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/models/trainer_model.dart';

class CourtService {
  Future<Either<String, List<CourtModel>>> readCourts() async {
    try {
      final response = await rootBundle.loadString('assets/json/courts.json');
      final data = await json.decode(response) as Map<String, dynamic>;

      return right(
        data['data'] == null
            ? []
            : (data['data'] as List).map(
                (itemWord) {
                  return CourtModel.fromMap(itemWord as Map<String, dynamic>);
                },
              ).toList(),
      );
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, List<TrainerModel>>> readTrainers() async {
    try {
      final response = await rootBundle.loadString('assets/json/trainers.json');
      final data = await json.decode(response) as Map<String, dynamic>;

      return right(
        data['data'] == null
            ? []
            : (data['data'] as List).map(
                (itemWord) {
                  return TrainerModel.fromMap(itemWord as Map<String, dynamic>);
                },
              ).toList(),
      );
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }
}
