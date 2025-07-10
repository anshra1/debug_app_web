import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/app_theme.dart';

class AppHeaderWidget extends StatelessWidget {
  const AppHeaderWidget({
    required this.title,
    super.key,
    this.subtitle,
    this.spacing,
  });

  final String title;
  final String? subtitle;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textStyle.titleMedium.enhanced(
            context: context,
            color: theme.textColorScheme.primary,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: spacing ?? theme.spacing.xs),
          Text(
            subtitle!,
            style: theme.textStyle.bodyMedium.standard(
              context: context,
              color: theme.textColorScheme.secondary,
            ),
          ),
        ],
      ],
    );
  }
}
