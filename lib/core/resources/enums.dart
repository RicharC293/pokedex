import 'dart:ui';

enum ColorStat {
  red(0, Color(0xFFE57373)),
  blue(1, Color(0xFF64B5F6)),
  green(2, Color(0xFF81C784)),
  yellow(3, Color(0xFFFFD54F)),
  purple(4, Color(0xFFBA68C8)),
  orange(5, Color(0xFFFFB74D)),
  none(6, Color(0xFFE0E0E0));

  final int position;
  final Color color;

  const ColorStat(this.position, this.color);
}
