import 'package:flutter/cupertino.dart';
import 'package:todo/data/datasources/local/category_local_data_source.dart';
import 'package:todo/data/datasources/local/task_local_data_source.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _taskLocal;
  final CategoryLocalDataSource _categoryLocal;

  TaskRepositoryImpl({required TaskLocalDataSource taskLocal, required CategoryLocalDataSource categoryLocal}) : _categoryLocal = categoryLocal, _taskLocal = taskLocal;

  List<CategoryEntity> _cachedCategories = [];

  @override
  Stream<List<TaskEntity>> getTasks() async* {
    if (_cachedCategories.isEmpty) {
      _cachedCategories = (await _categoryLocal.getCategories())
          .map((m) => m.toEntity())
          .toList();
    }
    yield* _taskLocal.watchTasks().map((taskModels) {
      return taskModels
          .map((model) => model.toEntity(_cachedCategories))
          .toList();
    });
  }

  @override
  Stream<List<TaskEntity>> getTaskByFilter({
    String? searchKey,
    DateTime? date,
    bool? isCompleted,
  }) async* {
    if (_cachedCategories.isEmpty) {
      _cachedCategories = (await _categoryLocal.getCategories())
          .map((m) => m.toEntity())
          .toList();
    }
    debugPrint("filter1 $date filter2 $isCompleted");
    yield* _taskLocal.getTaskByFilter(searchKey: searchKey,date: date, isCompleted: isCompleted).map((
      taskModels,
    ) {
      return taskModels
          .map((model) => model.toEntity(_cachedCategories))
          .toList();
    });
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final model = TaskModel.fromEntity(task);
    await _taskLocal.saveTask(model);
  }

  @override
  Future<void> deleteTask(int taskId) async {
    await _taskLocal.deleteTask(taskId);
  }

  @override
  Future<void> updateTask(TaskEntity? task) async {
    if (task == null) return;
    debugPrint("before convert:  ${task.id.toString()}");
    final taskModel = TaskModel.fromEntity(task);
    debugPrint("after convert:  ${taskModel.id.toString()}");
    await _taskLocal.updateTask(taskModel);
  }
}
