import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/core/false%20_t_h_e/design_system/app_colors.dart';
import 'package:debug_app_web/core/false%20_t_h_e/theme_extension/custom_color.dart' show CustomColors;
import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: LightColorsToken.scaffoldBackgroundColor,
        brightness: Brightness.light,
        useMaterial3: true,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
      //  colorScheme: AppColorScheme.light(),
        appBarTheme: _appBarTheme,
        colorScheme: const ColorScheme.light(
          primary: LightColorsToken.primaryColor,
          primaryContainer: LightColorsToken.primaryContainer,
          secondaryContainer: LightColorsToken.secondryContainerColor,
        ),
        textTheme: TextTheme(
          displayLarge:
              AppFonts.displayLarge.copyWith(color: LightColorsToken.textPrimary),
          displayMedium:
              AppFonts.displayMedium.copyWith(color: LightColorsToken.textPrimary),
          displaySmall:
              AppFonts.displaySmall.copyWith(color: LightColorsToken.textPrimary),
          headlineLarge:
              AppFonts.headlineLarge.copyWith(color: LightColorsToken.textPrimary),
          headlineMedium:
              AppFonts.headlineMedium.copyWith(color: LightColorsToken.textPrimary),
          headlineSmall:
              AppFonts.headlineSmall.copyWith(color: LightColorsToken.textPrimary),
          titleLarge: AppFonts.titleLarge.copyWith(color: LightColorsToken.textPrimary),
          titleMedium: AppFonts.titleMedium.copyWith(color: LightColorsToken.textPrimary),
          titleSmall: AppFonts.titleSmall.copyWith(color: LightColorsToken.textPrimary),
          labelLarge: AppFonts.labelLarge.copyWith(color: LightColorsToken.textPrimary),
          labelMedium: AppFonts.labelMedium.copyWith(color: LightColorsToken.textPrimary),
          labelSmall: AppFonts.labelSmall.copyWith(color: LightColorsToken.textPrimary),
          bodyLarge: AppFonts.bodyLarge.copyWith(color: LightColorsToken.textPrimary),
          bodyMedium: AppFonts.bodyMedium.copyWith(color: LightColorsToken.textPrimary),
          bodySmall: AppFonts.bodySmall.copyWith(color: LightColorsToken.textPrimary),
        ),
        extensions: const [
          CustomColors(
            success: LightColorsToken.success,
            warning: LightColorsToken.warning,
            info: LightColorsToken.info,
            border: LightColorsToken.border,
          ),
        ],
      );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ElevationTokens.level1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      minimumSize: const Size(64, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: LightColorsToken.primaryColor,
      foregroundColor: LightColorsToken.textInverse,
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding:
          const EdgeInsets.symmetric(horizontal: Spacing.md16, vertical: Spacing.sm12),
      minimumSize: const Size(64, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      side: const BorderSide(color: LightColorsToken.border),
      foregroundColor: LightColorsToken.textPrimary,
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      minimumSize: const Size(64, 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      foregroundColor: LightColorsToken.textPrimary,
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: LightColorsToken.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: LightColorsToken.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.error),
    ),
    filled: true,
    fillColor: LightColorsToken.backgroundSecondary,
  );

  // static final _cardTheme = CardTheme(
  //   elevation: 1,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //   margin: const EdgeInsets.all(Spacing.sm12),
  //   color: LightColorsToken.surface,
  // );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
    backgroundColor: LightColorsToken.surface,
    foregroundColor: LightColorsToken.textPrimary,
  );
}
