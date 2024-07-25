import 'package:flutter/material.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/authenticated_background.png',
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Epic Box',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Cancha tipo A',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const Icon(Icons.favorite, size: 16),
      ],
    );
  }
}
