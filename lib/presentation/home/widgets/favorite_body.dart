import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/presentation/widgets/cards/favorite_card.dart';
import 'package:tennis_app/logic/home/favorite_provider.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesCourts = context.watch<FavoriteProvider>().favoritesCourts;
    final isLoading = context.select<FavoriteProvider, bool>(
      (provider) => provider.isLoading,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Mis favoritos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Flexible(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: favoritesCourts.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FavoriteCard(court: favoritesCourts[index]),
                  ),
                ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
