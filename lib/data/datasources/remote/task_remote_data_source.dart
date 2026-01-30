import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/core/error/exception.dart';
import 'package:todo/core/error/failure.dart';
import 'package:todo/data/models/task_model.dart';

class TaskRemoteDataSource {
  final Dio _dio;

  TaskRemoteDataSource(this._dio);

  Future<List<TaskModel>> getAllTask(int userId) async {
    try {
      final response = await _dio.get(
        API.TASK,
        queryParameters: {AppKey.USER_ID: userId},
      );
      final List data = response.data;
      return data.map((json) => TaskModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      throw NetworkFailure(e.toString());
    }
  }

  Future<TaskModel> createTask(TaskModel task) async{
    try {
      final response = await _dio.post(
        API.TASK,
        data: task.toJson()
      );
      debugPrint(task.toJson().toString());
      final Map<String, dynamic> data = response.data;
      return TaskModel.fromJson(data);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      debugPrint(e.toString());
      throw NetworkFailure(e.toString());
    }
  }

  Future<TaskModel> updateTask(TaskModel task) async{
    try {
      final response = await _dio.put(
          "${API.TASK}/${task.serverId}",
          data: task.toJson()
      );
      debugPrint(task.toJson().toString());
      final Map<String, dynamic> data = response.data;
      return TaskModel.fromJson(data);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      debugPrint(e.toString());
      throw NetworkFailure(e.toString());
    }
  }

  Future<TaskModel> deleteTask(String taskId) async{
    try {
      final response = await _dio.delete(
          "${API.TASK}/$taskId",
      );
      final Map<String, dynamic> data = response.data;
      return TaskModel.fromJson(data);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      debugPrint(e.toString());
      throw NetworkFailure(e.toString());
    }
  }
}
