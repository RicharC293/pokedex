import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/core/extensions/context_extension.dart';
import 'package:pokemon/core/resources/constants.dart';
import 'package:pokemon/core/widgets/card_pokemon.dart';
import 'package:pokemon/core/widgets/custom_grid_view.dart';
import 'package:pokemon/futures/pokemon/domain/entity/pokemon.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_list/notifier/pokemon_list_notifier.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  static const routeName = '/pokemon-list';

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late ScrollController _scrollController;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokemonListNotifier>().fetchAllPokemon();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final list = context.select<PokemonListNotifier, List<Pokemon>>(
        (notifier) => notifier.pokemons);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: padding6,
          controller: _scrollController,
          children: [
            Image.asset(
              'assets/images/pokemon.png',
              width: 250,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: space6),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Pokemon',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 2000), () {
                  context.read<PokemonListNotifier>().filterPokemon(value);
                });
              },
            ),
            const SizedBox(height: space6),
            LayoutBuilder(builder: (context, constraints) {
              return CustomGridView(
                builder: (context, index) {
                  return Hero(
                    tag: list[index].name,
                    child: CardPokemon(
                      index: index,
                      pokemon: list[index],
                      onPressed: () => context.push(
                        "${PokemonDetailScreen.routeName}/${index + 1}",
                      ),
                      onFavoritePressed: () {
                        final pokemon = list[index];
                        context
                            .read<PokemonListNotifier>()
                            .checkAsFavorite(pokemon);
                      },
                    ),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                crossAxisSpacing: space2,
                separatorHeight: space2,
                crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
              );
            })
          ],
        ),
      ),
    );
  }
}
