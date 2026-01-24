import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/data/models/category_model.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/generated/assets.dart';

class CategoryPicker extends StatefulWidget {
  final String? selectedCategory;
  final Function(int) onSelected;

  const CategoryPicker({
    super.key,
    this.selectedCategory,
    required this.onSelected,
  });

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  final List<CategoryEntity> categories = [
    // CategoryModel(
    //   name: "Grocery",
    //   icon: Assets.iconsIcGrocery,
    //   backgroundColor: "#CCFF80",
    // ),
    // CategoryModel(
    //   name: "Work",
    //   icon: Assets.iconsIcWork,
    //   backgroundColor: "#FF9680",
    // ),
    // CategoryModel(
    //   name: "Sport",
    //   icon: Assets.iconsIcSport,
    //   backgroundColor: "#80FFFF",
    // ),
    // CategoryModel(
    //   name: "Design",
    //   icon: Assets.iconsIcDesign,
    //   backgroundColor: "#80FFD9",
    // ),
    // CategoryModel(
    //   name: "University",
    //   icon: Assets.iconsIcUniversity,
    //   backgroundColor: "#809CFF",
    // ),
    // CategoryModel(
    //   name: "Social",
    //   icon: Assets.iconsIcSocial,
    //   backgroundColor: "#FF80EB",
    // ),
    // CategoryModel(
    //   name: "Music",
    //   icon: Assets.iconsIcMusic,
    //   backgroundColor: "#FC80FF",
    // ),
    // CategoryModel(
    //   name: "Health",
    //   icon: Assets.iconsIcHealth,
    //   backgroundColor: "#80FFA3",
    // ),
    // CategoryModel(
    //   name: "Movie",
    //   icon: Assets.iconsIcMovie,
    //   backgroundColor: "#80D1FF",
    // ),
    // CategoryModel(
    //   name: "Home",
    //   icon: Assets.iconsIcHome1,
    //   backgroundColor: "#FF8080",
    // ),
  ];

  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory ?? "Grocery";
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index < categories.length) {
          final item = categories[index];
          return Column(
            spacing: 5,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = item.name;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CategoryEntity.hexToColor(item.backgroundColor),
                    borderRadius: const BorderRadiusGeometry.all(
                      Radius.circular(4),
                    ),
                    border: BoxBorder.all(
                      color: selectedCategory == item.name
                          ? ColorDark.primary
                          : Colors.transparent,
                      width: 4
                    ),
                  ),
                  child: SvgPicture.asset(item.icon),
                ),
              ),
              Text(item.name, style: Theme.of(context).textTheme.titleSmall),
            ],
          );
        } else {}
        return Column(
          spacing: 5,
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: ColorDark.createNewCategoryBackground,
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(4)),
                ),
                child: SvgPicture.asset(Assets.iconsIcCreate),
              ),
            ),
            Text(
              AppConstants.CREATE_NEW,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        );
      },
    );
  }
}

Future<String?> showCategoryPicker(
  BuildContext context,
  String initialCategory,
) async {
  String selectedCategory = initialCategory;
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppConstants.CHOOSE_CATEGORY,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              const Divider(
                color: ColorDark.dividerColor,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 20),
              CategoryPicker(
                selectedCategory: "Grocery",
                onSelected: (index) {},
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (context.canPop()) context.pop();
                      },
                      child: Text(
                        AppConstants.CANCEL,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorDark.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {},
                      child: Text(
                        AppConstants.SAVE,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
