import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/entity/pokemon.dart';
import '../../../domain/usecase/get_all_pokemon.dart';

enum PokemonPageStatus { initial, loading, success, failed }

class PokemonListNotifier extends ChangeNotifier {
  PokemonListNotifier({
    required GetAllPokemon getAllPokemon,
    List<Pokemon>? pokemons,
    PokemonPageStatus? initialStatus,
    int? initialPage,
  })  : _getAllPokemon = getAllPokemon,
        _pokemons = <Pokemon>[],
        _status = PokemonPageStatus.initial,
        _currentPage = initialPage ?? 0;

  /// Use cases
  final GetAllPokemon _getAllPokemon;

  /// Properties
  List<Pokemon> _pokemons;

  List<Pokemon> _pokemonAux = [];

  List<Pokemon> get pokemons => _pokemons;

  List<Pokemon> get pokemonAux => _pokemonAux;

  PokemonPageStatus _status;

  PokemonPageStatus get status => _status;

  int _currentPage;

  int get currentPage => _currentPage;

  bool _hasReachedEnd = false;

  bool get hasReachedEnd => _hasReachedEnd;

  /// Actions
  Future<void> fetchAllPokemon() async {
    if (_status == PokemonPageStatus.loading) return;

    _status = PokemonPageStatus.loading;
    notifyListeners();

    final result = await _getAllPokemon(page: _currentPage);
    _currentPage++;
    _pokemons = [..._pokemons, ...result.data!];
    _pokemonAux = _pokemons;
    _status = result is DataSuccess
        ? PokemonPageStatus.success
        : PokemonPageStatus.failed;
    _hasReachedEnd = result.data!.isEmpty;
    notifyListeners();
  }

  void checkAsFavorite(Pokemon pokemon) {
    _pokemons = _pokemons.map((e) {
      if (e.path == pokemon.path) {
        return e.copyWith(id: Uuid().v4(), isFavorite: !e.isFavorite);
      }
      return e;
    }).toList();
    notifyListeners();
  }

  void catchPokemon(int position) {
    _pokemons = _pokemons.map((e) {
      if (e.path == _pokemons[position].path) {
        return e.copyWith(id: Uuid().v4(), catchPokemon: e.catchPokemon + 1);
      }
      return e;
    }).toList();
    notifyListeners();
  }

  void filterPokemon(String query) {
    if (query.isEmpty) {
      _pokemons = _pokemonAux;
      notifyListeners();
    }
    _pokemons = _pokemons
        .where((element) =>
            element.name.toUpperCase().contains(query.toUpperCase()))
        .toList();
    notifyListeners();
  }
}
