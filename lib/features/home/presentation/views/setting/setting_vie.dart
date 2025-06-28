import 'package:debug_app_web/features/home/presentation/views/setting/apperence_section.dart';
import 'package:debug_app_web/features/home/presentation/views/setting/header.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/apperence_state.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_theme_set.dart';
import 'package:debug_app_web/features/theme_system.dart/widget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
