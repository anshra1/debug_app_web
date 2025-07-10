import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'border_radius/border_radius.dart';
import 'color_scheme/brand/badge_color_scheme.dart';
import 'color_scheme/color_scheme.dart';
import 'shadow/shadow.dart';
import 'spacing/spacing.dart';
import 'text_style/app_text_style.dart';

part 'app_theme_data.freezed.dart';
part 'app_theme_data.g.dart';

/// [AppThemeData] defines the structure of the design system, and contains
/// the data that all child widgets will have access to.
@freezed
class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    required String themeName,
    required AppTextColorScheme textColorScheme,
    required AppTextStyle textStyle,
    required AppIconColorScheme iconColorScheme,
    required AppBorderColorScheme borderColorScheme,
    required AppBadgeColorScheme badgeColorScheme,
    required AppBackgroundColorScheme backgroundColorScheme,
    required AppFillColorScheme fillColorScheme,
    required AppSurfaceColorScheme surfaceColorScheme,
    required AppBorderRadius borderRadius,
    required AppSpacing spacing,
    required AppShadow shadow,
    required AppBrandColorScheme brandColorScheme,
    required AppSurfaceContainerColorScheme surfaceContainerColorScheme,
    required AppOtherColorsColorScheme otherColorsColorScheme,
  }) = _AppThemeData;

  factory AppThemeData.fromJson(Map<String, dynamic> json) =>
      _$AppThemeDataFromJson(json);

  /// Static lerp method is preferred here to match Flutter's standard lerp pattern
  // // ignore: prefer_constructors_over_static_methods
  static AppThemeData lerp(
    AppThemeData begin,
    AppThemeData end,
    double t,
  ) {
    return AppThemeData(
      themeName: begin.themeName,
      textColorScheme: begin.textColorScheme.lerpWith(
        end.textColorScheme,
        t,
      ),
      textStyle: end.textStyle,
      iconColorScheme: begin.iconColorScheme.lerpWith(
        end.iconColorScheme,
        t,
      ),
      borderColorScheme: begin.borderColorScheme.lerpWith(
        end.borderColorScheme,
        t,
      ),
      backgroundColorScheme: begin.backgroundColorScheme.lerpWith(
        end.backgroundColorScheme,
        t,
      ),
      fillColorScheme: begin.fillColorScheme.lerpWith(
        end.fillColorScheme,
        t,
      ),
      surfaceColorScheme: begin.surfaceColorScheme.lerpWith(
        end.surfaceColorScheme,
        t,
      ),
      borderRadius: end.borderRadius,
      spacing: end.spacing,
      shadow: end.shadow,
      brandColorScheme: begin.brandColorScheme.lerpWith(
        end.brandColorScheme,
        t,
      ),
      otherColorsColorScheme: begin.otherColorsColorScheme.lerpWith(
        end.otherColorsColorScheme,
        t,
      ),
      surfaceContainerColorScheme: begin.surfaceContainerColorScheme.lerpWith(
        end.surfaceContainerColorScheme,
        t,
      ),
      badgeColorScheme: begin.badgeColorScheme.lerpWith(
        end.badgeColorScheme,
        t,
      ),
    );
  }

  AppThemeData lerpWith(AppThemeData other, double t) {
    return AppThemeData.lerp(this, other, t);
  }
}

/// [AppThemeBuilder] is used to build the light and dark themes. Extend
/// this class to create a built-in theme, or use the [CustomTheme] class to
/// create a custom theme from JSON data.
///
/// See also:
///
/// - [AppThemeData] for the main theme data class.

// Utility methods for color conversion
extension AppThemeDataUtils on AppThemeData {
  /// Convert hex color string to Color
  Color hexToColor(String hex) {
    final hexColor = hex.replaceAll('#', '');
    final colorHex =
        hexColor.length == 6 ? 'FF$hexColor' : hexColor; // Add alpha channel if needed
    return Color(int.parse(colorHex, radix: 16));
  }

  /// Convert Color to hex string
  String colorToHex(Color color) {
    return '#${(((color.a * 255).round() << 24) | ((color.r * 255).round() << 16) | ((color.g * 255).round() << 8) | (color.b * 255).round()).toRadixString(16).padLeft(8, '0')}';
  }

 
}
