part of 'add_task_cubit.dart';

class AddTaskState extends Equatable {
  final String taskName;
  final String taskDes;
  final bool showTaskDesTextField;
  final NormalInput taskNameInput;
  final NormalInput taskDesInput;
  final DateTime? selectedDate;
  final TimeOfDay selectedTime;
  final int priority;

  const AddTaskState({
    this.taskName = '',
    this.taskDes = '',
    this.showTaskDesTextField = false,
    this.taskNameInput = const NormalInput.pure(),
    this.taskDesInput = const NormalInput.pure(),
    this.selectedDate,
    this.priority = 1,
    this.selectedTime = const TimeOfDay(hour: 1, minute: 0),
  });

  AddTaskState copyWith({
    String? taskName,
    String? taskDes,
    bool? showTaskDesTextField,
    NormalInput? taskNameInput,
    NormalInput? taskDesInput,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? priority,
  }) {
    return AddTaskState(
      taskName: taskName ?? this.taskName,
      taskDes: taskDes ?? this.taskDes,
      showTaskDesTextField: showTaskDesTextField ?? this.showTaskDesTextField,
      taskNameInput: taskNameInput ?? this.taskNameInput,
      taskDesInput: taskDesInput ?? this.taskNameInput,
      selectedDate: selectedDate ?? this.selectedDate,
      priority: priority ?? this.priority,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props => [
    showTaskDesTextField,
    taskName,
    taskNameInput,
    taskDesInput,
    taskDes,
    priority,
    selectedDate,
    selectedTime
  ];
}
