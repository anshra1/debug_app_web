// ignore_for_file: avoid_positional_boolean_parameters

import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static const String _modeKey = 'prefix}theme_mode';
 

  static Future<String> loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_modeKey) ?? 'system';
    return themeMode;
  }

  static Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode);
  }

  
}