import 'package:debug_app_web/core/theme/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final currentTheme = themeProvider.currentMode;
    final isLight = currentTheme == ThemeMode.light;

    void toggleTheme() {
      final newTheme = isLight ? ThemeMode.dark : ThemeMode.light;
      themeProvider.setThemeMode(newTheme);
    }

    return GestureDetector(
      onTap: toggleTheme,
      child: Container(
        width: 120,
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isLight ? Colors.grey.shade200 : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ), // pill shape
        ),
        child: Stack(
          children: [
            // Left icon (sun) and right icon (moon)
            Positioned(
              left: 8,
              top: 6,
              child: Icon(
                Icons.wb_sunny,
                color: isLight ? Colors.black : Colors.white,
              ),
            ),
            Positioned(
              right: 8,
              top: 6,
              child: Icon(
                Icons.nights_stay,
                color: isLight ? Colors.white : Colors.black,
              ),
            ),
            // Animated circular knob
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isLight ? Alignment.centerLeft : Alignment.centerRight,
              curve: Curves.easeInOut,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  isLight ? Icons.wb_sunny : Icons.nights_stay,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
