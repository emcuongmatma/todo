import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/toast.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/task_manager/task_manager_cubit.dart';
import 'package:todo/presentation/pages/home/task_detail_screen/component/task_info_item.dart';
import 'package:todo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:todo/presentation/widgets/custom_tag_dialog.dart';
import 'package:todo/presentation/widgets/custom_time_picker_dialog.dart';
import 'package:todo/presentation/widgets/delete_task_dialog.dart';
import 'package:todo/presentation/widgets/edit_task_title_dialog.dart';
import 'package:todo/presentation/widgets/task_priority_dialog.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskEntity initialTask;

  const TaskDetailScreen({super.key, required this.initialTask});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskManagerCubit>()..setTempTask(initialTask),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: TaskDetail(initialTask: initialTask)),
      ),
    );
  }
}

class TaskDetail extends StatelessWidget {
  final TaskEntity initialTask;

  const TaskDetail({super.key, required this.initialTask});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerCubit, TaskManagerState>(
      listenWhen: (previous, current) => previous.effect != current.effect,
      listener: (context, state) {
        switch (state.effect) {
          case TaskManagerEffect.none:
            null;
          case TaskManagerEffect.success:
            if (context.canPop()) {
              context.pop();
            }
          case TaskManagerEffect.fail:
            showToast(msg: state.error?.message);
          default:
            null;
        }
        context.read<TaskManagerCubit>().clearEffect();
      },
      buildWhen: (pre, cur) => pre.tmpTask != cur.tmpTask,
      builder: (context, state) {
        final task = state.tmpTask ?? initialTask;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 34,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      if (context.canPop()) context.pop();
                    },
                    child: SvgPicture.asset(Assets.iconsIcClose),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<TaskManagerCubit>().setTempTask(initialTask);
                    },
                    child: SvgPicture.asset(Assets.iconsIcReset),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: state.tmpTask?.isCompleted,
                        shape: const CircleBorder(),
                        side: const BorderSide(
                          color: ColorDark.whiteFocus,
                          width: 1.5,
                        ),
                        onChanged: (val) {
                          context.read<TaskManagerCubit>().updateTmpTask(
                            isCompleted: val,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          task.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: ColorDark.gray),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      context.read<TaskManagerCubit>().preSetValue(
                        newTaskName: task.title,
                        newDescription:
                        task.description,
                      );
                      bool? isChanged = await showEditTaskNameAndDescription(
                        context: context,
                        initialTaskName: task.title,
                        initialTaskDescription:
                        task.description,
                      );
                      if (isChanged == true) {
                        if (!context.mounted) return;
                        context.read<TaskManagerCubit>().updateTmpTask(
                          titleChange: true,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(Assets.iconsIcEdit),
                    ),
                  ),
                ],
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcTimer,
                title: t.task_time,
                info: task.dateTime.toCustomString(),
                onClick: () async {
                  DateTime? selectedDate = await showAppCalendarDialog(
                    context: context,
                    initialDate: task.dateTime,
                    mode: CalendarDialogMode.edit,
                  );
                  debugPrint(selectedDate.toString());
                  if (!context.mounted) return;
                  if (selectedDate == null) return;
                  TimeOfDay? selectedTime = await showCustomTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: (state.selectedDate ?? initialTask.dateTime).hour,
                      minute:
                          (state.selectedDate ?? initialTask.dateTime).minute,
                    ),
                    mode: TimePickerDialogMode.edit,
                  );
                  if (!context.mounted) return;
                  context.read<TaskManagerCubit>().updateTmpTask(
                    newDate: selectedDate.copyWith(
                      hour: selectedTime?.hour,
                      minute: selectedTime?.minute,
                    ),
                  );
                },
              ),

              TaskInfoItem(
                leadingIcon: Assets.iconsIcTag,
                title: t.task_category,
                info:
                    InitialData.categories
                        .firstWhereOrNull(
                          (element) => element.id == task.category.id,
                        )
                        ?.name ??
                        task.category.name,
                icon: task.category.icon,
                onClick: () async {
                  int? categoryId = await showCategoryPicker(
                    context: context,
                    initialCategory: task.category.id,
                    mode: CategoryPickerDialogMode.edit,
                  );
                  if (categoryId == null) return;
                  if (!context.mounted) return;
                  context.read<TaskManagerCubit>().updateTmpTask(
                    newCategoryId: categoryId,
                  );
                },
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcFlag,
                title: t.task_priority,
                info: task.priority == 1
                    ? t.kDefault
                    : task.priority.toString(),
                onClick: () async {
                  int? priority = await showTaskPriorityDialog(
                    context: context,
                    initialPriority: task.priority,
                    mode: TaskPriorityDialogMode.edit,
                  );
                  if (priority == null) return;
                  if (!context.mounted) return;
                  context.read<TaskManagerCubit>().updateTmpTask(
                    newPriority: priority,
                  );
                },
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcSubTask,
                title: t.sub_task,
                info: t.add_sub_task,
                onClick: () {},
              ),
              InkWell(
                onTap: () async {
                  final result = await showDeleteTaskDialog(
                    context,
                    initialTask.title,
                  );
                  if (result != true) return;
                  if (!context.mounted) return;
                  context.read<TaskManagerCubit>().deleteTask();
                  if (context.canPop()) context.pop();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.iconsIcDelete),
                    const SizedBox(width: 8),
                    Text(
                      t.delete_task,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: ColorDark.error),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    debugPrint("${state.tmpTask?.id}");
                    context.read<TaskManagerCubit>().updateTask();
                  },
                  child: Text(
                    t.edit_task,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
