import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/core/constants/routes.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/cubit/task/task_cubit.dart';
import 'package:todo/presentation/pages/home/index_screen/component/category_item_builder.dart';
import 'package:todo/presentation/pages/home/index_screen/component/priority_item_builder.dart';
import 'package:todo/presentation/widgets/custom_text_field.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state.listTask1.isEmpty &&
            state.listTask2.isEmpty &&
            state.searchKey == null) {
          return SizedBox.expand(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Image.asset(
                  Assets.imagesImageHomeBackground,
                  width: 227,
                  height: 227,
                ),
                Text(
                  AppConstants.WHAT_DO_YOU_WANT_TO_DO,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: ColorDark.whiteFocus),
                ),
                Text(
                  AppConstants.TAP_TO_ADD_TASK,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: ColorDark.whiteFocus),
                ),
              ],
            ),
          );
        } else {
          final listTask1 = state.listTask1;
          final listTask2 = state.listTask2;
          Timer? debounce;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 24.0, left: 24.0),
            child: Column(
              children: [
                CustomTextField(
                  onChange: (value) {
                    if (debounce?.isActive ?? false) debounce!.cancel();
                    debounce = Timer(const Duration(milliseconds: 200), () {
                      context.read<TaskCubit>().updateFilter(searchKey: value);
                    });
                  },
                  hintText: AppConstants.SEARCH_FOR_YOUR_TASK,
                  isSearchBar: true,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TaskFilterSection(
                          selectedFilter: InitialData.menuItem1.firstWhere(
                            (item) => item.key == state.filterKey1,
                          ),
                          tasks: listTask1,
                          menu: InitialData.menuItem1,
                          onFilterChange: (value) {
                            context.read<TaskCubit>().updateFilter(
                              filter1: value,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        TaskFilterSection(
                          selectedFilter: InitialData.menuItem2.firstWhere(
                            (item) => item.key == state.filterKey2,
                          ),
                          tasks: listTask2,
                          menu: InitialData.menuItem2,
                          onFilterChange: (value) {
                            context.read<TaskCubit>().updateFilter(
                              filter2: value,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class TaskFilterSection extends StatelessWidget {
  final MenuItem selectedFilter;
  final List<MenuItem> menu;
  final List<TaskEntity> tasks;
  final Function(String) onFilterChange;

  const TaskFilterSection({
    super.key,
    required this.tasks,
    required this.menu,
    required this.onFilterChange,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: PopupMenuButton<String>(
            color: ColorDark.bottomNavigationBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            position: PopupMenuPosition.under,
            menuPadding: EdgeInsetsGeometry.zero,
            offset: const Offset(0, 3),
            itemBuilder: (context) => menu.map((item) {
              return PopupMenuItem(
                value: item.key,
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }).toList(),
            onSelected: onFilterChange,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(54),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedFilter.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: ColorDark.whiteFocus,
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: tasks.mapWithIndex((task, index) {
            final item = tasks[index];
            return InkWell(
              onTap: () {
                debugPrint(item.dateTime.toString());
                context.pushNamed(AppRouteName.TASK_DETAIL_ROUTE_NAME,extra: item);
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
                      side: const BorderSide(
                        color: ColorDark.whiteFocus,
                        width: 1.5,
                      ),
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
                                      ?.copyWith(
                                        color: ColorDark.gray,
                                        fontSize: 14,
                                      ),
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
          }).toList(),
        ),
      ],
    );
  }
}
