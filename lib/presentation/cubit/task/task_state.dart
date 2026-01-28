part of 'task_cubit.dart';

class TaskState extends Equatable {
  final List<TaskEntity> listTask1;
  final List<TaskEntity> listTask2;
  final String filterKey1;
  final String filterKey2;
  final String? searchKey;

  const TaskState({
    this.listTask1 = const <TaskEntity>[],
    this.listTask2 = const <TaskEntity>[],
    this.filterKey1 = AppKey.ALL,
    this.filterKey2 = AppKey.COMPLETED,
    this.searchKey,
  });

  TaskState copyWith({
    List<TaskEntity>? tasks,
    List<TaskEntity>? listTask1,
    List<TaskEntity>? listTask2,
    String? filterKey1,
    String? filterKey2,
    String? searchKey
  }) {
    return TaskState(
      listTask1: listTask1 ?? this.listTask1,
      listTask2: listTask2 ?? this.listTask2,
      filterKey1: filterKey1 ?? this.filterKey1,
      filterKey2: filterKey2 ?? this.filterKey2,
      searchKey: searchKey ?? this.searchKey
    );
  }

  @override
  List<Object?> get props => [listTask1, listTask2, filterKey1, filterKey2, searchKey];
}
