import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tennis_app/models/court_model.dart';

class FavoriteService {
  Future<Either<String, Unit>> addFavorite({
    required CourtModel court,
  }) async {
    try {
      final box = await Hive.openBox<CourtModel>('favorites');
      await box.put(court.id, court);
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, List<CourtModel>>> readFavorites() async {
    try {
      final box = await Hive.openBox<CourtModel>('favorites');
      final data = box.values.toList();
      await Hive.close();

      return right(data);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, Unit>> deleteFavorite({
    required CourtModel court,
  }) async {
    try {
      final box = await Hive.openBox<CourtModel>('favorites');
      await box.delete(court.id);
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }

  Future<Either<String, Unit>> deleteAllFavorites() async {
    try {
      final box = await Hive.openBox<CourtModel>('favorites');
      await box.deleteFromDisk();
      await Hive.close();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado');
    }
  }
}
