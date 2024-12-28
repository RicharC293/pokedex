import 'package:pokemon/core/resources/data_state.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';
import 'package:pokemon/futures/pokemon/domain/repository/pokemon_repository.dart';

class GetAllPokemon {
  GetAllPokemon({
    required PokemonRepository repository,
  }) : _repository = repository;

  final PokemonRepository _repository;

  Future<DataState<List<Pokemon>>> call({int page = 0}) async {
    final list = await _repository.getAllPokemon(page: page);
    return list;
  }
}
