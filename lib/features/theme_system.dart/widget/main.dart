import 'package:debug_app_web/features/theme_system.dart/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/apperence_state.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_default_theme.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_theme_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

// Replace with your actual imports:
// import 'package:debug_app_web/theme_system.dart/cubit/apperence_state.dart';
// import 'package:debug_app_web/theme_system.dart/cubit/appearance_cubit.dart';
// import 'package:debug_app_web/theme_system.dart/models/app_theme_color_set.dart';

void main() {
  runApp(BlocProvider(create: (context) => AppearanceCubit(), child: const WorkspaceApp()));
}

/// Main App - Single Responsibility: App setup and theming
class WorkspaceApp extends StatelessWidget {
  const WorkspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      data: AppThemeSet(
        isInbuilt: true,
        themeName: 'default',
        lightThemeColors: AppDefaultTheme().light(),
        darkThemeColors: AppDefaultTheme().dark(),
      ).getLightTheme(),
      child: BlocProvider(
        create: (context) => AppearanceCubit(),
        child: MaterialApp(
          title: 'AppFlowy Workspace Settings',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          themeMode: context.read<AppearanceCubit>().state.themeMode,
          home: const WorkspaceSettingsPage(),
         
        ),
      ),
    );
  }
}

/// Main Settings Page - Single Responsibility: Page structure
class WorkspaceSettingsPage extends StatefulWidget {
  const WorkspaceSettingsPage({super.key});

  @override
  State<WorkspaceSettingsPage> createState() => _WorkspaceSettingsPageState();
}

class _WorkspaceSettingsPageState extends State<WorkspaceSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColorScheme.primary,
      appBar: AppBar(
        title: const Text('Workspace Settings'),
        backgroundColor: theme.backgroundColorScheme.primary,
      ),
      body: const WorkspaceSettingsView(),
    );
  }
}

/// Main Settings View - Single Responsibility: Settings layout and error handling
class WorkspaceSettingsView extends StatelessWidget {
  const WorkspaceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppearanceCubit, AppearanceState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WorkspaceHeader(),
            const SizedBox(height: 32),
            AppearanceSection(
              onThemeModeChanged: (mode) {
                context.read<AppearanceCubit>().setThemeMode(mode);
              },
              selectedThemeMode: context.read<AppearanceCubit>().state.themeMode,
            ),
            const SizedBox(height: 32),
            const ThemeSection(),
            const SizedBox(height: 32),
            const FontSection(),
            const SizedBox(height: 32),
            const LayoutSection(),
            const SizedBox(height: 32),
            const LocalizationSection(),
            const SizedBox(height: 32),
            const DocumentSection(),
          ],
        ),
      ),
    );
  }
}

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

/// Theme Section - Single Responsibility: Theme selection and management
class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Theme',
      description: 'Select a theme for your workspace or upload a custom theme',
      child: Column(
        children: [
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.appThemeSet != current.appThemeSet ||
                previous.availableThemes != current.availableThemes,
            builder: (context, state) {
              return DropdownButtonFormField<String>(
                value: state.appThemeSet.themeName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: state.availableThemes
                    .map<DropdownMenuItem<String>>((AppThemeSet theme) {
                  return DropdownMenuItem(
                    value: theme.themeName,
                    child: Row(
                      children: [
                        ThemeColorIndicator(themeSet: theme),
                        const SizedBox(width: 8),
                        Expanded(child: Text(theme.themeName)),
                        if (!theme.isInbuilt) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.folder,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (themeName) {
                  if (themeName != null) {
                    context.read<AppearanceCubit>().setTheme(themeName);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) => previous.isLoading != current.isLoading,
            builder: (context, state) {
              return Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => context.read<AppearanceCubit>().uploadTheme(),
                    icon: const Icon(Icons.upload_file, size: 16),
                    label: const Text('Upload Theme'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => context.read<AppearanceCubit>().resetThemeMode(),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Reset'),
                  ),
                  if (state.isLoading) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
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

/// Font Section - Single Responsibility: Font family selection
class FontSection extends StatelessWidget {
  const FontSection({super.key});

  static const List<String> fontOptions = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Poppins',
    'Inter',
    'Source Sans Pro',
    'Ubuntu',
  ];

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Font',
      child: BlocBuilder<AppearanceCubit, AppearanceState>(
        buildWhen: (previous, current) => previous.fontFamily != current.fontFamily,
        builder: (context, state) {
          return DropdownButtonFormField<String>(
            value: fontOptions.contains(state.fontFamily)
                ? state.fontFamily
                : fontOptions.first,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: fontOptions.map((font) {
              return DropdownMenuItem(
                value: font,
                child: Text(font, style: TextStyle(fontFamily: font)),
              );
            }).toList(),
            onChanged: (font) {
              if (font != null) context.read<AppearanceCubit>().setFontFamily(font);
            },
          );
        },
      ),
    );
  }
}

/// Layout Section - Single Responsibility: Layout and text direction settings
class LayoutSection extends StatelessWidget {
  const LayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Layout & Text Direction',
      child: Column(
        children: [
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.layoutDirection != current.layoutDirection,
            builder: (context, state) {
              return RadioGroup<LayoutDirection>(
                title: 'Layout Direction',
                value: state.layoutDirection,
                options: const [
                  RadioOption(LayoutDirection.ltr, 'Left to Right'),
                  RadioOption(LayoutDirection.rtl, 'Right to Left'),
                ],
                onChanged: (direction) =>
                    context.read<AppearanceCubit>().setLayoutDirection(direction),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.textDirection != current.textDirection,
            builder: (context, state) {
              return RadioGroup<TextDirection>(
                title: 'Text Direction',
                value: state.textDirection,
                options: const [
                  RadioOption(TextDirection.ltr, 'Left to Right'),
                  RadioOption(TextDirection.rtl, 'Right to Left'),
                ],
                onChanged: (direction) =>
                    context.read<AppearanceCubit>().setTextDirection(direction),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.enableRtlToolbarItems != current.enableRtlToolbarItems,
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Enable RTL Toolbar Items'),
                subtitle: const Text('Show right-to-left toolbar items'),
                value: state.enableRtlToolbarItems,
                onChanged: (value) =>
                    context.read<AppearanceCubit>().setEnableRTLToolbarItems(value),
                contentPadding: EdgeInsets.zero,
              );
            },
          ),
        ],
      ),
    );
  }
}

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

/// Document Section - Single Responsibility: Document-specific settings
class DocumentSection extends StatelessWidget {
  const DocumentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Document',
      child: Column(
        children: [
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.documentCursorColor != current.documentCursorColor ||
                previous.documentSelectionColor != current.documentSelectionColor,
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: ColorSetting(
                      label: 'Cursor Color',
                      color: state.documentCursorColor ??
                          Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ColorSetting(
                      label: 'Selection Color',
                      color: state.documentSelectionColor ??
                          Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AppearanceCubit, AppearanceState>(
            buildWhen: (previous, current) =>
                previous.textScaleFactor != current.textScaleFactor,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Text Scale', style: Theme.of(context).textTheme.titleSmall),
                      Text(
                        '${((state.textScaleFactor ?? 1.0) * 100).round()}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Slider(
                    value: state.textScaleFactor.clamp(0.8, 1.5),
                    min: 0.8,
                    max: 1.5,
                    divisions: 7,
                    onChanged: (value) =>
                        context.read<AppearanceCubit>().setTextScaleFactor(value),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE COMPONENTS - Design System Following Your Architecture Principles
// =============================================================================

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
