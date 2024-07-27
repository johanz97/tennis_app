import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/core/widgets/image_tennis.dart';
import 'package:tennis_app/logic/favorite_provider.dart';
import 'package:tennis_app/models/court_model.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({required this.court, super.key});

  final CourtModel court;

  Future<void> _onDeleteFavorite(BuildContext context) async {
    final favoriteProvider = context.read<FavoriteProvider>();
    final response = await favoriteProvider.deleteFavorite(
      court: court,
    );

    response.fold(
      (errorMessage) {},
      (unit) {
        favoriteProvider.getFavorites();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(court.id),
      onDismissed: (_) => _onDeleteFavorite(context),
      background: Container(color: Colors.red),
      child: Row(
        children: [
          ImageTennis(urlImage: court.image, width: 50, height: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  court.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Cancha tipo ${court.type}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite, size: 16, color: Colors.red),
        ],
      ),
    );
  }
}
