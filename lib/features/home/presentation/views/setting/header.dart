
import 'package:debug_app_web/features/home/presentation/views/setting/apperence_section.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/apperence_state.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_theme_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Header - Single Responsibility: Page title and description
class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workspace',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Customize your workspace appearance and behavior',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
      ],
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

/// Localization Section - Single Responsibility: Language and regional settings
class LocalizationSection extends StatelessWidget {
  const LocalizationSection({super.key});

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
  ];

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Localization',
      child: Column(
        children: [
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) => previous.locale != current.locale,
            builder: (context, state) {
              return DropdownButtonFormField<Locale>(
                value: supportedLocales.contains(state.locale)
                    ? state.locale
                    : supportedLocales.first,
                decoration: InputDecoration(
                  labelText: 'Language',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: supportedLocales.map((locale) {
                  return DropdownMenuItem(
                    value: locale,
                    child: Text(_getLocaleDisplayName(locale)),
                  );
                }).toList(),
                onChanged: (locale) {
                  if (locale != null) context.read<AppearanceCubit>().setLocale(locale);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.dateFormat != current.dateFormat ||
                previous.timeFormat != current.timeFormat,
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: state.dateFormat,
                      decoration: InputDecoration(
                        labelText: 'Date Format',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'MM/dd/yyyy', child: Text('MM/DD/YYYY')),
                        DropdownMenuItem(value: 'dd/MM/yyyy', child: Text('DD/MM/YYYY')),
                        DropdownMenuItem(value: 'yyyy-MM-dd', child: Text('YYYY-MM-DD')),
                      ],
                      onChanged: (format) {
                        if (format != null)
                          context.read<AppearanceCubit>().setDateFormat(format);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: state.timeFormat,
                      decoration: InputDecoration(
                        labelText: 'Time Format',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: '12h', child: Text('12 Hour')),
                        DropdownMenuItem(value: '24h', child: Text('24 Hour')),
                      ],
                      onChanged: (format) {
                        if (format != null)
                          context.read<AppearanceCubit>().setTimeFormat(format);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _getLocaleDisplayName(Locale locale) {
    const localeNames = {
      'en': 'English (US)',
      'es': 'Español',
      'fr': 'Français',
      'de': 'Deutsch',
      'zh': '中文',
      'ja': '日本語',
    };
    return localeNames[locale.languageCode] ?? locale.languageCode.toUpperCase();
  }
}


/// Reusable radio group - Single Responsibility: Radio button group
class RadioGroup<T> extends StatelessWidget {
  const RadioGroup({
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  final String title;
  final T value;
  final List<RadioOption<T>> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: option.value,
                  groupValue: value,
                  onChanged: (newValue) {
                    if (newValue != null) onChanged(newValue);
                  },
                ),
                Text(option.label),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Radio option data class
class RadioOption<T> {
  const RadioOption(this.value, this.label);
  final T value;
  final String label;
}

/// Color setting component - Single Responsibility: Color display and interaction
class ColorSetting extends StatelessWidget {
  const ColorSetting({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
          const Icon(Icons.edit, size: 16),
        ],
      ),
    );
  }
}
