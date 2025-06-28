import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'badge_color_scheme.freezed.dart';
part 'badge_color_scheme.g.dart';

/// Represents the color variations for a single badge.
@freezed
class SingleBadgeColor with _$SingleBadgeColor {
  const factory SingleBadgeColor({
    @ColorConverter() required Color light1,
    @ColorConverter() required Color light2,
    @ColorConverter() required Color light3,
    @ColorConverter() required Color thick1,
    @ColorConverter() required Color thick2,
    @ColorConverter() required Color thick3,
  }) = _SingleBadgeColor;

  factory SingleBadgeColor.fromJson(Map<String, dynamic> json) =>
      _$SingleBadgeColorFromJson(json);
}

/// Defines the color scheme for all badges in the application.
@freezed
class AppBadgeColorScheme with _$AppBadgeColorScheme {
  const factory AppBadgeColorScheme({
    required List<SingleBadgeColor> badgeColors,
  }) = _AppBadgeColorScheme;

  factory AppBadgeColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppBadgeColorSchemeFromJson(json);
}

// Extension for lerp functionality on SingleBadgeColor
extension SingleBadgeColorLerp on SingleBadgeColor {
  SingleBadgeColor lerpWith(SingleBadgeColor other, double t) {
    return SingleBadgeColor(
      light1: Color.lerp(light1, other.light1, t)!,
      light2: Color.lerp(light2, other.light2, t)!,
      light3: Color.lerp(light3, other.light3, t)!,
      thick1: Color.lerp(thick1, other.thick1, t)!,
      thick2: Color.lerp(thick2, other.thick2, t)!,
      thick3: Color.lerp(thick3, other.thick3, t)!,
    );
  }
}

// Extension for lerp functionality on AppBadgeColorScheme
extension AppBadgeColorSchemeLerp on AppBadgeColorScheme {
  AppBadgeColorScheme lerpWith(AppBadgeColorScheme other, double t) {
    if (badgeColors.length != other.badgeColors.length) {
      throw ArgumentError('Badge color lists must have the same length');
    }

    return AppBadgeColorScheme(
      badgeColors: List.generate(
        badgeColors.length,
        (index) => badgeColors[index].lerpWith(other.badgeColors[index], t),
      ),
    );
  }
}
