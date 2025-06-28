import 'package:debug_app_web/features/apperence/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/apperence/cubit/apperence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Complete AppFlowy Workspace Appearance UI Replica
/// This recreates the exact UI structure and styling of AppFlowy's workspace settings
class AppFlowyWorkspaceUI extends StatelessWidget {
  const AppFlowyWorkspaceUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppFlowy Workspace Settings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WorkspaceSettingsPage(),
    );
  }
}

class WorkspaceSettingsPage extends StatelessWidget {
  const WorkspaceSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppearanceCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workspace Settings'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const SettingsWorkspaceView(),
      ),
    );
  }
}

// Main Settings Workspace View - Exact replica of AppFlowy
class SettingsWorkspaceView extends StatelessWidget {
  const SettingsWorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Workspace',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customize your workspace',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 32),

          // Appearance Section
          const AppearanceSection(),
          const SizedBox(height: 32),

          // Theme Section  
          const ThemeSection(),
          const SizedBox(height: 32),

          // Font Section
          const FontSection(),
          const SizedBox(height: 32),

          // Layout Direction Section
          const LayoutDirectionSection(),
          const SizedBox(height: 32),

          // Date & Time Section
          const DateTimeSection(),
          const SizedBox(height: 32),

          // Language Section
          const LanguageSection(),
        ],
      ),
    );
  }
}

// Appearance Section with Theme Mode Cards - Exact AppFlowy style
class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<AppearanceCubit, AppearanceState>(
          builder: (context, state) {
            return Row(
              children: ThemeMode.values.map((themeMode) {
                final isSelected = state.themeMode == themeMode;
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => context.read<AppearanceCubit>().setThemeMode(themeMode),
                    child: Column(
                      children: [
                        Container(
                          width: 88,
                          height: 72,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: _getThemePreviewColor(themeMode),
                          ),
                          child: isSelected
                              ? Stack(
                                  children: [
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _getThemeModeLabel(themeMode),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Color _getThemePreviewColor(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Colors.grey[100]!;
      case ThemeMode.dark:
        return Colors.grey[800]!;
      case ThemeMode.system:
        return Colors.grey[400]!;
    }
  }

  String _getThemeModeLabel(ThemeMode mode) {
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

// Theme Section - Exact AppFlowy theme dropdown with actions
class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select a theme for your workspace or upload a custom theme',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        const ThemeDropdownWidget(),
        const SizedBox(height: 16),
        const ColorSettingsRow(),
      ],
    );
  }
}

class ThemeDropdownWidget extends StatelessWidget {
  const ThemeDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppearanceCubit, AppearanceState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: state.themeMode.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: ['Default', 'Dark', 'Dandelion', 'Lavender'].map((theme) {
                  return DropdownMenuItem(
                    value: theme,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getThemeColor(theme),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(theme),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<AppearanceCubit>().setTheme(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.folder_outlined),
              onPressed: () {
                // Upload theme functionality
              },
              tooltip: 'Upload custom theme',
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<AppearanceCubit>().resetThemeMode();
              },
              tooltip: 'Reset to default',
            ),
          ],
        );
      },
    );
  }

  Color _getThemeColor(String theme) {
    switch (theme) {
      case 'Default':
        return Colors.blue;
      case 'Dark':
        return Colors.blueGrey;
      case 'Dandelion':
        return Colors.amber;
      case 'Lavender':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}

class ColorSettingsRow extends StatelessWidget {
  const ColorSettingsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildColorSetting(context, 'Cursor color in editor', Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _buildColorSetting(context, 'Selection color in editor', Colors.blue.withOpacity(0.3))),
      ],
    );
  }

  Widget _buildColorSetting(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// Remaining sections with placeholder styling
class FontSection extends StatelessWidget {
  const FontSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workspace font',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Font Family Selector'),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        Text(
          'Text direction',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Text Direction Settings (LTR/RTL/Auto)'),
        const SizedBox(height: 8),
        _buildPlaceholderSetting(context, 'Enable RTL toolbar items toggle'),
      ],
    );
  }

  Widget _buildPlaceholderSetting(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label),
    );
  }
}

class LayoutDirectionSection extends StatelessWidget {
  const LayoutDirectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layout direction',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Layout Direction Radio Selection (LTR/RTL)'),
      ],
    );
  }

  Widget _buildPlaceholderSetting(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label),
    );
  }
}

class DateTimeSection extends StatelessWidget {
  const DateTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Date/Time Format Preview'),
        const SizedBox(height: 8),
        _buildPlaceholderSetting(context, '24-hour time toggle'),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Date Format Dropdown (US/ISO/Local/etc)'),
      ],
    );
  }

  Widget _buildPlaceholderSetting(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label),
    );
  }
}

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _buildPlaceholderSetting(context, 'Language Dropdown (English, Spanish, French, etc)'),
      ],
    );
  }

  Widget _buildPlaceholderSetting(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label),
    );
  }
}

