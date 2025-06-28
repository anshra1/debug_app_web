import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'border_color_scheme.freezed.dart';
part 'border_color_scheme.g.dart';

@freezed
class AppBorderColorScheme with _$AppBorderColorScheme {
  const factory AppBorderColorScheme({
    @ColorConverter() required Color primary,
    @ColorConverter() required Color primaryHover,
    @ColorConverter() required Color secondary,
    @ColorConverter() required Color secondaryHover,
    @ColorConverter() required Color tertiary,
    @ColorConverter() required Color tertiaryHover,
    @ColorConverter() required Color themeThick,
    @ColorConverter() required Color themeThickHover,
    @ColorConverter() required Color infoThick,
    @ColorConverter() required Color infoThickHover,
    @ColorConverter() required Color successThick,
    @ColorConverter() required Color successThickHover,
    @ColorConverter() required Color warningThick,
    @ColorConverter() required Color warningThickHover,
    @ColorConverter() required Color errorThick,
    @ColorConverter() required Color errorThickHover,
    @ColorConverter() required Color featuredThick,
    @ColorConverter() required Color featuredThickHover,
  }) = _AppBorderColorScheme;

  factory AppBorderColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppBorderColorSchemeFromJson(json);
}

extension AppBorderColorSchemeLerp on AppBorderColorScheme {
  AppBorderColorScheme lerpWith(AppBorderColorScheme other, double t) {
    return AppBorderColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryHover: Color.lerp(secondaryHover, other.secondaryHover, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      tertiaryHover: Color.lerp(tertiaryHover, other.tertiaryHover, t)!,
      themeThick: Color.lerp(themeThick, other.themeThick, t)!,
      themeThickHover: Color.lerp(themeThickHover, other.themeThickHover, t)!,
      infoThick: Color.lerp(infoThick, other.infoThick, t)!,
      infoThickHover: Color.lerp(infoThickHover, other.infoThickHover, t)!,
      successThick: Color.lerp(successThick, other.successThick, t)!,
      successThickHover: Color.lerp(successThickHover, other.successThickHover, t)!,
      warningThick: Color.lerp(warningThick, other.warningThick, t)!,
      warningThickHover: Color.lerp(warningThickHover, other.warningThickHover, t)!,
      errorThick: Color.lerp(errorThick, other.errorThick, t)!,
      errorThickHover: Color.lerp(errorThickHover, other.errorThickHover, t)!,
      featuredThick: Color.lerp(featuredThick, other.featuredThick, t)!,
      featuredThickHover: Color.lerp(featuredThickHover, other.featuredThickHover, t)!,
    );
  }
}
