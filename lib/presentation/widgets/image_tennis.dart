import 'package:flutter/material.dart';

class ImageTennis extends StatelessWidget {
  const ImageTennis({
    required this.urlImage,
    this.width,
    this.height,
    super.key,
  });

  final String urlImage;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: urlImage.isNotEmpty
          ? Image.network(
              urlImage,
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              fit: BoxFit.fill,
            )
          : Image.asset(
              'assets/images/authenticated_background.png',
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              fit: BoxFit.fill,
            ),
    );
  }
}
