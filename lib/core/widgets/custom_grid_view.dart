import 'package:flutter/material.dart';
import 'package:pokemon/core/resources/constants.dart';

/// GridView with dynamic height
///
/// Usage is almost same as [GridView.count]
class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.separatorHeight,
  });
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment rowCrossAxisAlignment;

  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final double? separatorHeight;

  int columnLength() {
    if (itemCount % crossAxisCount == 0) {
      return itemCount ~/ crossAxisCount;
    } else {
      return (itemCount ~/ crossAxisCount) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      separatorBuilder: (ctx, index) =>
          SizedBox(height: separatorHeight ?? space0),
      itemBuilder: (ctx, columnIndex) {
        return _GridRow(
          columnIndex: columnIndex,
          builder: builder,
          itemCount: itemCount,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisAlignment: rowCrossAxisAlignment,
        );
      },
      itemCount: columnLength(),
    );
  }
}

/// Use this for [CustomScrollView]
class SliverCustomGridView extends StatelessWidget {
  const SliverCustomGridView({
    Key? key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final ScrollController? controller;

  int columnLength() {
    if (itemCount % crossAxisCount == 0) {
      return itemCount ~/ crossAxisCount;
    } else {
      return (itemCount ~/ crossAxisCount) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, columnIndex) {
          return _GridRow(
            columnIndex: columnIndex,
            builder: builder,
            itemCount: itemCount,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisAlignment: rowCrossAxisAlignment,
          );
        },
        childCount: columnLength(),
      ),
    );
  }
}

class _GridRow extends StatelessWidget {
  const _GridRow({
    Key? key,
    required this.columnIndex,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisAlignment,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment crossAxisAlignment;
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(
        (crossAxisCount * 2) - 1,
        (rowIndex) {
          final rowNum = rowIndex + 1;
          if (rowNum % 2 == 0) {
            return SizedBox(width: crossAxisSpacing);
          }
          final rowItemIndex = ((rowNum + 1) ~/ 2) - 1;
          final itemIndex = (columnIndex * crossAxisCount) + rowItemIndex;
          if (itemIndex > itemCount - 1) {
            return const Expanded(child: SizedBox());
          }
          return Expanded(
            child: builder(context, itemIndex),
          );
        },
      ),
    );
  }
}
