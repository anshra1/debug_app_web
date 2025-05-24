import 'package:debug_app_web/core/theme/dark_theme.dart';
import 'package:debug_app_web/core/theme/light_theme.dart';
import 'package:debug_app_web/core/theme/theme_provider.dart';
import 'package:debug_app_web/core/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({
    required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    super.key,
  });

  final Widget child;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: _ThemedApp(
        animationDuration: animationDuration,
        child: child,
      ),
    );
  }
}

class _ThemedApp extends StatelessWidget {
  const _ThemedApp({
    required this.child,
    required this.animationDuration,
  });

  final Widget child;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    final theme = themeProvider.isDarkMode ? DarkTheme.theme : LightTheme.theme;

    return AnimatedThemeSwitcher(
      duration: animationDuration,
      child: Theme(
        data: theme,
        child: child,
      ),
    );
  }
}
