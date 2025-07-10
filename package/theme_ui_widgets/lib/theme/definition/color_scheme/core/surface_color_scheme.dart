import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/color_converter.dart';

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
