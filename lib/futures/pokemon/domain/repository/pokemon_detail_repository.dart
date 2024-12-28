import 'package:pokemon/core/resources/data_state.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon_detail.dart';

abstract class PokemonDetailRepository {
  Future<DataState<PokemonDetail>> getPokemonDetail(int id);
}
