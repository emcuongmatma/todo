import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/task_manager/task_manager_cubit.dart';
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
                  t.task_priority,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: ColorDark.dividerColor,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: TaskInputSection(
                    initialTaskName: initialTaskName,
                    initialTaskDescription: initialTaskDescription,
                  ),
                ),
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
                          t.cancel,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: ColorDark.primary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {
                          if (taskCubit.validateText() && context.canPop()) {
                            context.pop(true);
                          }
                        },
                        child: Text(
                          t.edit,
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
  final FocusNode? taskNameFocus;
  final FocusNode? taskDesFocus;

  const TaskInputSection({
    super.key,
    this.initialTaskName = "",
    this.initialTaskDescription = "",
    this.taskNameFocus,
    this.taskDesFocus,
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
        selection: TextSelection.collapsed(
          offset: widget.initialTaskName.length,
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 17,
      children: [
        !state.showTaskDesTextField
            ? CustomTextField(
                controller: _taskNameController,
                focusNode: widget.taskNameFocus,
                onChange: (value) =>
                    context.read<TaskManagerCubit>().onTaskNameChange(value),
                hintText: t.task_name,
                errorText: state.taskNameInput.inputStatusText,
              )
            : InkWell(
                onTap: () =>
                    context.read<TaskManagerCubit>().showTaskNameInput(),
                child: Text(
                  state.taskName.isNotEmpty
                      ? state.taskName
                      : t.task_title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color: ColorDark.whiteFocus,
                  ),
                ),
              ),
        !state.showTaskDesTextField
            ? InkWell(
                onTap: () =>
                    context.read<TaskManagerCubit>().showTaskDescriptionInput(),
                child: Text(
                  state.taskDes.isNotEmpty
                      ? state.taskDes
                      : t.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color: ColorDark.whiteFocus,
                  ),
                ),
              )
            : CustomTextField(
                controller: _taskDescriptionController,
                focusNode: widget.taskDesFocus,
                onChange: (value) => context
                    .read<TaskManagerCubit>()
                    .onTaskDescriptionChange(value),
                hintText: t.task_description,
                errorText: state.taskDesInput.inputStatusText,
              ),
      ],
    );
  }
}
