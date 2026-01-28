import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:todo/core/database/isar_service.dart';
import 'package:todo/data/datasources/local/category_local_data_source.dart';
import 'package:todo/data/datasources/local/task_local_data_source.dart';
import 'package:todo/data/repositories/category_repository_impl.dart';
import 'package:todo/data/repositories/task_repository_impl.dart';
import 'package:todo/domain/repositories/category_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:todo/presentation/cubit/category/category_cubit.dart';
import 'package:todo/presentation/cubit/task/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final isar = await IsarService.init();
  //
  sl.registerSingleton<Isar>(isar);

  //datasource

  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSource(isar),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(isar),
  );

  //Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryLocalDataSource>()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskLocal: sl<TaskLocalDataSource>(),
      categoryLocal: sl<CategoryLocalDataSource>(),
    ),
  );

  //Cubit
  sl.registerFactory<AddTaskCubit>(
    () => AddTaskCubit(
      taskRepository: sl<TaskRepository>(),
      categoryRepository: sl<CategoryRepository>(),
    ),
  );
  sl.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(sl<CategoryRepository>()),
  );
  sl.registerFactory<TaskCubit>(() => TaskCubit(sl<TaskRepository>()));
}
