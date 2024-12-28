import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';
import 'package:uuid/uuid.dart';

class PokemonDto extends Pokemon {
  const PokemonDto({
    required super.id,
    required super.name,
    required super.path,
    required super.imageUrl,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) {
    return PokemonDto(
      id: Uuid().v4(),
      name: json['name'],
      path: json['url'],
      imageUrl: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'path': super.path,
      'imageUrl': super.imageUrl,
    };
  }
}
