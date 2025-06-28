import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'surface_color_scheme.freezed.dart';
part 'surface_color_scheme.g.dart';

@freezed
class AppSurfaceColorScheme with _$AppSurfaceColorScheme {
  const factory AppSurfaceColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color primaryHover,
    @ColorConverter() required Color layer01,
    @ColorConverter() required Color layer01Hover,
    @ColorConverter() required Color layer02,
    @ColorConverter() required Color layer02Hover,
    @ColorConverter() required Color layer03,
    @ColorConverter() required Color layer03Hover,
    @ColorConverter() required Color layer04,
    @ColorConverter() required Color layer04Hover,
    @ColorConverter() required Color inverse,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color overlay,
  }) = _AppSurfaceColorScheme;

  factory AppSurfaceColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppSurfaceColorSchemeFromJson(json);
}

// Extension for color conversion utilities
extension AppSurfaceColorSchemeUtils on AppSurfaceColorScheme {
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
  Color get tertiaryColor => layer01;

  /// Get quaternary color as Color object
  Color get quaternaryColor => layer02;

  /// Get onSurface color as Color object
  Color get onSurfaceColor => layer03;

  /// Get action color as Color object
  Color get actionColor => primaryHover;

  /// Get actionHover color as Color object
  Color get actionHoverColor => primaryHover;

  /// Get info color as Color object
  Color get infoColor => layer04;

  /// Get infoHover color as Color object
  Color get infoHoverColor => layer04Hover;

  /// Get success color as Color object
  Color get successColor => layer01;

  /// Get successHover color as Color object
  Color get successHoverColor => layer01Hover;

  /// Get warning color as Color object
  Color get warningColor => layer02;

  /// Get warningHover color as Color object
  Color get warningHoverColor => layer02Hover;

  /// Get error color as Color object
  Color get errorColor => layer03;

  /// Get errorHover color as Color object
  Color get errorHoverColor => layer03Hover;

  /// Get featured color as Color object
  Color get featuredColor => layer04;

  /// Get featuredHover color as Color object
  Color get featuredHoverColor => layer04Hover;
}

extension AppSurfaceColorSchemeLerp on AppSurfaceColorScheme {
  AppSurfaceColorScheme lerpWith(AppSurfaceColorScheme other, double t) {
    return AppSurfaceColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      layer01: Color.lerp(layer01, other.layer01, t)!,
      layer01Hover: Color.lerp(layer01Hover, other.layer01Hover, t)!,
      layer02: Color.lerp(layer02, other.layer02, t)!,
      layer02Hover: Color.lerp(layer02Hover, other.layer02Hover, t)!,
      layer03: Color.lerp(layer03, other.layer03, t)!,
      layer03Hover: Color.lerp(layer03Hover, other.layer03Hover, t)!,
      layer04: Color.lerp(layer04, other.layer04, t)!,
      layer04Hover: Color.lerp(layer04Hover, other.layer04Hover, t)!,
      inverse: Color.lerp(inverse, other.inverse, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
    );
  }
}
