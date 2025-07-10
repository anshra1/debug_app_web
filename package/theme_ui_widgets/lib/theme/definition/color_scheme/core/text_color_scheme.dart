import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/color_converter.dart';

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
