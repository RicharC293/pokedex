import 'package:flutter/widgets.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/entity/pokemon_detail.dart';
import '../../../domain/usecase/get_pokemon_detail.dart';

enum PokemonDetailState {
  loading,
  loaded,
  error,
}

class PokemonDetailNotifier extends ChangeNotifier {
  PokemonDetailNotifier(this._getPokemonDetail);

  /// Use cases
  final GetPokemonDetail _getPokemonDetail;

  /// Properties

  PokemonDetail? _pokemonDetail;

  PokemonDetail? get pokemonDetail => _pokemonDetail;

  PokemonDetailState _state = PokemonDetailState.loading;

  PokemonDetailState get state => _state;

  int get maxStat =>
      _pokemonDetail?.stats.map((e) => e.baseStat).reduce((a, b) => a + b) ?? 0;

  /// Actions
  void getPokemonDetail(int id) async {
    try {
      if (id == _pokemonDetail?.order) return;
      final result = await _getPokemonDetail(id);
      _pokemonDetail = result.data;
      _state = result is DataSuccess
          ? PokemonDetailState.loaded
          : PokemonDetailState.error;
    } catch (e) {
      _state = PokemonDetailState.error;
    } finally {
      notifyListeners();
    }
  }
}
