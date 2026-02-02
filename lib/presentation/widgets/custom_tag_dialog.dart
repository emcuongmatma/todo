import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/presentation/cubit/category/category_cubit.dart';

class CategoryPicker extends StatefulWidget {
  final int selectedCategory;
  final Function(int) onSelected;

  const CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  late int selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select(
      (CategoryCubit cubit) => cubit.state.categories,
    );
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index < categories.length) {
          final item = categories[index];
          return CategoryItem(
            item: item,
            isSelected: selectedCategory == item.id,
            onClick: () {
              setState(() {
                selectedCategory = item.id;
              });
              widget.onSelected(item.id);
            },
          );
        } else {
          return CategoryItem(
            item: InitialData.createCategoryItem,
            isSelected: false,
            onClick: () {},
          );
        }
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryEntity item;
  final bool isSelected;
  final VoidCallback onClick;

  const CategoryItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CategoryEntity.hexToColor(item.backgroundColor),
              borderRadius: const BorderRadiusGeometry.all(Radius.circular(4)),
              border: BoxBorder.all(
                color: isSelected ? ColorDark.primary : Colors.transparent,
                width: 4,
              ),
            ),
            child: SvgPicture.asset(item.icon),
          ),
        ),
        Text(item.name, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}

enum CategoryPickerDialogMode { create, edit }

Future<int?> showCategoryPicker({
  required BuildContext context,
  required int initialCategory,
  CategoryPickerDialogMode mode = CategoryPickerDialogMode.create,
}) async {
  int selectedCategory = initialCategory;
  return showDialog<int>(
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
                selectedCategory: selectedCategory,
                onSelected: (categoryId) {
                  selectedCategory = categoryId;
                  debugPrint("$selectedCategory");
                },
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
                      onPressed: () {
                        if (context.canPop()) context.pop(selectedCategory);
                      },
                      child: Text(
                        mode == CategoryPickerDialogMode.create
                            ? AppConstants.CHOOSE_CATEGORY
                            : AppConstants.EDIT,
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
