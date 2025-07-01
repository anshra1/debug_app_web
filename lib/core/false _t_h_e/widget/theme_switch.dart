import 'package:debug_app_web/core/false%20_t_h_e/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
 

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Theme Mode Selection
        ListTile(
          title: const Text('Theme Mode'),
          subtitle: Text(themeProvider.currentMode.name.toUpperCase()),
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System'),
          value: ThemeMode.system,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Light'),
          value: ThemeMode.light,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark'),
          value: ThemeMode.dark,
          groupValue: themeProvider.currentMode,
          onChanged: (mode) {
            if (mode != null) themeProvider.setThemeMode(mode);
          },
        ),
      ],
    );
  }
}
