import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/logic/home/favorite_provider.dart';
import 'package:tennis_app/models/court_model.dart';
import 'package:tennis_app/presentation/widgets/alerts/confirm_operation.dart';
import 'package:tennis_app/presentation/widgets/alerts/error_alert.dart';
import 'package:tennis_app/presentation/widgets/image_tennis.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({required this.court, super.key});

  final CourtModel court;

  Future<void> _onDeleteFavorite(BuildContext context) async {
    final favoriteProvider = context.read<FavoriteProvider>();
    final response = await favoriteProvider.deleteFavorite(
      court: court,
    );

    response.fold(
      (errorMessage) {
        if (!context.mounted) return;
        showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );
      },
      (unit) {
        favoriteProvider.getFavorites();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(court.id),
      confirmDismiss: (direction) async => showDialog(
        context: context,
        builder: (context) => const ConfirmOperationAlert(
          text: '¿Desea quitar de favoritos?',
        ),
      ),
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
