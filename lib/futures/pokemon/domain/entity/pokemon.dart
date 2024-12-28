import 'package:equatable/equatable.dart';
import 'package:pokemon/core/resources/constants.dart';

class Pokemon extends Equatable {
  final String id;
  final String name;
  final String path;
  final String imageUrl;
  final bool isFavorite;
  final int catchPokemon;

  const Pokemon({
    required this.id,
    required this.name,
    required this.path,
    required this.imageUrl,
    this.isFavorite = false,
    this.catchPokemon = 0,
  });

  Pokemon copyWith({
    String? id,
    String? name,
    String? path,
    String? imageUrl,
    bool? isFavorite,
    int? catchPokemon,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      catchPokemon: catchPokemon ?? this.catchPokemon,
    );
  }

  String svgPokemon(int index) {
    return baseSvgPicture.replaceAll("<INDEX>", (index + 1).toString());
  }

  @override
  List<Object?> get props => [id, name, path, imageUrl];
}
