import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/presentation/cubit/add_task/task_manager_cubit.dart';
import 'package:todo/presentation/models/normal_input.dart';
import 'package:todo/presentation/widgets/custom_text_field.dart';

Future<bool?> showEditTaskNameAndDescription({
  required BuildContext context,
  required String initialTaskName,
  required String initialTaskDescription,
}) {
  final taskCubit = context.read<TaskManagerCubit>();
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider.value(
        value: taskCubit,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppConstants.TASK_PRIORITY,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: ColorDark.dividerColor,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 22),
                TaskInputSection(initialTaskName: initialTaskName,initialTaskDescription: initialTaskDescription,),
                const SizedBox(height: 18),
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
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: ColorDark.primary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          if (taskCubit.validateText() &&
                              context.canPop()) {
                            context.pop(true);
                          }
                        },
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
        ),
      );
    },
  );
}

class TaskInputSection extends StatefulWidget {
  final String initialTaskName;
  final String initialTaskDescription;

  const TaskInputSection({
    super.key,
    required this.initialTaskName,
    required this.initialTaskDescription,
  });

  @override
  State<TaskInputSection> createState() => _TaskInputSectionState();
}

class _TaskInputSectionState extends State<TaskInputSection> {
  late final TextEditingController _taskNameController;
  late final TextEditingController _taskDescriptionController;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController()
      ..value = TextEditingValue(
        text: widget.initialTaskName,
        selection: TextSelection.collapsed(offset: widget.initialTaskName.length),
      );
    _taskDescriptionController = TextEditingController()
      ..value = TextEditingValue(
        text: widget.initialTaskDescription,
        selection: TextSelection.collapsed(
          offset: widget.initialTaskDescription.length,
        ),
      );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TaskManagerCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 17,
        children: [
          !state.showTaskDesTextField
              ? CustomTextField(
                  controller: _taskNameController,
                  onChange: (value) =>
                      context.read<TaskManagerCubit>().onTaskNameChange(value),
                  hintText: AppConstants.TASK_NAME,
                  errorText: state.taskNameInput.inputStatusText,
                )
              : InkWell(
                  onTap: () => context.read<TaskManagerCubit>().showTaskNameInput(),
                  child: Text(
                    state.taskName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: ColorDark.whiteFocus,
                    ),
                  ),
                ),
          !state.showTaskDesTextField
              ? InkWell(
                  onTap: () => context.read<TaskManagerCubit>().onCheckTaskName(),
                  child: Text(
                    state.taskDes,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: ColorDark.whiteFocus,
                    ),
                  ),
                )
              : CustomTextField(
                  controller: _taskDescriptionController,
                  onChange: (value) => context
                      .read<TaskManagerCubit>()
                      .onTaskDescriptionChange(value),
                  hintText: AppConstants.TASK_DESCRIPTION,
                  errorText: state.taskDesInput.inputStatusText,
                ),
        ],
      ),
    );
  }
}
