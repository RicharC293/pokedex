import 'package:equatable/equatable.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';

class PokemonDetail extends Equatable {
  final int order;
  final String name;
  final int weight;
  final int height;
  final String svgPicture;
  final String gifPicture;
  final List<String> types;
  final List<Stat> stats;

  const PokemonDetail({
    required this.order,
    required this.name,
    required this.weight,
    required this.height,
    required this.svgPicture,
    required this.gifPicture,
    required this.types,
    required this.stats,
  });

  String get measureHeight => '${height/10} m';

  String get measureWeight => '${weight/10} kg';

  @override
  List<Object?> get props =>
      [order, name, weight, height, svgPicture, gifPicture, types, stats];
}

class Stat extends Equatable {
  final String name;
  final int baseStat;
  final int effort;

  const Stat({
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  @override
  List<Object?> get props => [name, baseStat, effort];
}
