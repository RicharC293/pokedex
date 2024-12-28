import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';
import 'package:pokemon/futures/splash/splash_screen.dart';

import '../../futures/catch/catch_screen.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: PokemonListScreen.routeName,
      name: PokemonListScreen.routeName,
      pageBuilder: (context, state) {
        final extraData = state.extra as Map<String, dynamic>?;
        if (extraData != null && extraData['loading'] == true) {
          return CustomTransitionPage(
            child: PokemonListScreen(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        }
        return NoTransitionPage(child: PokemonListScreen());
      },
    ),
    GoRoute(
      path: "${PokemonDetailScreen.routeName}/:id",
      name: PokemonDetailScreen.routeName,
      builder: (context, state) => PokemonDetailScreen(
        id: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: CatchScreen.routeName,
      name: CatchScreen.routeName,
      builder: (context, state) => CatchScreen(
        urlAnimation: state.uri.queryParameters['url']!,
      ),
    ),
  ],
);
