import 'package:todo/core/constants/key.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';

class InitialData {
  static List<CategoryEntity> get categories => [
    CategoryEntity(
      id: 1,
      name: t.categories.grocery,
      icon: Assets.iconsIcGrocery,
      backgroundColor: "#CCFF80",
    ),
    CategoryEntity(
      id: 2,
      name: t.categories.work,
      icon: Assets.iconsIcWork,
      backgroundColor: "#FF9680",
    ),
    CategoryEntity(
      id: 3,
      name: t.categories.sport,
      icon: Assets.iconsIcSport,
      backgroundColor: "#80FFFF",
    ),
    CategoryEntity(
      id: 4,
      name: t.categories.design,
      icon: Assets.iconsIcDesign,
      backgroundColor: "#80FFD9",
    ),
    CategoryEntity(
      id: 5,
      name: t.categories.university,
      icon: Assets.iconsIcUniversity,
      backgroundColor: "#809CFF",
    ),
    CategoryEntity(
      id: 6,
      name: t.categories.social,
      icon: Assets.iconsIcSocial,
      backgroundColor: "#FF80EB",
    ),
    CategoryEntity(
      id: 7,
      name: t.categories.music,
      icon: Assets.iconsIcMusic,
      backgroundColor: "#FC80FF",
    ),
    CategoryEntity(
      id: 8,
      name: t.categories.health,
      icon: Assets.iconsIcHealth,
      backgroundColor: "#80FFA3",
    ),
    CategoryEntity(
      id: 9,
      name: t.categories.movie,
      icon: Assets.iconsIcMovie,
      backgroundColor: "#80D1FF",
    ),
    CategoryEntity(
      id: 10,
      name: t.categories.home,
      icon: Assets.iconsIcHome1,
      backgroundColor: "#FF8080",
    ),
  ];

  static CategoryEntity get createCategoryItem => CategoryEntity(
    id: 0,
    name: t.create_new,
    icon: Assets.iconsIcCreate,
    backgroundColor: "#80FFD1",
  );

  static List<MenuItem> get menuItem1 => [
    MenuItem(AppKey.TODAY, t.today),
    MenuItem(AppKey.ALL, t.all_time),
  ];

  static List<MenuItem> get menuItem2 => [
    MenuItem(AppKey.COMPLETED, t.completed),
    MenuItem(AppKey.IN_COMPLETED, t.in_completed),
  ];
}

class MenuItem {
  final String key;
  final String name;

  MenuItem(this.key, this.name);
}