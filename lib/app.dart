import 'package:flutter/material.dart';
import 'package:pokemon/core/config/router.dart';
import 'package:pokemon/core/network/network.dart';
import 'package:pokemon/core/resources/theme.dart';
import 'package:pokemon/futures/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/futures/pokemon/data/sources/poke_api.dart';
import 'package:pokemon/futures/pokemon/domain/usecase/get_pokemon_detail.dart';
import 'package:provider/provider.dart';

import 'futures/pokemon/data/repositories/pokemon_detail_repository_impl.dart';
import 'futures/pokemon/domain/usecase/get_all_pokemon.dart';
import 'futures/pokemon/presentation/pokemon_list/notifier/pokemon_list_notifier.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GetAllPokemon _getAllPokemon;
  late GetPokemonDetail _getPokemonDetail;

  @override
  void initState() {
    super.initState();
    _dependencyInjection();
  }

  void _dependencyInjection() {
    final network = Network();
    final pokeApi = PokeApiImpl(network);
    final allPokemonRepo = PokemonRepositoryImpl(pokeApi);
    final detailPokemonRepo = PokemonDetailRepositoryImpl(pokeApi);
    _getAllPokemon = GetAllPokemon(repository: allPokemonRepo);
    _getPokemonDetail = GetPokemonDetail(repository: detailPokemonRepo);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _getAllPokemon),
        Provider.value(value: _getPokemonDetail),
      ],
      child: MaterialApp.router(
        title: 'Poke dex',
        theme: theme,
        routerConfig: router,
        builder: (context, child) {
          final useCase = context.read<GetAllPokemon>();
          return ChangeNotifierProvider(
            create: (context) => PokemonListNotifier(getAllPokemon: useCase),
            child: child!,
          );
        },
      ),
    );
  }
}
