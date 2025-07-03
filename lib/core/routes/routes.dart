import 'package:debug_app_web/core/di/depandency_injection.dart';
import 'package:debug_app_web/core/pages/page_not_found.dart';
import 'package:debug_app_web/core/routes/route_name.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:debug_app_web/features/home/presentation/pages/home_page.dart';
import 'package:debug_app_web/features/setting/setting_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> mainMenuNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'main_menu');

  // Expose the root navigator key for global services
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  static final GoRouter router = GoRouter(
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const PageNotFoundScreen()),
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutesName.initial,
    routes: [
      GoRoute(
        path: RoutesName.pageNotFound,
        name: RoutesName.pageNotFound,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: const PageNotFoundScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: RoutesName.initial,
        name: RoutesName.initial,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: BlocProvider(
              create: (context) => sl<ServerCubit>(),
              child: const HomePage(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        path: RoutesName.setting,
        name: RoutesName.setting,
        pageBuilder: (_, state) {
          return _buildTransition(child: const SettingHomepage(), state: state);
        },
      ),
     
    ],
  );

  static Page<void> _buildTransition({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: kThemeAnimationDuration,
      reverseTransitionDuration: kThemeAnimationDuration,
    );
  }
}
