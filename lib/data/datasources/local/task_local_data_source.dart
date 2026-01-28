import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:todo/data/models/task_model.dart';

class TaskLocalDataSource {
  final Isar _isar;

  TaskLocalDataSource(this._isar);

  Stream<List<TaskModel>> watchTasks() {
    return _isar.taskModels.where().sortByDateTime().watch(
      fireImmediately: true,
    );
  }

  Stream<List<TaskModel>> getTaskByFilter({
    String? searchKey,
    DateTime? date,
    bool? isCompleted,
  }) {
    QueryBuilder<TaskModel, TaskModel, QAfterFilterCondition> query = _isar
        .taskModels
        .filter()
        .idGreaterThan(-1);
    if (searchKey != null) {
      debugPrint(searchKey);
      query = query.titleMatches("*$searchKey*", caseSensitive: false);
    }
    if (date != null) {
      final start = DateTime(date.year, date.month, date.day);
      final end = start.add(
        const Duration(hours: 23, minutes: 59, seconds: 59),
      );
      query = query.dateTimeBetween(start, end);
    }
    if (isCompleted != null) {
      query = query.isCompletedEqualTo(isCompleted);
    }
    return query.build().watch(fireImmediately: true);
  }

  Stream<List<TaskModel>> getTaskByStatus(bool? isCompleted) {
    var query = _isar.taskModels.filter().idEqualTo(0);
    if (isCompleted != null) {
      query = query.isCompletedEqualTo(isCompleted);
    }
    return query.build().watch(fireImmediately: true);
  }

  Future<void> saveTask(TaskModel task) async {
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }

  Future<void> deleteTask(int taskId) async {
    await _isar.writeTxn(() => _isar.taskModels.delete(taskId));
  }

  Future<void> updateTask(TaskModel task) async {
    await _isar.writeTxn(() => _isar.taskModels.put(task));
  }
}
