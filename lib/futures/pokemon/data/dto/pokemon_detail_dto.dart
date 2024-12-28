import 'package:pokemon/futures/pokemon/domain/entity/pokemon_detail.dart';

class PokemonDetailDto extends PokemonDetail {
  const PokemonDetailDto({
    required super.order,
    required super.name,
    required super.weight,
    required super.height,
    required super.svgPicture,
    required super.gifPicture,
    required super.types,
    required super.stats,
  });

  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    return PokemonDetailDto(
      order: json['order'],
      name: json['name'],
      weight: json['weight'],
      height: json['height'],
      svgPicture: json['sprites']['other']['dream_world']['front_default'],
      gifPicture: json['sprites']['other']['showdown']['front_default'],
      types: (json['types'] as List)
          .map((e) => e['type']?['name'].toString() ?? "")
          .where((e) => e.isNotEmpty)
          .toList(),
      stats: List<Stat>.from(json['stats'].map((x) => StatDto.fromJson(x))),
    );
  }
}

class StatDto extends Stat {
  const StatDto({
    required super.name,
    required super.baseStat,
    required super.effort,
  });

  factory StatDto.fromJson(Map<String, dynamic> json) {
    return StatDto(
      name: json['stat']?['name'] ?? "unknown",
      baseStat: json['base_stat'] ?? 0,
      effort: json['effort'] ?? 0,
    );
  }
}
