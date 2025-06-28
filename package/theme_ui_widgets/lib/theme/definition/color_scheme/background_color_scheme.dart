import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'background_color_scheme.freezed.dart';
part 'background_color_scheme.g.dart';

@freezed
class AppBackgroundColorScheme with _$AppBackgroundColorScheme {
  const factory AppBackgroundColorScheme({
    @ColorConverter() required Color primary,
  }) = _AppBackgroundColorScheme;

  factory AppBackgroundColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppBackgroundColorSchemeFromJson(json);
}

extension AppBackgroundColorSchemeLerp on AppBackgroundColorScheme {
  AppBackgroundColorScheme lerpWith(AppBackgroundColorScheme other, double t) {
    return AppBackgroundColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }
}
