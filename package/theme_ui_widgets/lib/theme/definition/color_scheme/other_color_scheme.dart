import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'other_color_scheme.freezed.dart';
part 'other_color_scheme.g.dart';

@freezed
class AppOtherColorsColorScheme with _$AppOtherColorsColorScheme {
  const factory AppOtherColorsColorScheme({
    @ColorConverter() required Color textHighlight,
  }) = _AppOtherColorsColorScheme;

  factory AppOtherColorsColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppOtherColorsColorSchemeFromJson(json);
}

extension AppOtherColorsColorSchemeLerp on AppOtherColorsColorScheme {
  AppOtherColorsColorScheme lerpWith(AppOtherColorsColorScheme other, double t) {
    return AppOtherColorsColorScheme(
      textHighlight: Color.lerp(textHighlight, other.textHighlight, t)!,
    );
  }
}
