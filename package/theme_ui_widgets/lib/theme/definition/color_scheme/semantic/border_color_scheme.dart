import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/color_converter.dart';

part 'border_color_scheme.freezed.dart';
part 'border_color_scheme.g.dart';

@freezed
class AppBorderColorScheme with _$AppBorderColorScheme {
  const factory AppBorderColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color tertiary,
    @ColorConverter() required Color disabled,
    @ColorConverter() required Color focus,
    @ColorConverter() required Color error,
    @ColorConverter() required Color success,
    @ColorConverter() required Color warning,
  }) = _AppBorderColorScheme;

  factory AppBorderColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppBorderColorSchemeFromJson(json);
}

extension AppBorderColorSchemeLerp on AppBorderColorScheme {
  AppBorderColorScheme lerpWith(AppBorderColorScheme other, double t) {
    return AppBorderColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
