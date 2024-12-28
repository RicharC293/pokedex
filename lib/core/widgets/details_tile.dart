import 'package:flutter/material.dart';
import 'package:pokemon/core/extensions/context_extension.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    super.key,
    required this.title,
    this.value,
    this.customValue,
  }) : assert(value != null || customValue != null,
            "value or customValue must be not null");

  final String title;
  final String? value;
  final Widget? customValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          )),
      trailing: customValue ?? Text(value!, style: context.textTheme.titleSmall),
      minTileHeight: 0,
      minVerticalPadding: 0,
    );
  }
}
