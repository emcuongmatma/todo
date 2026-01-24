import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/models/normal_input.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(const AddTaskState());

  void clearState() {
    emit(const AddTaskState());
  }

  void onTaskNameChange(String taskName) {
    emit(state.copyWith(taskName: taskName));
  }

  void onTaskDescriptionChange(String taskDes) {
    emit(state.copyWith(taskDes: taskDes));
  }

  void onSelectedDate(DateTime? date) {
    debugPrint("old date ${state.selectedDate}");
    emit(
      state.copyWith(
        selectedDate: date,
      ),
    );
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

  void validate() {
    final taskNameInput = NormalInput.dirty(state.taskName);
    final taskDesInput = NormalInput.dirty(state.taskDes);
    emit(state.copyWith(taskNameInput: taskNameInput,taskDesInput: taskDesInput));
    debugPrint(
      "taskNameInput : ${state.taskNameInput.isValid}, "
      "taskDesInput: ${state.taskDesInput.isValid}, "
      "selectedDate: ${state.selectedDate?.copyWith(hour: state.selectedTime.hour, minute: state.selectedTime.minute)}, "
      "priority :${state.priority}"
    );
  }
}
