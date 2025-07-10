import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/theme/definition/app_theme_data.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({required this.data, required this.child, super.key});

  final AppThemeData data;
  final Widget child;

  static AppThemeData of(BuildContext context, {bool listen = true}) {
    final provider = maybeOf(context, listen: listen);
    if (provider == null) {
      throw FlutterError('''
        AppTheme.of() called with a context that does not contain a AppTheme.\n
        No AppTheme ancestor could be found starting from the context that was passed to AppTheme.of().
        This can happen because you do not have a AppTheme widget (which introduces a AppTheme),
        or it can happen if the context you use comes from a widget above this widget.\n
        The context used was: $context''');
    }
    return provider;
  }

  static AppThemeData? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<AppInheritedTheme>()?.themeData;
    }
    final provider =
        context.getElementForInheritedWidgetOfExactType<AppInheritedTheme>()?.widget;

    return (provider as AppInheritedTheme?)?.themeData;
  }

  @override
  Widget build(BuildContext context) {
    return AppInheritedTheme(themeData: data, child: child);
  }
}

class AppInheritedTheme extends InheritedTheme {
  const AppInheritedTheme({required this.themeData, required super.child, super.key});

  final AppThemeData themeData;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppTheme(data: themeData, child: child);
  }

  @override
  bool updateShouldNotify(AppInheritedTheme oldWidget) =>
      themeData != oldWidget.themeData;
}

/// An interpolation between two [AppThemeData]s.
///
/// This class specializes the interpolation of [Tween<AppThemeData>] to
/// call the [AppThemeData.lerp] method.
///
/// See [Tween] for a discussion on how to use interpolation objects.
class AppThemeDataTween extends Tween<AppThemeData> {
  /// Creates a [AppThemeData] tween.
  ///
  /// The [begin] and [end] properties must be non-null before the tween is
  /// first used, but the arguments can be null if the values are going to be
  /// filled in later.
  AppThemeDataTween({super.begin, super.end});

  // @override
  // AppThemeData lerp(double t) => AppThemeData.lerp(begin!, end!, t);
}



  
//  @override
//   AppThemeData lerpWith(AppThemeData other, double t) {
//     return AppThemeData(
//       themeName: themeName,
//       textColorScheme: textColorScheme.lerpWith(other.textColorScheme, t),
//       textStyle: textStyle.lerpWith(other.textStyle, t),
//       iconColorScheme: iconColorScheme.lerpWith(other.iconColorScheme, t),
//       borderColorScheme: borderColorScheme.lerpWith(other.borderColorScheme, t),
//       backgroundColorScheme:
//           backgroundColorScheme.lerpWith(other.backgroundColorScheme, t),
//       fillColorScheme: fillColorScheme.lerpWith(other.fillColorScheme, t),
//       surfaceColorScheme: surfaceColorScheme.lerpWith(other.surfaceColorScheme, t),
//       borderRadius: borderRadius.lerpWith(other.borderRadius, t),
//       spacing: spacing.lerpWith(other.spacing, t),
//       shadow: shadow.lerpWith(other.shadow, t),
//       brandColorScheme: brandColorScheme.lerpWith(other.brandColorScheme, t),
//       surfaceContainerColorScheme:
//           surfaceContainerColorScheme.lerpWith(other.surfaceContainerColorScheme, t),
//       otherColorsColorScheme:
//           otherColorsColorScheme.lerpWith(other.otherColorsColorScheme, t),
//       badgeColorScheme: badgeColorScheme.lerpWith(other.badgeColorScheme, t),
//     );
//   }