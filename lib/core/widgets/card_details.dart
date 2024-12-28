import 'package:flutter/material.dart';

import '../resources/constants.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: text.withValues(alpha: 0.1),
      child: child,
    );
  }
}
