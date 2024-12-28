import 'package:flutter/material.dart';
import 'package:pokemon/core/resources/data_state.dart';
import 'package:pokemon/futures/pokemon/data/sources/poke_api.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';
import 'package:pokemon/futures/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl(this._pokeApi);

  final PokeApi _pokeApi;

  @override
  Future<DataState<List<Pokemon>>> getAllPokemon({int page = 0}) async {
    try {
      final result = await _pokeApi.loadAllPokemon(page: page);
      return DataSuccess(result);
    } on FlutterError catch (error) {
      return DataFailed(error);
    }
  }
}
