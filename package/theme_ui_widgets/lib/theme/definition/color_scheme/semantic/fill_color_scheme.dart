import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/color_converter.dart';

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
