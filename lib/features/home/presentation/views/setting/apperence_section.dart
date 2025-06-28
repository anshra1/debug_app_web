import 'package:flutter/material.dart';

/// Appearance Section - Single Responsibility: Theme mode selection
class AppearanceSection extends StatelessWidget {
  const AppearanceSection({
    required this.onThemeModeChanged,
    required this.selectedThemeMode,
    super.key,
  });

  final void Function(ThemeMode) onThemeModeChanged;
  final ThemeMode selectedThemeMode;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Appearance',
      child: Row(
        children: ThemeMode.values.map((mode) {
          final isSelected = mode == selectedThemeMode;
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ThemeModeCard(
              mode: mode,
              isSelected: isSelected,
              onTap: () => onThemeModeChanged(mode),
            ),
          );
        }).toList(),
      ),
    );
  }
}


/// Reusable settings section - Single Responsibility: Section layout
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.child,
    super.key,
    this.description,
  });

  final String title;
  final String? description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}


/// Theme Mode Card - Single Responsibility: Individual theme mode preview
class ThemeModeCard extends StatelessWidget {
  const ThemeModeCard({
    required this.mode,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ThemeMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  static const double cardWidth = 88;
  static const double cardHeight = 72;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: _getPreviewColor(mode, theme),
            ),
            child: isSelected
                ? const Stack(
                    children: [
                      Positioned(
                        top: 4,
                        left: 4,
                        child: CircleAvatar(
                          radius: 8,
                          child: Icon(Icons.check, size: 10),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          const SizedBox(height: 6),
          Text(
            _getModeLabel(mode),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPreviewColor(ThemeMode mode, ThemeData theme) {
    switch (mode) {
      case ThemeMode.light:
        return theme.colorScheme.surface;
      case ThemeMode.dark:
        return theme.colorScheme.inverseSurface;
      case ThemeMode.system:
        return theme.colorScheme.surfaceContainerHighest;
    }
  }

  String _getModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
