import 'package:fpdart/fpdart.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Stream<List<TaskEntity>> getTasks();

  Stream<List<TaskEntity>> getTaskByFilter({
    String? searchKey,
    DateTime? date,
    bool? isCompleted,
  });

  TaskEither<Failure, Unit> syncTasks(int userId);

  TaskEither<Failure, Unit> addTask(TaskEntity task, int userId);

  TaskEither<Failure, Unit> uploadPendingTasks();

  TaskEither<Failure, TaskModel> updateTask(TaskEntity? task, int userId);

  TaskEither<Failure, Unit> updateCloudTask(TaskModel task);

  TaskEither<Failure, Unit> deleteTask(int taskId);

  TaskEither<Failure, Unit> deleteCloudTask(String serverId);
}
