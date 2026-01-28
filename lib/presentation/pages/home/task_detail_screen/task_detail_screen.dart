import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:todo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:todo/presentation/widgets/custom_tag_dialog.dart';
import 'package:todo/presentation/widgets/custom_time_picker_dialog.dart';
import 'package:todo/presentation/widgets/edit_task_title_dialog.dart';
import 'package:todo/presentation/widgets/task_priority_dialog.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskEntity initialTask;

  const TaskDetailScreen({super.key, required this.initialTask});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddTaskCubit>()..setTempTask(initialTask),
      child: Scaffold(
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
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listenWhen: (previous, current) => previous.effect != current.effect,
      listener: (context, state) {
        // switch (state.effect) {
        //   case AddTaskEffect.none:
        //     null;
        //   case AddTaskEffect.invalidDate:
        //     showToast(msg: AppConstants.PLEASE_SELECT_DATE);
        //     context.read<AddTaskCubit>().clearEffect();
        //   case AddTaskEffect.invalidCategory:
        //     showToast(msg: AppConstants.PLEASE_SELECT_CATEGORY);
        //     context.read<AddTaskCubit>().clearEffect();
        //   case AddTaskEffect.success:
        //     if(context.canPop()) {
        //       context.pop();
        //     }
        // }
      },
      builder: (context, state) {
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
                      context.read<AddTaskCubit>().setTempTask(initialTask);
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
                        onChanged: (val) {
                          context.read<AddTaskCubit>().updateTmpTask(isCompleted: val);
                        },
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text(
                        (state.tmpTask ?? initialTask).title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        (state.tmpTask ?? initialTask).description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: ColorDark.gray),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      context.read<AddTaskCubit>().preSetValue(
                        newTaskName: (state.tmpTask ?? initialTask).title,
                        newDescription:
                            (state.tmpTask ?? initialTask).description,
                      );
                      bool? isChanged = await showEditTaskNameAndDescription(
                        context: context,
                        initialTaskName: (state.tmpTask ?? initialTask).title,
                        initialTaskDescription:
                            (state.tmpTask ?? initialTask).description,
                      );
                      if (isChanged == true) {
                        if (!context.mounted) return;
                        context.read<AddTaskCubit>().updateTmpTask(
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
                title: AppConstants.TASK_TIME,
                info: (state.tmpTask ?? initialTask).dateTime.toCustomString(),
                onClick: () async {
                  DateTime? selectedDate = await showAppCalendarDialog(
                    context,
                    (state.tmpTask ?? initialTask).dateTime,
                  );
                  debugPrint(selectedDate.toString());
                  if (!context.mounted) return;
                  if (selectedDate == null) return;
                  TimeOfDay? selectedTime = await showCustomTimePicker(
                    context,
                    TimeOfDay(
                      hour: (state.selectedDate ?? initialTask.dateTime).hour,
                      minute:
                          (state.selectedDate ?? initialTask.dateTime).minute,
                    ),
                  );
                  if (!context.mounted) return;
                  context.read<AddTaskCubit>().updateTmpTask(
                    newDate: selectedDate.copyWith(
                      hour: selectedTime?.hour,
                      minute: selectedTime?.minute,
                    ),
                  );
                },
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcTag,
                title: AppConstants.TASK_CATEGORY,
                info: (state.tmpTask ?? initialTask).category.name,
                icon: (state.tmpTask ?? initialTask).category.icon,
                onClick: () async {
                  int? categoryId = await showCategoryPicker(
                    context,
                    (state.tmpTask ?? initialTask).category.id,
                  );
                  if (categoryId == null) return;
                  if (!context.mounted) return;
                  context.read<AddTaskCubit>().updateTmpTask(
                    newCategoryId: categoryId,
                  );
                },
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcFlag,
                title: AppConstants.TASK_PRIORITY,
                info: (state.tmpTask ?? initialTask).priority == 1
                    ? AppConstants.DEFAULT
                    : (state.tmpTask ?? initialTask).priority.toString(),
                onClick: () async {
                  int? priority = await showTaskPriorityDialog(
                    context,
                    (state.tmpTask ?? initialTask).priority,
                  );
                  if (priority == null) return;
                  if (!context.mounted) return;
                  context.read<AddTaskCubit>().updateTmpTask(
                    newPriority: priority,
                  );
                },
              ),
              TaskInfoItem(
                leadingIcon: Assets.iconsIcSubTask,
                title: AppConstants.SUB_TASK,
                info: AppConstants.ADD_SUB_TASK,
                onClick: () {},
              ),
              InkWell(
                onTap: () {
                  context.read<AddTaskCubit>().deleteTask(initialTask.id ?? -1);
                  if (context.canPop()) context.pop();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.iconsIcDelete),
                    const SizedBox(width: 8),
                    Text(
                      AppConstants.DELETE_TASK,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: ColorDark.error),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    debugPrint("${state.tmpTask?.id}");
                    context.read<AddTaskCubit>().updateTask();
                    if(context.canPop()) context.pop();
                  },
                  child: Text(
                    AppConstants.EDIT_TASK,
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

class TaskInfoItem extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String info;
  final String? icon;
  final VoidCallback onClick;

  const TaskInfoItem({
    super.key,
    required this.info,
    this.icon,
    required this.title,
    required this.leadingIcon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(leadingIcon),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              spacing: 10,
              children: [
                if (icon != null)
                  SvgPicture.asset(icon!, width: 24, height: 24),
                Text(info, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
