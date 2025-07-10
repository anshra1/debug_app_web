import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/color_converter.dart';

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

extension AppSurfaceContainerColorSchemeLerp on AppSurfaceContainerColorScheme {
  AppSurfaceContainerColorScheme lerpWith(
      AppSurfaceContainerColorScheme other, double t) {
    return AppSurfaceContainerColorScheme(
      layer01: Color.lerp(layer01, other.layer01, t)!,
      layer02: Color.lerp(layer02, other.layer02, t)!,
      layer03: Color.lerp(layer03, other.layer03, t)!,
    );
  }
}
