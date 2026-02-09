import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/di/injection.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/toast.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/task_manager/task_manager_cubit.dart';
import 'package:todo/presentation/widgets/custom_calendar_dialog.dart';
import 'package:todo/presentation/widgets/custom_tag_dialog.dart';
import 'package:todo/presentation/widgets/custom_time_picker_dialog.dart';
import 'package:todo/presentation/widgets/edit_task_title_dialog.dart';
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

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late final FocusNode taskNameFocus;
  late final FocusNode taskDesFocus;

  @override
  void initState() {
    super.initState();
    taskNameFocus = FocusNode();
    taskDesFocus = FocusNode();
  }

  @override
  void dispose() {
    taskNameFocus.dispose();
    taskDesFocus.dispose();
    super.dispose();
  }

  Future<void> clearFocus() async {
    if (taskNameFocus.hasFocus || taskDesFocus.hasFocus) {
      taskNameFocus.unfocus();
      taskDesFocus.unfocus();
      await Future.delayed(const Duration(milliseconds: 350));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerCubit, TaskManagerState>(
      listenWhen: (pre, cur) => pre.effect != cur.effect,
      listener: (context, state) {
        switch (state.effect) {
          case TaskManagerEffect.none:
            null;
          case TaskManagerEffect.invalidDate:
            showToast(msg: t.please_select_date);
          case TaskManagerEffect.invalidCategory:
            showToast(msg: t.please_select_category);
          case TaskManagerEffect.invalidDescription:
            showToast(msg: t.please_input_description);
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
                    t.add_task,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorDark.whiteFocus,
                    ),
                  ),
                  TaskInputSection(
                    taskNameFocus: taskNameFocus,
                    taskDesFocus: taskDesFocus,
                  ),
                  // bottom tool
                  Row(
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: () async {
                          await clearFocus();
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
                          await clearFocus();
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
                          await clearFocus();
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
