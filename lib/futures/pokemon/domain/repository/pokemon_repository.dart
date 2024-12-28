import 'package:pokemon/core/resources/data_state.dart';

import '../entity/pokemon.dart';

abstract class PokemonRepository {
  Future<DataState<List<Pokemon>>> getAllPokemon({int page = 0});
}
