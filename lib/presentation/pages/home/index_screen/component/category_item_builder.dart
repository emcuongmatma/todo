import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/domain/entities/category_entity.dart';

class CategoryItemBuilder extends StatelessWidget {
  final CategoryEntity category;

  const CategoryItemBuilder({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
      decoration: BoxDecoration(
        color: CategoryEntity.hexToColor(
          category.backgroundColor,
        ).withAlpha(240),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(category.icon, width: 14, height: 14),
          const SizedBox(width: 5),
          Text(
            InitialData.categories
                    .firstWhereOrNull((element) => element.id == category.id)
                    ?.name ??
                category.name,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
