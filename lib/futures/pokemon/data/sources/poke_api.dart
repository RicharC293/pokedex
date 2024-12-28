import 'package:pokemon/core/network/network.dart';
import 'package:pokemon/futures/pokemon/data/dto/pokemon_detail_dto.dart';
import 'package:pokemon/futures/pokemon/data/dto/pokemon_dto.dart';

abstract class PokeApi {
  Future<List<PokemonDto>> loadAllPokemon({int page = 0});

  Future<PokemonDetailDto> loadPokemonDetail(int id);
}

class PokeApiImpl implements PokeApi {
  PokeApiImpl(this._client);

  final Network _client;

  @override
  Future<List<PokemonDto>> loadAllPokemon({int page = 0}) async {
    final response =
        await _client.request().get('/pokemon?limit=20&offset=${page * 20}');
    final json = response.data['results'] as List;
    return json.map((e) => PokemonDto.fromJson(e)).toList();
  }

  @override
  Future<PokemonDetailDto> loadPokemonDetail(int id) async {
    final response = await _client.request().get('/pokemon/$id');
    return PokemonDetailDto.fromJson(response.data);
  }
}
