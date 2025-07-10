// lib/src/app/root_app.dart
import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/core/constants/build.dart';
import 'package:debug_app_web/core/di/depandency_injection.dart';
import 'package:debug_app_web/core/false%20_t_h_e/apperence/apperence.dart';
import 'package:debug_app_web/core/routes/routes.dart';
import 'package:debug_app_web/core/services/toast_service.dart';
import 'package:debug_app_web/core/utils/utils/dismiss_keyboard.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/apperence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_ui_widgets/animated_theme.dart';
import 'package:theme_ui_widgets/app_theme.dart';

class AppConfig {
  const AppConfig._();

  static const String appName = 'Error Tracker Pro';
  static const Locale defaultLocale = Locale('en', 'US');
  static const Size designSize = Size(1080, 1920);
  static const double minTextScale = 0.8;
  static const double maxTextScale = 1.2;
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppearanceCubit()..init(),
      child: ScreenUtilInit(
        designSize: AppConfig.designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const AppContainer();
        },
      ),
    );
  }
}

class AppContainer extends HookWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Track how often the ENTIRE app rebuilds due to appearance changes
    useDebugRebuildTracker(
      'RootApp-AppContainer',
      customLogThreshold: 1, // Log every rebuild
      customWarningThreshold: 3, // Warn after 3 rebuilds
    );

    // 🎯 SOLUTION: BlocConsumer with separate listenWhen and buildWhen
    return BlocConsumer<AppearanceCubit, AppearanceState>(
      listenWhen: (previous, current) {
        // Only listen for error changes to show toasts
        return previous.errorMessage != current.errorMessage &&
            current.errorMessage != null;
      },
      listener: (context, state) {
        // Handle error messages in dedicated listener
        if (state.errorMessage != null) {
          sl<ToastService>().showErrorToast(
            title: 'Error',
            description: state.errorMessage,
          );
        }
      },
      buildWhen: (previous, current) {
        // Only rebuild for theme-related changes (NOT error changes)
        return previous.appThemeSet != current.appThemeSet ||
            previous.themeMode != current.themeMode ||
            previous.fontFamily != current.fontFamily;
      },
      builder: (context, state) {
        final appearanceCubit = context.read<AppearanceCubit>();
        final isDark = appearanceCubit.isDarkMode;

        return AnimatedAppTheme(
          data: appearanceCubit.currentThemeData,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            child: DismissKeyboard(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppConfig.appName,

                theme: AppFlutterTheme.toFlutterTheme(
                  appearanceCubit.currentThemeData,
                  brightness: isDark ? Brightness.dark : Brightness.light,
                  fontFamily: state.fontFamily,
                ),
                themeMode: state.themeMode,
                routerConfig: AppRouter.router,
                //
                builder: (context, child) {
                  final textScale = context.mediaQuery.textScaler.scale(1).clamp(
                        AppConfig.minTextScale,
                        AppConfig.maxTextScale,
                      );

                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      platformBrightness: Theme.of(context).brightness,
                      textScaler: TextScaler.linear(textScale),
                    ),
                    child: ErrorBoundary(
                      child: child ?? const SizedBox.shrink(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class ErrorBoundary extends StatelessWidget {
  const ErrorBoundary({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(
        child: child,
      ),
    );
  }
}
