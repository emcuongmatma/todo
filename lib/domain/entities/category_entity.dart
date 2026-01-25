import 'dart:ui';
class CategoryEntity {
  final int id;
  final String name;
  final String backgroundColor;
  final String icon;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
