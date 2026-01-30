import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/database/isar_service.dart';
import 'package:todo/core/network/dio_client.dart';
import 'package:todo/data/datasources/local/auth_local_data_source.dart';
import 'package:todo/data/datasources/local/category_local_data_source.dart';
import 'package:todo/data/datasources/local/task_local_data_source.dart';
import 'package:todo/data/datasources/remote/auth_remote_data_source.dart';
import 'package:todo/data/datasources/remote/task_remote_data_source.dart';
import 'package:todo/data/repositories/auth_repository_impl.dart';
import 'package:todo/data/repositories/category_repository_impl.dart';
import 'package:todo/data/repositories/task_repository_impl.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/domain/repositories/category_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/cubit/add_task/task_manager_cubit.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/presentation/cubit/category/category_cubit.dart';
import 'package:todo/presentation/cubit/task/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final isar = await IsarService.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  sl.registerSingleton<Isar>(isar);
  //Dio
  sl.registerLazySingleton<Dio>(
    () => DioClient.create(sl<AuthLocalDataSource>()),
  );
  //datasource
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(prefs),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSource(isar),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSource(sl<Dio>()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(isar),
  );

  //Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryLocalDataSource>()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskLocal: sl<TaskLocalDataSource>(),
      categoryLocal: sl<CategoryLocalDataSource>(),
      taskRemote: sl<TaskRemoteDataSource>(),
    ),
  );

  //Cubit
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory<TaskManagerCubit>(
    () => TaskManagerCubit(
      authRepository: sl<AuthRepository>(),
      taskRepository: sl<TaskRepository>(),
      categoryRepository: sl<CategoryRepository>(),
    ),
  );
  sl.registerLazySingleton<CategoryCubit>(
    () => CategoryCubit(sl<CategoryRepository>()),
  );
  sl.registerFactory<TaskCubit>(
    () => TaskCubit(
      repository: sl<TaskRepository>(),
      authRepository: sl<AuthRepository>(),
    ),
  );
}
