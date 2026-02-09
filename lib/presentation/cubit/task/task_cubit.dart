import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _repository;
  final AuthRepository _authRepository;
  StreamSubscription? _taskSubscriptionFilter1;
  StreamSubscription? _taskSubscriptionFilter2;
  final _searchController = BehaviorSubject<String?>();

  TaskCubit({
    required TaskRepository repository,
    required AuthRepository authRepository,
  }) : _repository = repository,
       _authRepository = authRepository,
       super(const TaskState()) {
    _searchController
        .debounceTime(const Duration(milliseconds: 200))
        .distinct()
        .listen((searchKey) {
          _initList1(searchKey: searchKey, filterKey: state.filterKey1);
          _initList2(searchKey: searchKey, filterKey: state.filterKey2);
        });
    init();
  }

  void init() {
    _initList1(filterKey: state.filterKey1);
    _initList2(filterKey: state.filterKey2);
  }

  void _initList1({String? searchKey, String? filterKey}) {
    _taskSubscriptionFilter1?.cancel();

    final key = filterKey ?? state.filterKey1;
    final date = _mapToDate(key);

    _taskSubscriptionFilter1 = _repository
        .getTaskByFilter(searchKey: searchKey ?? state.searchKey, date: date)
        .listen(
          (tasks) => emit(state.copyWith(listTask1: tasks)),
          onError: (e) => debugPrint(e.toString()),
        );
  }

  void _initList2({String? searchKey, String? filterKey}) {
    _taskSubscriptionFilter2?.cancel();

    final key = filterKey ?? state.filterKey2;
    final isCompleted = _mapToBool(key);

    _taskSubscriptionFilter2 = _repository
        .getTaskByFilter(
          searchKey: searchKey ?? state.searchKey,
          isCompleted: isCompleted,
        )
        .listen(
          (tasks) => emit(state.copyWith(listTask2: tasks)),
          onError: (e) => debugPrint(e.toString()),
        );
  }

  void updateFilter({String? searchKey, String? filter1, String? filter2}) {
    emit(
      state.copyWith(
        searchKey: searchKey,
        filterKey1: filter1,
        filterKey2: filter2,
      ),
    );
    if (searchKey != null) {
      _searchController.add(searchKey);
    }

    if (filter1 != null) _initList1(filterKey: filter1);
    if (filter2 != null) _initList2(filterKey: filter2);
  }

  DateTime? _mapToDate(String key) {
    final now = DateTime.now();
    return switch (key) {
      AppKey.TODAY => now,
      AppKey.YESTERDAY => now.subtract(const Duration(days: 1)),
      AppKey.TOMORROW => now.add(const Duration(days: 1)),
      _ => null,
    };
  }

  bool? _mapToBool(String key) {
    return switch (state.filterKey2) {
      AppKey.COMPLETED => true,
      AppKey.IN_COMPLETED => false,
      _ => null,
    };
  }

  Future<void> syncTasksFromServer() async {
    debugPrint("sync task");
    final user = await _authRepository.getUserData();
    if (user == null) return;
    _repository.syncTasks(int.parse(user.id)).run();
  }

  @override
  Future<void> close() {
    _searchController.close();
    _taskSubscriptionFilter1?.cancel();
    _taskSubscriptionFilter2?.cancel();
    return super.close();
  }
}
