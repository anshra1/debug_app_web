// lib/src/app/root_app.dart
import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/core/routes/routes.dart';
import 'package:debug_app_web/core/theme/themes/dark_theme.dart';
import 'package:debug_app_web/core/theme/themes/light_theme.dart';
import 'package:debug_app_web/core/utils/utils/dismiss_keyboard.dart';
import 'package:debug_app_web/features/apperence/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/apperence/cubit/apperence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

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
      create: (context) {
        final cubit = AppearanceCubit()..init();
        // Initialize asynchronously - state will update when ready
        return cubit;
      },
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

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppearanceCubit, AppearanceState>(
      builder: (context, state) {
        final appearanceCubit = context.read<AppearanceCubit>();
        final isDark = appearanceCubit.isDarkMode;

        return AppTheme(
          data: appearanceCubit.currentThemeData,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            child: DismissKeyboard(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppConfig.appName,
                theme: LightTheme.theme,
                darkTheme: DarkTheme.theme,
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
