import 'package:fpdart/fpdart.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Stream<List<TaskEntity>> getTasks();

  Stream<List<TaskEntity>> getTaskByFilter({String? searchKey,DateTime? date, bool? isCompleted});

  Future<void> addTask(TaskEntity task,int userId);

  // Future<void> deleteTask(int taskId);

  TaskEither<Failure, Unit> updateTask(TaskEntity? task, int userId);

  TaskEither<Failure, Unit> syncTasks(int userId);

  TaskEither<Failure, Unit> uploadPendingTasks();

  TaskEither<Failure, Unit> updateCloudTask(TaskModel task);

  TaskEither<Failure, Unit> deleteTask(TaskEntity task);
}
