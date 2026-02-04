import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/routes.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/presentation/pages/home/index_screen/component/category_item_builder.dart';

import 'priority_item_builder.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskEntity item;

  const TaskItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint(item.dateTime.toString());
        context.pushNamed(AppRouteName.TASK_DETAIL_ROUTE_NAME, extra: item);
      },
      child: Container(
        margin: const EdgeInsetsGeometry.only(top: 16),
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: ColorDark.bottomNavigationBackground,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Checkbox
            Checkbox(
              value: item.isCompleted,
              shape: const CircleBorder(),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              side: const BorderSide(color: ColorDark.whiteFocus, width: 1.5),
              onChanged: (val) {},
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          item.dateTime.toCustomString(),
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: ColorDark.gray, fontSize: 14),
                        ),
                      ),

                      //Category & Priority
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 12,
                          children: [
                            CategoryItemBuilder(category: item.category),
                            PriorityItemBuilder(priority: item.priority),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
