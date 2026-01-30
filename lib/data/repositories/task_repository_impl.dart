import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/datasources/local/category_local_data_source.dart';
import 'package:todo/data/datasources/local/task_local_data_source.dart';
import 'package:todo/data/datasources/remote/task_remote_data_source.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _taskLocal;
  final TaskRemoteDataSource _taskRemoteDataSource;
  final CategoryLocalDataSource _categoryLocal;

  TaskRepositoryImpl({
    required TaskLocalDataSource taskLocal,
    required CategoryLocalDataSource categoryLocal,
    required TaskRemoteDataSource taskRemote,
  }) : _categoryLocal = categoryLocal,
       _taskRemoteDataSource = taskRemote,
       _taskLocal = taskLocal;

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
    yield* _taskLocal
        .getTaskByFilter(
          searchKey: searchKey,
          date: date,
          isCompleted: isCompleted,
        )
        .map((taskModels) {
          return taskModels
              .map((model) => model.toEntity(_cachedCategories))
              .toList();
        });
  }

  @override
  TaskEither<Failure, Unit> syncTasks(int userId) {
    return TaskEither<Failure, List<TaskModel>>.tryCatch(
      () async => await _taskRemoteDataSource.getAllTask(userId),
      (error, _) => NetworkFailure(error.toString()),
    ).flatMap((remoteTasks) {
      debugPrint("sync task");
      debugPrint(remoteTasks.toString());
      return TaskEither.tryCatch(() async {
        await _taskLocal.saveTasksFromServer(remoteTasks);
        return unit;
      }, (error, _) => DatabaseFailure(error.toString()));
    });
  }

  @override
  TaskEither<Failure, Unit> addTask(TaskEntity task, int userId) {
    final model = TaskModel.fromEntity(task, userId);
    debugPrint(model.id.toString());
    return TaskEither<Failure, Unit>.tryCatch(() async {
      await _taskLocal.saveTask(model);
      return unit;
    }, (error, _) => DatabaseFailure(error.toString()));
  }

  @override
  TaskEither<Failure, Unit> uploadPendingTasks() {
    return TaskEither<Failure, List<TaskModel>>.tryCatch(
      () async => await _taskLocal.getUnsyncedTasks(),
      (error, _) => DatabaseFailure(error.toString()),
    ).flatMap((pendingTasks) {
      if (pendingTasks.isEmpty) return TaskEither.right(unit);
      debugPrint(pendingTasks.toString());
      return TaskEither.tryCatch(() async {
        for (var task in pendingTasks) {
          final remoteTask = await _taskRemoteDataSource.createTask(task);
          await _taskLocal.updateSyncStatus(
            localId: task.id,
            serverId: remoteTask.serverId!,
          );
        }
        return unit;
      }, (error, _) => NetworkFailure(error.toString()));
    });
  }

  @override
  TaskEither<Failure, TaskModel> updateTask(TaskEntity? task, int userId) {
    if (task == null) return TaskEither.left(const UnknownFailure());
    final taskModel = TaskModel.fromEntity(task, userId)..isSynced = false;
    return TaskEither<Failure, TaskModel>.tryCatch(
      //update task local
      () async {
        await _taskLocal.saveTask(taskModel);
        updateCloudTask(taskModel).run();
        return taskModel;
      },
      (error, _) => DatabaseFailure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> updateCloudTask(TaskModel task) {
    return TaskEither<Failure, TaskModel>.tryCatch(
      //update task remote
      () async => await _taskRemoteDataSource.updateTask(task),
      (error, _) => DatabaseFailure(error.toString()),
    ).flatMap((taskResult) {
      return TaskEither.tryCatch(() async {
        final serverId = taskResult.serverId;
        if (serverId != null) {
          //update task status
          await _taskLocal.updateSyncStatus(
            localId: taskResult.id,
            serverId: serverId,
          );
        }
        return unit;
      }, (error, _) => NetworkFailure(error.toString()));
    });
  }

  @override
  TaskEither<Failure, void> deleteTask(int taskId) {
    debugPrint("updateCloudStart");
    return TaskEither<Failure, void>.tryCatch(
      () async => await _taskLocal.deleteTask(taskId),
      (error, _) => DatabaseFailure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, Unit> deleteCloudTask(String serverId) {
    return TaskEither.tryCatch(() async {
      await _taskRemoteDataSource.deleteTask(serverId);
      debugPrint("updateLocalStatus");
      return unit;
    }, (error, _) => NetworkFailure(error.toString()));
  }
}
