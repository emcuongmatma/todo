import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/domain/repositories/category_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/models/normal_input.dart';

part 'task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  final TaskRepository taskRepository;
  final CategoryRepository categoryRepository;
  final AuthRepository authRepository;

  TaskManagerCubit({
    required this.taskRepository,
    required this.categoryRepository,
    required this.authRepository,
  }) : super(const TaskManagerState());

  void onTaskNameChange(String taskName) {
    emit(state.copyWith(taskName: taskName));
  }

  void onCheckTaskName() {
    debugPrint(state.taskName);
    final taskNameInput = NormalInput.dirty(state.taskName);
    debugPrint(taskNameInput.isValid.toString());
    emit(
      state.copyWith(
        taskNameInput: taskNameInput,
        showTaskDesTextField: taskNameInput.isValid,
      ),
    );
  }

  void showTaskNameInput() {
    emit(state.copyWith(showTaskDesTextField: false));
  }

  void onTaskDescriptionChange(String taskDes) {
    emit(state.copyWith(taskDes: taskDes));
  }

  void onSelectedDate(DateTime? date) {
    debugPrint("old date ${state.selectedDate}");
    emit(state.copyWith(selectedDate: date));
    debugPrint("new date ${state.selectedDate}");
  }

  void onSelectedTime(TimeOfDay? time) {
    debugPrint("old time ${state.selectedTime}");
    emit(state.copyWith(selectedTime: time));
    debugPrint("new time ${state.selectedTime}");
  }

  void onSelectedPriority(int priority) {
    debugPrint("Setting selected priority $priority");
    emit(state.copyWith(priority: priority));
  }

  void onSelectedCategory(int categoryId) {
    debugPrint("Setting selected category $categoryId");
    emit(state.copyWith(categoryId: categoryId));
  }

  void setTempTask(TaskEntity task) {
    emit(
      state.copyWith(
        taskName: task.title,
        taskDes: task.description,
        selectedDate: task.dateTime,
        categoryId: task.category.id,
        priority: task.priority,
        tmpTask: task,
      ),
    );
  }

  void preSetValue({String? newTaskName, String? newDescription}) {
    emit(state.copyWith(taskName: newTaskName, taskDes: newDescription));
  }

  Future<void> updateTmpTask({
    bool? titleChange,
    String? newTaskName,
    String? newDescription,
    DateTime? newDate,
    int? newCategoryId,
    int? newPriority,
    bool? isCompleted,
  }) async {
    final task = state.tmpTask?.copyWith(
      title: titleChange == true ? state.taskName : null,
      description: titleChange == true ? state.taskDes : null,
      dateTime: newDate,
      category: newCategoryId != null
          ? await categoryRepository.getCategoryById(newCategoryId)
          : null,
      priority: newPriority,
      isCompleted: isCompleted,
    );
    emit(state.copyWith(tmpTask: task));
  }

  bool validateText() {
    final taskNameInput = NormalInput.dirty(state.taskName);
    final taskDesInput = NormalInput.dirty(state.taskDes);
    final isValid = taskDesInput.isValid && taskNameInput.isValid;
    if (isValid) {
      emit(
        state.copyWith(
          taskNameInput: taskNameInput,
          taskDesInput: taskDesInput,
        ),
      );
    }
    return isValid;
  }

  Future<void> updateTask() async {
    final userId = authRepository.getUserId();
    if (userId == null) return;
    final result = await taskRepository.updateTask(state.tmpTask, userId).run();
    result.fold((failure) => emit(state.copyWith(effect: TaskManagerEffect.fail)), (
      task,
    ) {
      emit(state.copyWith(effect: TaskManagerEffect.success));
      taskRepository.updateCloudTask(task).run();
    });
  }

  Future<void> deleteTask() async {
    final taskId = state.tmpTask?.id;
    if (taskId == null) return;
    final result = await taskRepository.deleteTask(taskId).run();
    result.fold((failure) => emit(state.copyWith(effect: TaskManagerEffect.fail)), (
      _,
    ) {
      emit(state.copyWith(effect: TaskManagerEffect.success));
      final serverId = state.tmpTask?.serverId;
      if (serverId == null) return;
      taskRepository.deleteCloudTask(serverId).run();
    });
  }

  Future<void> validate() async {
    final taskNameInput = NormalInput.dirty(state.taskName);
    final taskDesInput = NormalInput.dirty(state.taskDes);
    emit(
      state.copyWith(taskNameInput: taskNameInput, taskDesInput: taskDesInput, showTaskDesTextField: !taskDesInput.isValid),
    );
    if (!taskNameInput.isValid || !taskDesInput.isValid) return;
    final check = switch (true) {
      _ when state.selectedDate == null => TaskManagerEffect.invalidDate,
      _ when state.categoryId == null => TaskManagerEffect.invalidCategory,
      _ => null,
    };
    if (check != null) {
      emit(state.copyWith(effect: check));
      return;
    }
    debugPrint(
      "taskNameInput : ${state.taskNameInput.isValid}, "
      "taskDesInput: ${state.taskDesInput.isValid}, "
      "selectedDate: ${state.selectedDate?.copyWith(hour: state.selectedTime.hour, minute: state.selectedTime.minute)}, "
      "priority :${state.priority}, "
      "category: ${state.categoryId}",
    );
    final category = await categoryRepository.getCategoryById(
      state.categoryId!,
    );
    final newTask = TaskEntity(
      title: state.taskName,
      description: state.taskDes,
      dateTime: state.selectedDate!.copyWith(
        hour: state.selectedTime.hour,
        minute: state.selectedTime.minute,
      ),
      priority: state.priority,
      category: category,
    );
    final userId = authRepository.getUserId();
    if (userId == null) return;
    final result = await taskRepository.addTask(newTask, userId).run();
    result.fold((failure) => emit(state.copyWith(effect: TaskManagerEffect.fail)), (
      tasks,
    ) {
      emit(state.copyWith(effect: TaskManagerEffect.success));
      taskRepository.uploadPendingTasks().run();
    });
  }

  void clearEffect() {
    emit(state.copyWith(effect: TaskManagerEffect.none));
  }
}
