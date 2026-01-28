import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/category_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/models/normal_input.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepository taskRepository;
  final CategoryRepository categoryRepository;

  AddTaskCubit({required this.taskRepository, required this.categoryRepository})
    : super(const AddTaskState());

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
    bool? isCompleted
  }) async {
    final task = state.tmpTask?.copyWith(
      title: titleChange == true ? state.taskName : null,
      description: titleChange == true ? state.taskDes : null,
      dateTime: newDate,
      category: newCategoryId != null
          ? await categoryRepository.getCategoryById(newCategoryId)
          : null,
      priority: newPriority,
      isCompleted: isCompleted
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

  void deleteTask(int id) {
    if (id == -1) return;
    taskRepository.deleteTask(id);
    emit(state.copyWith(effect: AddTaskEffect.success));
  }

  void updateTask() {
    taskRepository.updateTask(state.tmpTask);
    emit(state.copyWith(effect: AddTaskEffect.success));
  }

  Future<void> validate() async {
    final taskNameInput = NormalInput.dirty(state.taskName);
    final taskDesInput = NormalInput.dirty(state.taskDes);
    emit(
      state.copyWith(taskNameInput: taskNameInput, taskDesInput: taskDesInput),
    );
    final check = switch (true) {
      _ when state.selectedDate == null => AddTaskEffect.invalidDate,
      _ when state.categoryId == null => AddTaskEffect.invalidCategory,
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
    taskRepository.addTask(newTask);
    emit(state.copyWith(effect: AddTaskEffect.success));
  }

  void clearEffect() {
    emit(state.copyWith(effect: AddTaskEffect.none));
  }
}
