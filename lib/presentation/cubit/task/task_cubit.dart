import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _repository;
  StreamSubscription? _taskSubscriptionFilter1;
  StreamSubscription? _taskSubscriptionFilter2;

  TaskCubit(this._repository) : super(const TaskState());

  void init() {
    final filter1 = _mapToDate(state.filterKey1);
    final filter2 = _mapToBool(state.filterKey2);
    _taskSubscriptionFilter1 =
        _repository.getTaskByFilter(date: filter1).listen(
              (tasks) {
            if (tasks.isEmpty) {
              emit(state.copyWith(listTask1: []));
            } else {
              emit(state.copyWith(listTask1: tasks));
            }
          },
          onError: (error) {
            // emit(TaskState(message: error.toString()));
          },
        );
    _taskSubscriptionFilter2 =
        _repository.getTaskByFilter(isCompleted: filter2).listen(
              (tasks) {
            if (tasks.isEmpty) {
              emit(state.copyWith(listTask2: []));
            } else {
              emit(state.copyWith(listTask2: tasks));
            }
          },
          onError: (error) {
            // emit(TaskState(message: error.toString()));
          },
        );
  }

  void reloadList1(){
    _taskSubscriptionFilter1?.cancel();
    final filter1 = _mapToDate(state.filterKey1);
    _taskSubscriptionFilter1 =
        _repository.getTaskByFilter(searchKey: state.searchKey ,date: filter1).listen(
              (tasks) {
            if (tasks.isEmpty) {
              emit(state.copyWith(listTask1: []));
            } else {
              emit(state.copyWith(listTask1: tasks));
            }
          },
          onError: (error) {
            // emit(TaskState(message: error.toString()));
          },
        );
  }

  void reloadList2(){
    _taskSubscriptionFilter2?.cancel();
    final filter2 = _mapToBool(state.filterKey2);
    _taskSubscriptionFilter2 =
        _repository.getTaskByFilter(searchKey: state.searchKey ,isCompleted: filter2).listen(
              (tasks) {
            if (tasks.isEmpty) {
              emit(state.copyWith(listTask2: []));
            } else {
              emit(state.copyWith(listTask2: tasks));
            }
          },
          onError: (error) {
            // emit(TaskState(message: error.toString()));
          },
        );
  }

  void updateFilter({String? searchKey,String? filter1, String? filter2}) {
    emit(state.copyWith(searchKey: searchKey,filterKey1: filter1,filterKey2: filter2));
    if (searchKey != null) {
      debugPrint("reaload");
      reloadList1();
      reloadList2();
      return;
    }
    if (filter1 != null) reloadList1();
    if (filter2 != null) reloadList2();
  }

  DateTime? _mapToDate(String key){
    final now = DateTime.now();
    return switch(key) {
      AppKey.TODAY => now,
      AppKey.YESTERDAY => now.subtract(const Duration(days: 1)),
      AppKey.TOMORROW => now.add(const Duration(days: 1)),
      _ => null
    };
  }

  bool? _mapToBool(String key) {
    return switch(state.filterKey2) {
      AppKey.COMPLETED => true,
      AppKey.IN_COMPLETED => false,
      _ => null
    };
  }

  @override
  Future<void> close() {
    _taskSubscriptionFilter1?.cancel();
    _taskSubscriptionFilter2?.cancel();
    return super.close();
  }
}
