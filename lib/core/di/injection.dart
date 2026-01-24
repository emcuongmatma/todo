import 'package:get_it/get_it.dart';
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';

final locator = GetIt.instance;
void init() {
  locator.registerLazySingleton<AddTaskCubit>(()=>AddTaskCubit());
}