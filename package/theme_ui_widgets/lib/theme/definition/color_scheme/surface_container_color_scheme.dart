import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../utils/color_converter.dart';

part 'surface_container_color_scheme.freezed.dart';
part 'surface_container_color_scheme.g.dart';

@freezed
class AppSurfaceContainerColorScheme with _$AppSurfaceContainerColorScheme {
  const factory AppSurfaceContainerColorScheme({
    @ColorConverter() required Color layer01,
    @ColorConverter() required Color layer02,
    @ColorConverter() required Color layer03,
  }) = _AppSurfaceContainerColorScheme;

  factory AppSurfaceContainerColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppSurfaceContainerColorSchemeFromJson(json);
}

// Extension for color conversion utilities
extension AppSurfaceContainerColorSchemeUtils on AppSurfaceContainerColorScheme {
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

  /// Get layer01 color as Color object
  Color get layer01Color => layer01;

  /// Get layer02 color as Color object
  Color get layer02Color => layer02;

  /// Get layer03 color as Color object
  Color get layer03Color => layer03;
}

extension AppSurfaceContainerColorSchemeLerp on AppSurfaceContainerColorScheme {
  AppSurfaceContainerColorScheme lerpWith(AppSurfaceContainerColorScheme other, double t) {
    return AppSurfaceContainerColorScheme(
      layer01: Color.lerp(layer01, other.layer01, t)!,
      layer02: Color.lerp(layer02, other.layer02, t)!,
      layer03: Color.lerp(layer03, other.layer03, t)!,
    );
  }
}
