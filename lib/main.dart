import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/router/app_router.dart';
import 'package:todo/core/di/injection.dart' as di;
import 'package:todo/core/theme/theme.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/presentation/cubit/category/category_cubit.dart';
import 'package:todo/presentation/cubit/task/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = AppRouter.router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<CategoryCubit>()..getAllCategory()),
        BlocProvider(create: (_) => di.sl<TaskCubit>()),
      ],
      child: MaterialApp.router(
        title: AppConstants.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routerConfig: _router,
      ),
    );
  }
}
