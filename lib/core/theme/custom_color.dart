import 'package:flutter/material.dart';

 @immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.border,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color border;

  // Required override to support copying theme with modified values
  @override
  CustomColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? border,
  }) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      border: border ?? this.border,
    );
  }

  // Required override to support theme lerping (smooth transitions)
  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}