import 'dart:ui';

import 'package:debug_app_web/features/apperence/models/app_theme_color_set.dart';
import 'package:theme_ui_widgets/theme/data/shared.dart';
import 'package:theme_ui_widgets/theme/definition/text_style/app_text_style.dart';
import 'package:theme_ui_widgets/theme/definition/theme_data.dart';

class AppThemeSet {
  AppThemeSet({
    required this.themeName,
    required this.lightThemeColors,
    required this.darkThemeColors,
    required this.isInbuilt,
    this.fontFamily,
  });

  final String themeName;
  final AppThemeColorSet lightThemeColors;
  final AppThemeColorSet darkThemeColors;
  final String? fontFamily;
  final bool isInbuilt;

  
  AppThemeData getLightTheme() {
    return AppThemeData(
      themeName: themeName,
      textColorScheme: lightThemeColors.textColorScheme,
      textStyle: AppTextStyle.customFontFamily(fontFamily ?? ''),
      iconColorScheme: lightThemeColors.iconColorScheme,
      borderColorScheme: lightThemeColors.borderColorScheme,
      badgeColorScheme: lightThemeColors.badgeColorScheme,
      backgroundColorScheme: lightThemeColors.backgroundColorScheme,
      fillColorScheme: lightThemeColors.fillColorScheme,
      surfaceColorScheme: lightThemeColors.surfaceColorScheme,
      borderRadius: AppSharedTokens.buildBorderRadius(),
      spacing: AppSharedTokens.buildSpacing(),
      shadow: AppSharedTokens.buildShadow(Brightness.light),
      brandColorScheme: lightThemeColors.brandColorScheme,
      surfaceContainerColorScheme: lightThemeColors.surfaceContainerColorScheme,
      otherColorsColorScheme: lightThemeColors.otherColorsColorScheme,
    );
  }

  AppThemeData getDarkTheme() {
    return AppThemeData(
      themeName: themeName,
      textColorScheme: darkThemeColors.textColorScheme,
      textStyle: AppTextStyle.customFontFamily(fontFamily ?? ''),
      iconColorScheme: darkThemeColors.iconColorScheme,
      borderColorScheme: darkThemeColors.borderColorScheme,
      badgeColorScheme: darkThemeColors.badgeColorScheme,
      backgroundColorScheme: darkThemeColors.backgroundColorScheme,
      fillColorScheme: darkThemeColors.fillColorScheme,
      surfaceColorScheme: darkThemeColors.surfaceColorScheme,
      borderRadius: AppSharedTokens.buildBorderRadius(),
      spacing: AppSharedTokens.buildSpacing(),
      shadow: AppSharedTokens.buildShadow(Brightness.dark),
      brandColorScheme: darkThemeColors.brandColorScheme,
      surfaceContainerColorScheme: darkThemeColors.surfaceContainerColorScheme,
      otherColorsColorScheme: darkThemeColors.otherColorsColorScheme,
    );
  }
}


