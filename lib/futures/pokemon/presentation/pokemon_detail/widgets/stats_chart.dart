import 'package:flutter/material.dart';
import 'package:pokemon/core/extensions/context_extension.dart';
import 'package:pokemon/core/resources/constants.dart';
import 'package:pokemon/core/resources/enums.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon_detail.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({super.key, required this.pokemonDetail});

  final PokemonDetail pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double size = (constraints.maxWidth * 0.7).clamp(0.0, 300.0);
      final strokeWidth = 10.0;
      return Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: space4,
            children: List.generate(pokemonDetail.stats.length, (index) {
              final pokemonStat = pokemonDetail.stats[index];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: space2),
                    decoration: BoxDecoration(
                      color: ColorStat.values[index].color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                      "${pokemonStat.name.toUpperCase()}: ${pokemonStat.baseStat}"),
                ],
              );
            }),
          ),
          const SizedBox(height: space4),
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    pokemonDetail.gifPicture,
                    width: size / 3,
                  ),
                ),
                ...List.generate(pokemonDetail.stats.length, (index) {
                  return Center(
                    child: SizedBox(
                      width: size - (index * 3 * strokeWidth),
                      height: size - (index * 3 * strokeWidth),
                      child: Transform.flip(
                        flipX: true,
                        child: CircularProgressIndicator(
                          color: ColorStat.values[index].color,
                          value: pokemonDetail.stats[index].baseStat / 255,
                          strokeWidth: strokeWidth,
                          strokeCap: StrokeCap.round,
                          backgroundColor: context.theme.colorScheme.secondary
                              .withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      );
    });
  }
}
