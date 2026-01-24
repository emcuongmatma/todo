import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/generated/assets.dart';

class InitialData {
  static List<CategoryEntity> get categories => [
    CategoryEntity(
      name: "Grocery",
      icon: Assets.iconsIcGrocery,
      backgroundColor: "#CCFF80",
    ),
    CategoryEntity(
      name: "Work",
      icon: Assets.iconsIcWork,
      backgroundColor: "#FF9680",
    ),
    CategoryEntity(
      name: "Sport",
      icon: Assets.iconsIcSport,
      backgroundColor: "#80FFFF",
    ),
    CategoryEntity(
      name: "Design",
      icon: Assets.iconsIcDesign,
      backgroundColor: "#80FFD9",
    ),
    CategoryEntity(
      name: "University",
      icon: Assets.iconsIcUniversity,
      backgroundColor: "#809CFF",
    ),
    CategoryEntity(
      name: "Social",
      icon: Assets.iconsIcSocial,
      backgroundColor: "#FF80EB",
    ),
    CategoryEntity(
      name: "Music",
      icon: Assets.iconsIcMusic,
      backgroundColor: "#FC80FF",
    ),
    CategoryEntity(
      name: "Health",
      icon: Assets.iconsIcHealth,
      backgroundColor: "#80FFA3",
    ),
    CategoryEntity(
      name: "Movie",
      icon: Assets.iconsIcMovie,
      backgroundColor: "#80D1FF",
    ),
    CategoryEntity(
      name: "Home",
      icon: Assets.iconsIcHome1,
      backgroundColor: "#FF8080",
    ),
  ];
}