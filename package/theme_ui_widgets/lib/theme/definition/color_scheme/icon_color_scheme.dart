import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'icon_color_scheme.freezed.dart';
part 'icon_color_scheme.g.dart';

@freezed
class AppIconColorScheme with _$AppIconColorScheme {
  const factory AppIconColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color tertiary,
    @ColorConverter() required Color quaternary,
    @ColorConverter() required Color onFill,
    @ColorConverter() required Color featuredThick,
    @ColorConverter() required Color featuredThickHover,
    @ColorConverter() required Color infoThick,
    @ColorConverter() required Color infoThickHover,
    @ColorConverter() required Color successThick,
    @ColorConverter() required Color successThickHover,
    @ColorConverter() required Color warningThick,
    @ColorConverter() required Color warningThickHover,
    @ColorConverter() required Color errorThick,
    @ColorConverter() required Color errorThickHover,
  }) = _AppIconColorScheme;

  factory AppIconColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppIconColorSchemeFromJson(json);
}

extension AppIconColorSchemeLerp on AppIconColorScheme {
  AppIconColorScheme lerpWith(AppIconColorScheme other, double t) {
    return AppIconColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      quaternary: Color.lerp(quaternary, other.quaternary, t)!,
      onFill: Color.lerp(onFill, other.onFill, t)!,
      featuredThick: Color.lerp(featuredThick, other.featuredThick, t)!,
      featuredThickHover: Color.lerp(featuredThickHover, other.featuredThickHover, t)!,
      infoThick: Color.lerp(infoThick, other.infoThick, t)!,
      infoThickHover: Color.lerp(infoThickHover, other.infoThickHover, t)!,
      successThick: Color.lerp(successThick, other.successThick, t)!,
      successThickHover: Color.lerp(successThickHover, other.successThickHover, t)!,
      warningThick: Color.lerp(warningThick, other.warningThick, t)!,
      warningThickHover: Color.lerp(warningThickHover, other.warningThickHover, t)!,
      errorThick: Color.lerp(errorThick, other.errorThick, t)!,
      errorThickHover: Color.lerp(errorThickHover, other.errorThickHover, t)!,
    );
  }
}
