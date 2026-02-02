import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/toast.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/cubit/task_manager/task_manager_cubit.dart';
import 'package:todo/presentation/models/normal_input.dart';
import 'package:todo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:todo/presentation/widgets/custom_tag_dialog.dart';
import 'package:todo/presentation/widgets/custom_text_field.dart';
import 'package:todo/presentation/widgets/custom_time_picker_dialog.dart';
import 'package:todo/presentation/widgets/task_priority_dialog.dart';

void showAddTaskSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return BlocProvider(
        create: (context) => sl<TaskManagerCubit>(),
        child: const AddTaskBottomSheet(),
      );
    },
  );
}

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerCubit, TaskManagerState>(
      listenWhen: (pre, cur) => pre.effect != cur.effect,
      listener: (context, state) {
        switch (state.effect) {
          case TaskManagerEffect.none:
            null;
          case TaskManagerEffect.invalidDate:
            showToast(msg: AppConstants.PLEASE_SELECT_DATE);
          case TaskManagerEffect.invalidCategory:
            showToast(msg: AppConstants.PLEASE_SELECT_CATEGORY);
          case TaskManagerEffect.invalidDescription:
            showToast(msg: AppConstants.PLEASE_INPUT_DESCRIPTION);
          case TaskManagerEffect.success:
            if (context.canPop()) {
              context.pop();
            }
          case TaskManagerEffect.fail:
            null;
        }
        context.read<TaskManagerCubit>().clearEffect();
      },
      buildWhen: (pre, cur) =>
          pre.taskDesInput != cur.taskDesInput ||
          pre.taskNameInput != cur.taskNameInput ||
          pre.showTaskDesTextField != cur.showTaskDesTextField,
      builder: (context, state) {
        return SafeArea(
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 17,
              left: 25,
              right: 25,
              top: 25,
            ),
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeOut,
            child: SingleChildScrollView(
              child: Column(
                spacing: 14,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.ADD_TASK,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorDark.whiteFocus,
                    ),
                  ),
                  !state.showTaskDesTextField
                      ? CustomTextField(
                          onChange: (value) => context
                              .read<TaskManagerCubit>()
                              .onTaskNameChange(value),
                          hintText: AppConstants.TASK_NAME,
                          errorText: state.taskNameInput.inputStatusText,
                        )
                      : InkWell(
                          onTap: () => context
                              .read<TaskManagerCubit>()
                              .showTaskNameInput(),
                          child: Text(
                            state.taskName,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 18,
                                  color: ColorDark.whiteFocus,
                                ),
                          ),
                        ),
                  !state.showTaskDesTextField
                      ? InkWell(
                          onTap: () => context
                              .read<TaskManagerCubit>()
                              .onCheckTaskName(),
                          child: Text(
                            state.taskDes.isEmpty
                                ? AppConstants.DESCRIPTION
                                : state.taskDes,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 18,
                                  color: ColorDark.whiteFocus,
                                ),
                          ),
                        )
                      : CustomTextField(
                          onChange: (value) => context
                              .read<TaskManagerCubit>()
                              .onTaskDescriptionChange(value),
                          hintText: AppConstants.TASK_DESCRIPTION,
                          errorText: state.taskDesInput.inputStatusText,
                        ),
                  // bottom tool
                  Row(
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 200),
                          );
                          if (!context.mounted) return;
                          DateTime? selectedDate = await showAppCalendarDialog(
                            context: context,
                            initialDate: state.selectedDate ?? DateTime.now(),
                          );
                          debugPrint(selectedDate.toString());
                          if (!context.mounted) return;
                          if (selectedDate == null) return;
                          TimeOfDay? selectedTime = await showCustomTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: state.selectedDate?.hour ?? 1,
                              minute: state.selectedDate?.minute ?? 0,
                            ),
                          );
                          if (!context.mounted) return;
                          context.read<TaskManagerCubit>().onSelectedDate(
                            selectedDate.copyWith(
                              hour: selectedTime?.hour,
                              minute: selectedTime?.minute,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(Assets.iconsIcTimer),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 200),
                          );
                          if (!context.mounted) return;
                          int? categoryId = await showCategoryPicker(
                            context: context,
                            initialCategory: state.categoryId ?? 1,
                          );
                          if (categoryId == null) return;
                          if (!context.mounted) return;
                          context.read<TaskManagerCubit>().onSelectedCategory(
                            categoryId,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(Assets.iconsIcTag),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await Future.delayed(
                            const Duration(milliseconds: 200),
                          );
                          if (!context.mounted) return;
                          debugPrint(state.priority.toString());
                          int? priority = await showTaskPriorityDialog(
                            context: context,
                            initialPriority: state.priority,
                          );
                          if (!context.mounted) return;
                          if (priority == null) return;
                          context.read<TaskManagerCubit>().onSelectedPriority(
                            priority,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(Assets.iconsIcFlag),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () =>
                            context.read<TaskManagerCubit>().validate(),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(Assets.iconsIcSend),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
