import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/toast.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';
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
        create: (context) => locator<AddTaskCubit>(),
        child: const AddTaskBottomSheet(),
      );
    },
  );
}

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        switch (state.effect) {
          case AddTaskEffect.none:
            null;
          case AddTaskEffect.invalidDate:
            showToast(msg: AppConstants.PLEASE_SELECT_DATE);
            context.read<AddTaskCubit>().clearEffect();
          case AddTaskEffect.invalidCategory:
            showToast(msg: AppConstants.PLEASE_SELECT_CATEGORY);
            context.read<AddTaskCubit>().clearEffect();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 17,
              left: 25,
              right: 25,
              top: 25,
            ),
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
                            .read<AddTaskCubit>()
                            .onTaskNameChange(value),
                        hintText: AppConstants.TASK_NAME,
                        errorText: state.taskNameInput.inputStatusText,
                      )
                    : Text(
                        state.taskName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          color: ColorDark.whiteFocus,
                        ),
                      ),
                !state.showTaskDesTextField
                    ? InkWell(
                        onTap: () =>
                            context.read<AddTaskCubit>().onCheckTaskName(),
                        child: Text(
                          AppConstants.DESCRIPTION,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 18,
                                color: ColorDark.whiteFocus,
                              ),
                        ),
                      )
                    : CustomTextField(
                        onChange: (value) => context
                            .read<AddTaskCubit>()
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
                        DateTime? selectedDate = await showAppCalendarDialog(
                          context,
                          state.selectedDate ?? DateTime.now(),
                        );
                        debugPrint(selectedDate.toString());
                        if (!context.mounted) return;
                        if (selectedDate == null) return;
                        TimeOfDay? selectedTime = await showCustomTimePicker(
                          context,
                          TimeOfDay(
                            hour: state.selectedDate?.hour ?? 1,
                            minute: state.selectedDate?.minute ?? 0,
                          ),
                        );
                        if (!context.mounted) return;
                        context.read<AddTaskCubit>().onSelectedDate(
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
                        int? categoryId = await showCategoryPicker(
                          context,
                          state.categoryId ?? 1,
                        );
                        if (categoryId == null) return;
                        if (!context.mounted) return;
                        context.read<AddTaskCubit>().onSelectedCategory(
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
                        debugPrint(state.priority.toString());
                        int? priority = await showTaskPriorityDialog(
                          context,
                          state.priority,
                        );
                        if (!context.mounted) return;
                        if (priority == null) return;
                        context.read<AddTaskCubit>().onSelectedPriority(
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
                      onTap: () => context.read<AddTaskCubit>().validate(),
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
        );
      },
    );
  }
}
