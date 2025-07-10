import 'package:debug_app_web/core/wrappers/base/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wrapper that handles system UI style (status bar, navigation bar)
class SystemUIWrapper implements AppWrapper {
  const SystemUIWrapper({required this.style});
  final SystemUiOverlayStyle style;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: child,
    );
  }

  @override
  int get priority => 1; // Runs first to set system UI style
}
