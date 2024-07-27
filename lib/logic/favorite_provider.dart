import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/services/favorite_service.dart';

class FavoriteProvider with ChangeNotifier {
  FavoriteProvider({required this.service});

  final FavoriteService service;

  final List<CourtModel> _favoritesCourts = [];
  bool _isLoading = false;

  List<CourtModel> get favoritesCourts => _favoritesCourts;
  bool get isLoading => _isLoading;

  bool isFavorite(String id) {
    return _favoritesCourts.where((court) => court.id == id).isNotEmpty;
  }

  Future<Either<String, Unit>> addFavorite(CourtModel court) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.addFavorite(court: court);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> getFavorites() async {
    _favoritesCourts.clear();
    _isLoading = true;
    notifyListeners();

    final response = await service.readFavorites();

    return response.fold((errorMessage) {
      _isLoading = false;
      notifyListeners();

      return left(errorMessage);
    }, (response) {
      _favoritesCourts.addAll(response);
      _isLoading = false;
      notifyListeners();

      return right(unit);
    });
  }

  Future<Either<String, Unit>> deleteFavorite({
    required CourtModel court,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await service.deleteFavorite(court: court);

    _isLoading = false;
    notifyListeners();

    return response;
  }

  Future<Either<String, Unit>> deleteAllFavorites() async {
    final response = await service.deleteAllFavorites();

    return response;
  }
}
