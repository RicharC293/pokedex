import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/futures/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

import '../pokemon/presentation/pokemon_list/notifier/pokemon_list_notifier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadingTime();
  }

  Future<void> _loadingTime() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonListNotifier>().fetchAllPokemon();
    });
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;
    context.go(PokemonListScreen.routeName, extra: {"loading": true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/loading.json'),
      ),
    );
  }
}
