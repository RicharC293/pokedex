import 'package:flutter/material.dart';

class FavoriteIndicator extends StatelessWidget {
  const FavoriteIndicator({super.key, required this.isFavorite});

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.grey,
      size: 35,
    );
  }
}
