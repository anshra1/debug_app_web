

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';
import 'package:theme_ui_widgets/theme/definition/app_theme_data.dart';

class AnimatedAppTheme extends ImplicitlyAnimatedWidget {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve.
  const AnimatedAppTheme({
    required this.data,
    required this.child,
    super.key,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
  });

  /// Specifies the color and typography values for descendant widgets.
  final AppThemeData data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  AnimatedWidgetBaseState<AnimatedAppTheme> createState() => _AnimatedThemeState();
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<AnimatedAppTheme> {
  AppThemeDataTween? data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    data = visitor(
      data,
      widget.data,
      (dynamic value) => AppThemeDataTween(begin: value as AppThemeData),
    )! as AppThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(data: data!.evaluate(animation), child: widget.child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(
      DiagnosticsProperty<AppThemeDataTween>(
        'data',
        data,
        showName: false,
        defaultValue: null,
      ),
    );
  }
}


 