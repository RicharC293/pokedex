import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CatchScreen extends StatefulWidget {
  const CatchScreen({super.key, required this.urlAnimation});

  final String urlAnimation;

  static const routeName = '/catch';

  @override
  State<CatchScreen> createState() => _CatchScreenState();
}

class _CatchScreenState extends State<CatchScreen> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  bool _isCatch = true;

  @override
  void initState() {
    super.initState();
    _catchPokemon();
  }

  Future<void> _catchPokemon() async {
    _isCatch = Random().nextBool();

    /// Use for simulate a time to catch a pokemon
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _crossFadeState = CrossFadeState.showSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedCrossFade(
          firstChild: Image.network(
            widget.urlAnimation,
            fit: BoxFit.contain,
            height: 100,
          ),
          secondChild: Lottie.asset(
            'assets/lottie/catch.json',
            width: 300,
            height: 300,
            onLoaded: (composition) {
              final duration = _isCatch
                  ? composition.duration.inMilliseconds + 250
                  : composition.duration.inMilliseconds - 9000;
              Future.delayed(Duration(milliseconds: duration)).then(
                (value) {
                  if (!context.mounted) return;
                  Navigator.pop(context, _isCatch);
                },
              );
            },
          ),
          crossFadeState: _crossFadeState,
          duration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
