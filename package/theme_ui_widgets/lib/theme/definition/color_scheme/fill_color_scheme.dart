import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'fill_color_scheme.freezed.dart';
part 'fill_color_scheme.g.dart';

@freezed
class AppFillColorScheme with _$AppFillColorScheme {
  const factory AppFillColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color primaryHover,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color secondaryHover,
    @ColorConverter() required Color tertiary,
    @ColorConverter() required Color tertiaryHover,
    @ColorConverter() required Color quaternary,
    @ColorConverter() required Color quaternaryHover,
    @ColorConverter() required Color content,
    @ColorConverter() required Color contentHover,
    @ColorConverter() required Color contentVisible,
    @ColorConverter() required Color contentVisibleHover,
    @ColorConverter() required Color themeThick,
    @ColorConverter() required Color themeThickHover,
    @ColorConverter() required Color themeSelect,
    @ColorConverter() required Color textSelect,
    @ColorConverter() required Color infoLight,
    @ColorConverter() required Color infoLightHover,
    @ColorConverter() required Color infoThick,
    @ColorConverter() required Color infoThickHover,
    @ColorConverter() required Color successLight,
    @ColorConverter() required Color successLightHover,
    @ColorConverter() required Color warningLight,
    @ColorConverter() required Color warningLightHover,
    @ColorConverter() required Color errorLight,
    @ColorConverter() required Color errorLightHover,
    @ColorConverter() required Color errorThick,
    @ColorConverter() required Color errorThickHover,
    @ColorConverter() required Color errorSelect,
    @ColorConverter() required Color featuredLight,
    @ColorConverter() required Color featuredLightHover,
    @ColorConverter() required Color featuredThick,
    @ColorConverter() required Color featuredThickHover,
  }) = _AppFillColorScheme;

  factory AppFillColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppFillColorSchemeFromJson(json);
}

// Extension for color conversion utilities
extension AppFillColorSchemeUtils on AppFillColorScheme {
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
  Color get onFillColor => content;

  /// Get action color as Color object
  Color get actionColor => primary;

  /// Get actionHover color as Color object
  Color get actionHoverColor => primaryHover;

  /// Get info color as Color object
  Color get infoColor => infoLight;

  /// Get infoHover color as Color object
  Color get infoHoverColor => infoLightHover;

  /// Get success color as Color object
  Color get successColor => successLight;

  /// Get successHover color as Color object
  Color get successHoverColor => successLightHover;

  /// Get warning color as Color object
  Color get warningColor => warningLight;

  /// Get warningHover color as Color object
  Color get warningHoverColor => warningLightHover;

  /// Get error color as Color object
  Color get errorColor => errorLight;

  /// Get errorHover color as Color object
  Color get errorHoverColor => errorLightHover;

  /// Get featured color as Color object
  Color get featuredColor => featuredLight;

  /// Get featuredHover color as Color object
  Color get featuredHoverColor => featuredLightHover;
}

extension AppFillColorSchemeLerp on AppFillColorScheme {
  AppFillColorScheme lerpWith(AppFillColorScheme other, double t) {
    return AppFillColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      tertiaryHover: Color.lerp(tertiaryHover, other.tertiaryHover, t)!,
      quaternary: Color.lerp(quaternary, other.quaternary, t)!,
      quaternaryHover: Color.lerp(quaternaryHover, other.quaternaryHover, t)!,
      content: Color.lerp(content, other.content, t)!,
      contentHover: Color.lerp(contentHover, other.contentHover, t)!,
      contentVisible: Color.lerp(contentVisible, other.contentVisible, t)!,
      contentVisibleHover: Color.lerp(contentVisibleHover, other.contentVisibleHover, t)!,
      themeThick: Color.lerp(themeThick, other.themeThick, t)!,
      themeThickHover: Color.lerp(themeThickHover, other.themeThickHover, t)!,
      themeSelect: Color.lerp(themeSelect, other.themeSelect, t)!,
      textSelect: Color.lerp(textSelect, other.textSelect, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      infoLightHover: Color.lerp(infoLightHover, other.infoLightHover, t)!,
      infoThick: Color.lerp(infoThick, other.infoThick, t)!,
      infoThickHover: Color.lerp(infoThickHover, other.infoThickHover, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      successLightHover: Color.lerp(successLightHover, other.successLightHover, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      warningLightHover: Color.lerp(warningLightHover, other.warningLightHover, t)!,
      errorLight: Color.lerp(errorLight, other.errorLight, t)!,
      errorLightHover: Color.lerp(errorLightHover, other.errorLightHover, t)!,
      errorThick: Color.lerp(errorThick, other.errorThick, t)!,
      errorThickHover: Color.lerp(errorThickHover, other.errorThickHover, t)!,
      errorSelect: Color.lerp(errorSelect, other.errorSelect, t)!,
      featuredLight: Color.lerp(featuredLight, other.featuredLight, t)!,
      featuredLightHover: Color.lerp(featuredLightHover, other.featuredLightHover, t)!,
      featuredThick: Color.lerp(featuredThick, other.featuredThick, t)!,
      featuredThickHover: Color.lerp(featuredThickHover, other.featuredThickHover, t)!,
    );
  }
}
