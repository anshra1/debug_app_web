// Dark Theme
import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/core/false%20_t_h_e/design_system/app_colors.dart';
import 'package:debug_app_web/core/false%20_t_h_e/theme_extension/custom_color.dart' show CustomColors;
import 'package:flutter/material.dart';

class DarkTheme {
  final color = DarkColorsToken();
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: DarkColorsToken.scaffoldBackgroundColor,
        brightness: Brightness.dark,
        useMaterial3: true,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
      
        appBarTheme: _appBarTheme,
        
        colorScheme: const ColorScheme.dark(
          primary: DarkColorsToken.primaryColor,
          primaryContainer: DarkColorsToken.primaryContainer,
          secondaryContainer: DarkColorsToken.secondryContainerColor,
        ),
        textTheme: TextTheme(
          displayLarge:
              AppFonts.displayLarge.copyWith(color: DarkColorsToken.textPrimary),
          displayMedium:
              AppFonts.displayMedium.copyWith(color: DarkColorsToken.textPrimary),
          displaySmall:
              AppFonts.displaySmall.copyWith(color: DarkColorsToken.textPrimary),
          headlineLarge:
              AppFonts.headlineLarge.copyWith(color: DarkColorsToken.textPrimary),
          headlineMedium:
              AppFonts.headlineMedium.copyWith(color: DarkColorsToken.textPrimary),
          headlineSmall:
              AppFonts.headlineSmall.copyWith(color: DarkColorsToken.textPrimary),
          titleLarge: AppFonts.titleLarge.copyWith(color: DarkColorsToken.textPrimary),
          titleMedium: AppFonts.titleMedium.copyWith(color: DarkColorsToken.textPrimary),
          titleSmall: AppFonts.titleSmall.copyWith(color: DarkColorsToken.textPrimary),
          labelLarge: AppFonts.labelLarge.copyWith(color: DarkColorsToken.textPrimary),
          labelMedium: AppFonts.labelMedium.copyWith(color: DarkColorsToken.textPrimary),
          labelSmall: AppFonts.labelSmall.copyWith(color: DarkColorsToken.textPrimary),
          bodyLarge: AppFonts.bodyLarge.copyWith(color: DarkColorsToken.textPrimary),
          bodyMedium: AppFonts.bodyMedium.copyWith(color: DarkColorsToken.textPrimary),
          bodySmall: AppFonts.bodySmall.copyWith(color: DarkColorsToken.textPrimary),
        ),
        extensions: const [
          CustomColors(
            success: DarkColorsToken.success,
            warning: DarkColorsToken.warning,
            info: DarkColorsToken.info,
            border: DarkColorsToken.border,
          ),
        ],
      );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ElevationTokens.level1,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      minimumSize: const Size(64, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: DarkColorsToken.primaryColor,
      foregroundColor: DarkColorsToken.textInverse,
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md16,
        vertical: Spacing.sm12,
      ),
      minimumSize: const Size(64, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: const BorderSide(color: DarkColorsToken.border),
      foregroundColor: DarkColorsToken.textPrimary,
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      minimumSize: const Size(64, 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      foregroundColor: DarkColorsToken.textPrimary,
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: DarkColorsToken.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: DarkColorsToken.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.error),
    ),
    filled: true,
    fillColor: DarkColorsToken.backgroundSecondary,
  );

  // static final _cardTheme = CardTheme(
  //   elevation: 1,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(16),
  //   ),
  //   margin: const EdgeInsets.all(Spacing.sm12),
  //   color: DarkColorsToken.surface,
  // );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
    backgroundColor: DarkColorsToken.surface,
    foregroundColor: DarkColorsToken.textPrimary,
  );
}
