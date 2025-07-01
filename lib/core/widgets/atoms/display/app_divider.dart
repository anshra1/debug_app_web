import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  final double? height;
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      margin: margin,
      child: Divider(
        height: height ?? theme.spacing.l,
        thickness: thickness ?? 1,
        color: color ?? theme.borderColorScheme.primary,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

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
class AppDividers {
  const AppDividers._();

  /// Standard divider with default spacing
  /// Use for: General content separation, list items, form sections
  static Widget standard(BuildContext context) {
    return const AppDivider();
  }

  /// Thin divider with minimal spacing
  /// Use for: Dense content, table rows, compact lists, subtle grouping
  static Widget thin(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppDivider(
      height: theme.spacing.m,
      thickness: 0.5,
      color: theme.borderColorScheme.secondary,
    );
  }

  /// Thick divider for major sections
  /// Use for: Main section boundaries, page separators, major content blocks
  static Widget thick(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppDivider(
      height: theme.spacing.xl,
      thickness: 2,
      color: theme.borderColorScheme.primary,
    );
  }

  /// Subtle divider with light color
  /// Use for: Within cards, light content grouping, minimal visual separation
  static Widget subtle(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppDivider(
      color: theme.borderColorScheme.tertiary,
    );
  }

  /// Accent divider using theme color
  /// Use for: Featured content, highlights, important separations with brand emphasis
  static Widget accent(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppDivider(
      thickness: 2,
      color: theme.borderColorScheme.themeThick,
    );
  }

  /// Spaced divider with extra margin
  /// Use for: Content blocks needing breathing room, article sections, form groups
  static Widget spaced(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppDivider(
      margin: EdgeInsets.symmetric(vertical: theme.spacing.xl),
    );
  }
}
