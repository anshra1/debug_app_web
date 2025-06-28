import 'dart:ui' show lerpDouble;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'spacing.freezed.dart';
part 'spacing.g.dart';

@freezed
class AppSpacing with _$AppSpacing {
  const factory AppSpacing({
    required double xs,
    required double s,
    required double m,
    required double l,
    required double xl,
    required double xxl,
  }) = _AppSpacing;

  factory AppSpacing.fromJson(Map<String, dynamic> json) => _$AppSpacingFromJson(json);
}

extension AppSpacingLerp on AppSpacing {
  AppSpacing lerpWith(AppSpacing other, double t) {
    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      s: lerpDouble(s, other.s, t)!,
      m: lerpDouble(m, other.m, t)!,
      l: lerpDouble(l, other.l, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
    );
  }
}
