import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/color_converter.dart';

part 'brand_color_scheme.freezed.dart';
part 'brand_color_scheme.g.dart';

@freezed
class AppBrandColorScheme with _$AppBrandColorScheme {
  const factory AppBrandColorScheme({
    @ColorConverter() required Color skyline,
    @ColorConverter() required Color aqua,
    @ColorConverter() required Color violet,
    @ColorConverter() required Color amethyst,
    @ColorConverter() required Color berry,
    @ColorConverter() required Color coral,
    @ColorConverter() required Color golden,
    @ColorConverter() required Color amber,
    @ColorConverter() required Color lemon,
  }) = _AppBrandColorScheme;

  factory AppBrandColorScheme.fromJson(Map<String, dynamic> json) =>
      _$AppBrandColorSchemeFromJson(json);
}

extension AppBrandColorSchemeLerp on AppBrandColorScheme {
  AppBrandColorScheme lerpWith(AppBrandColorScheme other, double t) {
    return AppBrandColorScheme(
      skyline: Color.lerp(skyline, other.skyline, t)!,
      aqua: Color.lerp(aqua, other.aqua, t)!,
      violet: Color.lerp(violet, other.violet, t)!,
      amethyst: Color.lerp(amethyst, other.amethyst, t)!,
      berry: Color.lerp(berry, other.berry, t)!,
      coral: Color.lerp(coral, other.coral, t)!,
      golden: Color.lerp(golden, other.golden, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      lemon: Color.lerp(lemon, other.lemon, t)!,
    );
  }
}
