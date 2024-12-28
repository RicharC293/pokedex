import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon/core/extensions/context_extension.dart';
import 'package:pokemon/core/resources/constants.dart';
import 'package:pokemon/core/widgets/favorite_indicator.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    super.key,
    this.onPressed,
    this.onFavoritePressed,
    required this.pokemon,
    required this.index,
  });

  final int index;
  final Pokemon pokemon;
  final VoidCallback? onPressed;
  final VoidCallback? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: card.withValues(alpha: 0.2),
      elevation: 10,
      shadowColor: card.withValues(alpha: 0.1),
      child: Padding(
        padding: padding2,
        child: Stack(
          children: [
            GestureDetector(
              onTap: onPressed,
              child: Center(
                child: Column(
                  children: [
                    SvgPicture.network(
                      pokemon.svgPokemon(index),
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                    Text(
                      pokemon.name,
                      style: context.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: FavoriteIndicator(isFavorite: pokemon.isFavorite),
                onPressed: onFavoritePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
