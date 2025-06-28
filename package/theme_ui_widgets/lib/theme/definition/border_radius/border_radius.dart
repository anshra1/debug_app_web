import 'package:freezed_annotation/freezed_annotation.dart';

part 'border_radius.freezed.dart';
part 'border_radius.g.dart';

@freezed
class AppBorderRadius with _$AppBorderRadius {
  const factory AppBorderRadius({
    required double xs,
    required double s,
    required double m,
    required double l,
    required double xl,
    required double xxl,
  }) = _AppBorderRadius;

  factory AppBorderRadius.fromJson(Map<String, dynamic> json) =>
      _$AppBorderRadiusFromJson(json);
}

extension AppBorderRadiusLerp on AppBorderRadius {
  AppBorderRadius lerpWith(AppBorderRadius other, double t) {
    return AppBorderRadius(
      xs: lerpDouble(xs, other.xs, t),
      s: lerpDouble(s, other.s, t),
      m: lerpDouble(m, other.m, t),
      l: lerpDouble(l, other.l, t),
      xl: lerpDouble(xl, other.xl, t),
      xxl: lerpDouble(xxl, other.xxl, t),
    );
  }

  /// Optional helper for scaling
  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
