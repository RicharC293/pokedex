import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get viewInsetsBottom => MediaQuery.of(this).viewInsets.bottom;
  double get viewInsetsTop => MediaQuery.of(this).viewInsets.top;
  double get viewPaddingBottom => MediaQuery.of(this).viewPadding.bottom;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;
  double get viewPaddingRight => MediaQuery.of(this).viewPadding.right;
  double get viewPaddingLeft => MediaQuery.of(this).viewPadding.left;
  double get viewInsetsRight => MediaQuery.of(this).viewInsets.right;
  double get viewInsetsLeft => MediaQuery.of(this).viewInsets.left;
  double get viewPaddingHorizontal => viewPaddingRight + viewPaddingLeft;
  double get viewPaddingVertical => viewPaddingTop + viewPaddingBottom;
  double get viewInsetsHorizontal => viewInsetsRight + viewInsetsLeft;
  double get viewInsetsVertical => viewInsetsTop + viewInsetsBottom;
  double get viewHorizontal => viewPaddingHorizontal + viewInsetsHorizontal;
  double get viewVertical => viewPaddingVertical + viewInsetsVertical;
  double get viewHeight => height - viewVertical;
  double get viewWidth => width - viewHorizontal;
  double get viewPadding =>
      viewPaddingTop + viewPaddingBottom + viewPaddingRight + viewPaddingLeft;
  double get viewInsets =>
      viewInsetsTop + viewInsetsBottom + viewInsetsRight + viewInsetsLeft;
  double get viewSize => viewPadding + viewInsets;
  double get viewHorizontalPadding => viewPaddingRight + viewPaddingLeft;
  double get viewVerticalPadding => viewPaddingTop + viewPaddingBottom;
  double get viewHorizontalInsets => viewInsetsRight + viewInsetsLeft;
  double get viewVerticalInsets => viewInsetsTop + viewInsetsBottom;
  double get viewHorizontalSize => viewHorizontalPadding + viewHorizontalInsets;
  double get viewVerticalSize => viewVerticalPadding + viewVerticalInsets;
  double get viewHorizontalPaddingSize => viewPaddingRight + viewPaddingLeft;
  double get viewVerticalPaddingSize => viewPaddingTop + viewPaddingBottom;
  double get viewHorizontalInsetsSize => viewInsetsRight + viewInsetsLeft;
}
