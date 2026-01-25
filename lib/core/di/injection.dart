import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:todo/core/database/isar_service.dart';
import 'package:todo/data/repositories/category_repository_impl.dart';
import 'package:todo/domain/repositories/category_repository.dart';
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:todo/presentation/cubit/category/category_cubit.dart';

final locator = GetIt.instance;
Future<void> init() async {
  final isar = await IsarService.init();
  //
  locator.registerSingleton<Isar>(isar);

  //Repository
  locator.registerLazySingleton<CategoryRepository>(()=>CategoryRepositoryImpl(locator()));


  //Cubit
  locator.registerFactory<AddTaskCubit>(()=>AddTaskCubit());
  locator.registerLazySingleton<CategoryCubit>(()=>CategoryCubit(locator()));
}