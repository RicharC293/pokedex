import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/core/extensions/context_extension.dart';
import 'package:pokemon/core/resources/constants.dart';
import 'package:pokemon/core/resources/labels.dart';
import 'package:pokemon/core/widgets/card_details.dart';
import 'package:pokemon/core/widgets/details_tile.dart';
import 'package:pokemon/core/widgets/favorite_indicator.dart';
import 'package:pokemon/core/widgets/primary_button.dart';
import 'package:pokemon/futures/catch/catch_screen.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_detail/widgets/stats_chart.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_list/notifier/pokemon_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/pokemon_detail.dart';
import '../../domain/usecase/get_pokemon_detail.dart';
import 'notifier/pokemon_detail_notifier.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({super.key, required this.id});

  final int id;

  static const routeName = '/pokemon-detail';

  @override
  Widget build(BuildContext context) {
    final useCase = context.read<GetPokemonDetail>();
    return ChangeNotifierProvider(
      create: (context) => PokemonDetailNotifier(useCase),
      child: PokemonDetailView(id: id),
    );
  }
}

class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({super.key, required this.id});

  final int id;

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    context.read<PokemonDetailNotifier>().getPokemonDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select<PokemonDetailNotifier, PokemonDetailState>(
      (notifier) => notifier.state,
    );
    final pokemonDetail = context.select<PokemonDetailNotifier, PokemonDetail?>(
      (notifier) => notifier.pokemonDetail,
    );

    final pokemonCatch = context.select<PokemonListNotifier, int>(
        (notifier) => notifier.pokemons[widget.id - 1].catchPokemon);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonDetail?.name.toUpperCase() ?? ''),
        actions: [
          if (pokemonDetail != null)
            Container(
              margin: const EdgeInsets.only(right: space6),
              padding: const EdgeInsets.symmetric(horizontal: space2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius6,
              ),
              child: Text(
                '#${pokemonDetail.order}',
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: secondary),
              ),
            ),
        ],
      ),
      body: Builder(builder: (context) {
        if (state == PokemonDetailState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state == PokemonDetailState.error) {
          return const Center(child: Text('Error'));
        }

        return ListView(
          padding: padding6,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: space6,
              runSpacing: space6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Hero(
                  tag: pokemonDetail!.name,
                  child: SvgPicture.network(
                    pokemonDetail.svgPicture,
                    height: 200,
                  ),
                ),
                const SizedBox(height: space6),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: CardDetails(
                    child: Column(
                      children: [
                        const SizedBox(height: space3),
                        DetailsTile(
                          title: height,
                          value: pokemonDetail.measureHeight,
                        ),
                        const SizedBox(height: space1),
                        DetailsTile(
                          title: weight,
                          value: pokemonDetail.measureWeight,
                        ),
                        const SizedBox(height: space1),
                        DetailsTile(
                          title: types,
                          value: pokemonDetail.types.join(' | ').toUpperCase(),
                        ),
                        const SizedBox(height: space1),
                        DetailsTile(
                          title: "Atrapados",
                          customValue: SizedBox(
                            height: 20,
                            child: Wrap(
                              children: List.generate(
                                pokemonCatch,
                                (index) {
                                  return Image.network(
                                    pokemonDetail.gifPicture,
                                    height: 20,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: space3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: space3),
            const SizedBox(height: space3),
            Center(child: Text(stats, style: context.textTheme.headlineSmall)),
            const SizedBox(height: space4),
            StatsChart(pokemonDetail: pokemonDetail),
          ],
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: space6),
          child: PrimaryButton(
            text: catchPokemon,
            onPressed: () async {
              final catchStatus = await context.pushNamed(
                CatchScreen.routeName,
                queryParameters: {'url': pokemonDetail!.gifPicture},
              );
              if (!context.mounted) return;
              if (catchStatus is bool && catchStatus) {
                context.read<PokemonListNotifier>().catchPokemon(widget.id - 1);
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final pokemon =
              context.read<PokemonListNotifier>().pokemons[widget.id - 1];
          context.read<PokemonListNotifier>().checkAsFavorite(pokemon);
        },
        child: Selector<PokemonListNotifier, bool>(
            selector: (context, notifier) =>
                notifier.pokemons[widget.id - 1].isFavorite,
            builder: (context, isFavorite, _) {
              return FavoriteIndicator(isFavorite: isFavorite);
            }),
      ),
    );
  }
}
