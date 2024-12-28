import 'package:pokemon/futures/pokemon/domain/repository/pokemon_detail_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../entity/pokemon_detail.dart';

class GetPokemonDetail {
  GetPokemonDetail({
    required PokemonDetailRepository repository,
  }) : _repository = repository;

  final PokemonDetailRepository _repository;

  Future<DataState<PokemonDetail>> call(int id) async {
    final detail = await _repository.getPokemonDetail(id);
    return detail;
  }
}
