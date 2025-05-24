import 'package:debug_app_web/core/theme/theme_storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadSavedPreferences();
    // Use PlatformDispatcher instead of window
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        notifyListeners;
  }

  @override
  void dispose() {
    // Clean up the brightness listener
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
    super.dispose();
  }

  ThemeMode _currentMode = ThemeMode.system;

  ThemeMode get currentMode => _currentMode;

  bool get isDarkMode {
    if (_currentMode == ThemeMode.system) {
      // Use platformDispatcher instead of window
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      debugPrint('System brightness: $brightness');
      return brightness == Brightness.dark;
    }
    return _currentMode == ThemeMode.dark;
  }

  Future<void> _loadSavedPreferences() async {
    final savedMode = await ThemeStorage.loadThemePreferences();

    _currentMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedMode,
      orElse: () => ThemeMode.system,
    );

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_currentMode == mode) return;
    debugPrint('Setting theme mode to: ${mode.name}');
    _currentMode = mode;
    await ThemeStorage.saveThemeMode(mode.name);
    notifyListeners();
  }
}
