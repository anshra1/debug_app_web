import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'text_color_scheme.freezed.dart';
part 'text_color_scheme.g.dart';

@freezed
class AppTextColorScheme with _$AppTextColorScheme {
  const factory AppTextColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color tertiary,
    @ColorConverter() required Color quaternary,
    @ColorConverter() required Color onFill,
    @ColorConverter() required Color action,
    @ColorConverter() required Color actionHover,
    @ColorConverter() required Color info,
    @ColorConverter() required Color infoHover,
    @ColorConverter() required Color success,
    @ColorConverter() required Color successHover,
    @ColorConverter() required Color warning,
    @ColorConverter() required Color warningHover,
    @ColorConverter() required Color error,
    @ColorConverter() required Color errorHover,
    @ColorConverter() required Color featured,
    @ColorConverter() required Color featuredHover,
  }) = _AppTextColorScheme;

  factory AppTextColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppTextColorSchemeFromJson(json);
}

// Extension for color conversion utilities
extension AppTextColorSchemeUtils on AppTextColorScheme {
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

  /// Get primary color as Color object
  Color get primaryColor => primary;

  /// Get secondary color as Color object
  Color get secondaryColor => secondary;

  /// Get tertiary color as Color object
  Color get tertiaryColor => tertiary;

  /// Get quaternary color as Color object
  Color get quaternaryColor => quaternary;

  /// Get onFill color as Color object
  Color get onFillColor => onFill;

  /// Get action color as Color object
  Color get actionColor => action;

  /// Get actionHover color as Color object
  Color get actionHoverColor => actionHover;

  /// Get info color as Color object
  Color get infoColor => info;

  /// Get infoHover color as Color object
  Color get infoHoverColor => infoHover;

  /// Get success color as Color object
  Color get successColor => success;

  /// Get successHover color as Color object
  Color get successHoverColor => successHover;

  /// Get warning color as Color object
  Color get warningColor => warning;

  /// Get warningHover color as Color object
  Color get warningHoverColor => warningHover;

  /// Get error color as Color object
  Color get errorColor => error;

  /// Get errorHover color as Color object
  Color get errorHoverColor => errorHover;

  /// Get featured color as Color object
  Color get featuredColor => featured;

  /// Get featuredHover color as Color object
  Color get featuredHoverColor => featuredHover;
}

extension AppTextColorSchemeLerp on AppTextColorScheme {
  AppTextColorScheme lerpWith(AppTextColorScheme other, double t) {
    return AppTextColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      quaternary: Color.lerp(quaternary, other.quaternary, t)!,
      onFill: Color.lerp(onFill, other.onFill, t)!,
      action: Color.lerp(action, other.action, t)!,
      actionHover: Color.lerp(actionHover, other.actionHover, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoHover: Color.lerp(infoHover, other.infoHover, t)!,
      success: Color.lerp(success, other.success, t)!,
      successHover: Color.lerp(successHover, other.successHover, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningHover: Color.lerp(warningHover, other.warningHover, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorHover: Color.lerp(errorHover, other.errorHover, t)!,
      featured: Color.lerp(featured, other.featured, t)!,
      featuredHover: Color.lerp(featuredHover, other.featuredHover, t)!,
    );
  }
}
