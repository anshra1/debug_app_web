import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/app_theme.dart';

/// Predefined divider variants for common use cases
///
/// **When to use which divider:**
///
/// • `standard()` - Default divider for general content separation (lists, forms, sections)
/// • `thin()` - Subtle separation within dense content (table rows, compact lists)
/// • `thick()` - Major section boundaries (between main app sections, page dividers)
/// • `subtle()` - Minimal visual separation (within cards, light content grouping)
/// • `accent()` - Important separations with brand emphasis (featured content, highlights)
/// • `spaced()` - Content blocks with breathing room (article sections, form groups)

class AppDividers extends StatelessWidget {
  // ─────────────────────────── core private ctor ────────────────────────────
  const AppDividers._({
    required this.height,
    required this.thickness,
    required this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  // ───────── public named factory constructors (= your variants) ────────────
  /// Default divider for general content separation (lists, forms, sections)
  factory AppDividers.standard(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.l,
      thickness: 1,
      color: t.borderColorScheme.primary,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Subtle separation within dense content (table rows, compact lists)
  factory AppDividers.thin(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.m,
      thickness: 0.5,
      color: t.borderColorScheme.secondary,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Major section boundaries (between main app sections, page dividers)
  factory AppDividers.thick(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.xl,
      thickness: 2,
      color: t.borderColorScheme.primary,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Minimal visual separation (within cards, light content grouping)
  factory AppDividers.subtle(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.l,
      thickness: 1,
      color: t.borderColorScheme.tertiary,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Important separations with brand emphasis (featured content, highlights)
  factory AppDividers.accent(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.l,
      thickness: 2,
      color: t.borderColorScheme.themeThick,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Content blocks with breathing room (article sections, form groups)
  factory AppDividers.spaced(
    BuildContext context, {
    double? indent,
    double? endIndent,
  }) {
    final t = AppTheme.of(context);
    return AppDividers._(
      height: t.spacing.l,
      thickness: 1,
      color: t.borderColorScheme.primary,
      margin: EdgeInsets.symmetric(vertical: t.spacing.xl),
      indent: indent,
      endIndent: endIndent,
    );
  }

  // ───────────────────────────── instance fields ────────────────────────────
  final double height;
  final double thickness;
  final Color color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;

  // ─────────────────────────────── build method ─────────────────────────────
  @override
  Widget build(BuildContext context) => Container(
        margin: margin,
        child: Divider(
          height: height,
          thickness: thickness,
          color: color,
          indent: indent,
          endIndent: endIndent,
        ),
      );
}
