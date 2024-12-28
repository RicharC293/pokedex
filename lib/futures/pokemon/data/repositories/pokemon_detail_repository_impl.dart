import 'package:flutter/material.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entity/pokemon_detail.dart';
import '../../domain/repository/pokemon_detail_repository.dart';
import '../sources/poke_api.dart';

class PokemonDetailRepositoryImpl extends PokemonDetailRepository {
  PokemonDetailRepositoryImpl(this._pokeApi);

  final PokeApi _pokeApi;

  @override
  Future<DataState<PokemonDetail>> getPokemonDetail(int id) async {
    try {
      final result = await _pokeApi.loadPokemonDetail(id);
      return DataSuccess(result);
    } on FlutterError catch (error) {
      return DataFailed(error);
    }
  }
}
