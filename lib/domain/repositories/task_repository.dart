import 'package:todo/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Stream<List<TaskEntity>> getTasks();

  Stream<List<TaskEntity>> getTaskByFilter({String? searchKey,DateTime? date, bool? isCompleted});

  Future<void> addTask(TaskEntity task);

  Future<void> deleteTask(int taskId);

  Future<void> updateTask(TaskEntity? task);
}
