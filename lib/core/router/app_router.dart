import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/routes.dart';
import 'package:todo/domain/entities/task_entity.dart';
import 'package:todo/presentation/pages/home/calendar_screen.dart';
import 'package:todo/presentation/pages/home/focuse_screen.dart';
import 'package:todo/presentation/pages/home/index_screen/index_screen.dart';
import 'package:todo/presentation/pages/home/profile_screen.dart';
import 'package:todo/presentation/pages/home/task_detail_screen/task_detail_screen.dart';
import 'package:todo/presentation/pages/main_wrapper.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePath.HOME_ROUTE_PATH,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.HOME_ROUTE_NAME,
                path: AppRoutePath.HOME_ROUTE_PATH,
                builder: (context, state) => const IndexScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.CALENDAR_ROUTE_NAME,
                path: AppRoutePath.CALENDAR_ROUTE_PATH,
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.FOCUSE_ROUTE_NAME,
                path: AppRoutePath.FOCUSE_ROUTE_PATH,
                builder: (context, state) => const FocuseScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteName.PROFILE_ROUTE_NAME,
                path: AppRoutePath.PROFILE_ROUTE_PATH,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: AppRouteName.TASK_DETAIL_ROUTE_NAME,
        path: AppRoutePath.TASK_DETAIL_ROUTE_PATH,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final task = state.extra as TaskEntity;
          return TaskDetailScreen(initialTask: task);
        },
      ),
    ],
  );
}
