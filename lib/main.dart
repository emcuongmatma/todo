import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo/core/router/app_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/di/injection.dart' as di;
import 'package:todo/presentation/cubit/add_task/add_task_cubit.dart';
import 'core/theme/text_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.locator<AddTaskCubit>())],
      child: MaterialApp.router(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorDark.background,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorDark.primary,
            onSurface: ColorDark.whiteFocus,
          ),
          appBarTheme: const AppBarThemeData(
            backgroundColor: ColorDark.background,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ColorDark.primary,
            shape: CircleBorder(),
          ),
          dialogTheme: const DialogThemeData(
            insetPadding: EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: ColorDark.bottomNavigationBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: ColorDark.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: ColorDark.bottomNavigationBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          textTheme: textTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorDark.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
