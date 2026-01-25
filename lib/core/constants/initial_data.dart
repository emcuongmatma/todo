import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/generated/assets.dart';

class InitialData {
  static List<CategoryEntity> get categories =>
      [
        CategoryEntity(
          id: 1,
          name: "Grocery",
          icon: Assets.iconsIcGrocery,
          backgroundColor: "#CCFF80",
        ),
        CategoryEntity(
          id: 2,
          name: "Work",
          icon: Assets.iconsIcWork,
          backgroundColor: "#FF9680",
        ),
        CategoryEntity(
          id: 3,
          name: "Sport",
          icon: Assets.iconsIcSport,
          backgroundColor: "#80FFFF",
        ),
        CategoryEntity(
          id: 4,
          name: "Design",
          icon: Assets.iconsIcDesign,
          backgroundColor: "#80FFD9",
        ),
        CategoryEntity(
          id: 5,
          name: "University",
          icon: Assets.iconsIcUniversity,
          backgroundColor: "#809CFF",
        ),
        CategoryEntity(
          id: 6,
          name: "Social",
          icon: Assets.iconsIcSocial,
          backgroundColor: "#FF80EB",
        ),
        CategoryEntity(
          id: 7,
          name: "Music",
          icon: Assets.iconsIcMusic,
          backgroundColor: "#FC80FF",
        ),
        CategoryEntity(
          id: 8,
          name: "Health",
          icon: Assets.iconsIcHealth,
          backgroundColor: "#80FFA3",
        ),
        CategoryEntity(
          id: 9,
          name: "Movie",
          icon: Assets.iconsIcMovie,
          backgroundColor: "#80D1FF",
        ),
        CategoryEntity(
          id: 10,
          name: "Home",
          icon: Assets.iconsIcHome1,
          backgroundColor: "#FF8080",
        ),
      ];

  static CategoryEntity get createCategoryItem =>
      CategoryEntity(
        id: 0,
        name: AppConstants.CREATE_NEW,
        icon: Assets.iconsIcCreate,
        backgroundColor: "#80FFD1",
      );
}