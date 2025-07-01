import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:flutter/material.dart';

/// Header - Single Responsibility: Page title and description
class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppHeaderWidget(
      title: 'Workspace',
      subtitle: 'Customize your workspace appearance and behavior',
    );
  }
}

/// Theme Color Indicator - Single Responsibility: Show theme's primary color
class ThemeColorIndicator extends StatelessWidget {
  const ThemeColorIndicator({required this.themeSet, super.key});

  final AppThemeSet themeSet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get primary color from your AppThemeSet
    final primaryColor = isDark
        ? themeSet.getDarkTheme().brandColorScheme.amber ?? theme.colorScheme.primary
        : themeSet.getLightTheme().brandColorScheme.amber ?? theme.colorScheme.primary;

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.outline),
      ),
    );
  }
}

/// Layout Section - Single Responsibility: Layout and text direction settings
