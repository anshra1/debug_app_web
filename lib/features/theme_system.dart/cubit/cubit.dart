// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:debug_app_web/theme_system.dart/cubit/apperence_state.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum ThemeMode { light, dark, system }

// enum LayoutDirection { ltr, rtl }

// enum TextDirection { ltr, rtl, auto }

// class AppearanceCubit extends Cubit<AppearanceState> {
//   AppearanceCubit() : super(AppearanceState.initial()) {
//     _loadSettings();
//     _loadThemes();
//   }

//   static const String _settingsKey = 'appearance_settings';
//   static const String _themesDirectory = 'themes';

//   // ============================================================================
//   // THEME MANAGEMENT
//   // ============================================================================

//   /// Load and parse JSON theme from file
//   Future<void> loadThemeFromFile(String filePath) async {
//     try {
//       emit(state.copyWith(isLoading: true, errorMessage: null));

//       final file = File(filePath);
//       //
//       // ignore: avoid_slow_async_io
//       if (!await file.exists()) {
//         throw Exception('Theme file not found: $filePath');
//       }

//       final jsonString = await file.readAsString();
//       final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

//       final theme = AppThemeData.fromJson(jsonData);

//       // Validate theme structure
//       _validateTheme(theme);

//       // Add to available themes if not already present
//       final updatedThemes = List<AppThemeData>.from(state.availableThemes);
//       final existingIndex = updatedThemes.indexWhere((t) => t.name == theme.name);

//       if (existingIndex >= 0) {
//         updatedThemes[existingIndex] = theme;
//       } else {
//         updatedThemes.add(theme);
//       }

//       emit(
//         state.copyWith(
//           currentTheme: theme,
//           availableThemes: updatedThemes,
//           isLoading: false,
//         ),
//       );

//       await _saveSettings();
//     } on Exception catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: 'Failed to load theme: $e',
//         ),
//       );
//     }
//   }

//   /// Load theme from JSON string
//   Future<void> loadThemeFromJson(String jsonString) async {
//     try {
//       emit(state.copyWith(isLoading: true, errorMessage: null));

//       final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
//       final theme = AppThemeData.fromJson(jsonData);

//       _validateTheme(theme);

//       final updatedThemes = List<AppThemeData>.from(state.availableThemes);
//       final existingIndex = updatedThemes.indexWhere((t) => t.name == theme.name);

//       if (existingIndex >= 0) {
//         updatedThemes[existingIndex] = theme;
//       } else {
//         updatedThemes.add(theme);
//       }

//       emit(
//         state.copyWith(
//           currentTheme: theme,
//           availableThemes: updatedThemes,
//           isLoading: false,
//         ),
//       );

//       await _saveSettings();
//     } on Exception catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: 'Failed to load theme from JSON: $e',
//         ),
//       );
//     }
//   }

//   /// Set current theme by name
//   Future<void> setTheme(String themeName) async {
//     try {
//       final theme = state.availableThemes.firstWhere(
//         (t) => t.name == themeName,
//         orElse: () => throw Exception('Theme not found: $themeName'),
//       );

//       emit(state.copyWith(currentTheme: theme));
//       await _saveSettings();
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to set theme: $e'));
//     }
//   }

//   /// Upload theme from file picker
//   Future<void> uploadTheme() async {
//     try {
//       emit(state.copyWith(isLoading: true, errorMessage: null));

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['json'],
//         dialogTitle: 'Select Theme File',
//       );

//       if (result != null && result.files.isNotEmpty) {
//         final filePath = result.files.first.path!;
//         await loadThemeFromFile(filePath);

//         // Save theme to themes directory
//         await _saveThemeToDirectory(state.currentTheme);
//       }
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: 'Failed to upload theme: $e',
//         ),
//       );
//     }
//   }

//   /// Export current theme to JSON file
//   Future<void> exportTheme() async {
//     try {
//       final result = await FilePicker.platform.saveFile(
//         dialogTitle: 'Save Theme',
//         fileName: '${state.currentTheme.name}_theme.json',
//         allowedExtensions: ['json'],
//       );

//       if (result != null) {
//         final jsonString = jsonEncode(state.currentTheme.toJson());
//         final file = File(result);
//         await file.writeAsString(jsonString);
//       }
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to export theme: $e'));
//     }
//   }

//   /// Delete theme by name
//   Future<void> deleteTheme(String themeName) async {
//     try {
//       if (state.currentTheme.name == themeName) {
//         throw Exception('Cannot delete current theme');
//       }

//       final updatedThemes =
//           state.availableThemes.where((t) => t.name != themeName).toList();

//       emit(state.copyWith(availableThemes: updatedThemes));
//       await _saveSettings();

//       // Delete theme file from directory
//       await _deleteThemeFromDirectory(themeName);
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to delete theme: $e'));
//     }
//   }

//   // ============================================================================
//   // THEME MODE MANAGEMENT
//   // ============================================================================

//   void setThemeMode(ThemeMode themeMode) {
//     emit(state.copyWith(themeMode: themeMode));
//     _saveSettings();
//   }

//   void toggleThemeMode() {
//     final newMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     setThemeMode(newMode);
//   }

//   void resetThemeMode() {
//     setThemeMode(ThemeMode.system);
//   }

//   // ============================================================================
//   // FONT MANAGEMENT
//   // ============================================================================

//   void setFontFamily(String fontFamily) {
//     emit(state.copyWith(fontFamily: fontFamily));
//     _saveSettings();
//   }

//   void resetFontFamily() {
//     setFontFamily('Roboto');
//   }

//   // ============================================================================
//   // LAYOUT AND TEXT DIRECTION
//   // ============================================================================

//   void setLayoutDirection(LayoutDirection layoutDirection) {
//     emit(state.copyWith(layoutDirection: layoutDirection));
//     _saveSettings();
//   }

//   void setTextDirection(TextDirection textDirection) {
//     emit(state.copyWith(textDirection: textDirection));
//     _saveSettings();
//   }

//   void setEnableRTLToolbarItems(bool value) {
//     emit(state.copyWith(enableRtlToolbarItems: value));
//     _saveSettings();
//   }

//   // ============================================================================
//   // LOCALE MANAGEMENT
//   // ============================================================================

//   void setLocale(Locale locale) {
//     emit(state.copyWith(locale: locale));
//     _saveSettings();
//   }

//   // ============================================================================
//   // DOCUMENT SETTINGS
//   // ============================================================================

//   void setDocumentCursorColor(Color? color) {
//     emit(state.copyWith(documentCursorColor: color));
//     _saveSettings();
//   }

//   void resetDocumentCursorColor() {
//     setDocumentCursorColor(null);
//   }

//   void setDocumentSelectionColor(Color? color) {
//     emit(state.copyWith(documentSelectionColor: color));
//     _saveSettings();
//   }

//   void resetDocumentSelectionColor() {
//     setDocumentSelectionColor(null);
//   }

//   // ============================================================================
//   // TEXT SCALE FACTOR
//   // ============================================================================

//   void setTextScaleFactor(double textScaleFactor) {
//     final clampedFactor = textScaleFactor.clamp(0.7, 1.0);
//     emit(state.copyWith(textScaleFactor: clampedFactor));
//     _saveSettings();
//   }

//   // ============================================================================
//   // DATE/TIME FORMATS
//   // ============================================================================

//   void setDateFormat(String dateFormat) {
//     emit(state.copyWith(dateFormat: dateFormat));
//     _saveSettings();
//   }

//   void setTimeFormat(String timeFormat) {
//     emit(state.copyWith(timeFormat: timeFormat));
//     _saveSettings();
//   }

//   void setTimezoneId(String timezoneId) {
//     emit(state.copyWith(timezoneId: timezoneId));
//     _saveSettings();
//   }

//   // ============================================================================
//   // MENU STATE
//   // ============================================================================

//   void setMenuCollapsed(bool collapsed) {
//     emit(state.copyWith(isMenuCollapsed: collapsed));
//     _saveSettings();
//   }

//   void setMenuOffset(double offset) {
//     emit(state.copyWith(menuOffset: offset));
//     _saveSettings();
//   }

//   // ============================================================================
//   // KEY-VALUE STORAGE
//   // ============================================================================

//   void setKeyValue(String key, String? value) {
//     if (key.isEmpty) return;

//     final prefs = SharedPreferences.getInstance();
//     prefs.then((prefs) {
//       if (value == null) {
//         prefs.remove(key);
//       } else {
//         prefs.setString(key, value);
//       }
//     });
//   }

//   Future<String?> getValue(String key) async {
//     if (key.isEmpty) return null;

//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key);
//   }

//   // ============================================================================
//   // PRIVATE METHODS
//   // ============================================================================

//   Future<void> _loadSettings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final settingsJson = prefs.getString(_settingsKey);

//       if (settingsJson != null) {
//         final settings = jsonDecode(settingsJson) as Map<String, dynamic>;

//         // Load theme mode
//         final themeModeString = settings['themeMode'] as String?;
//         if (themeModeString != null) {
//           final themeMode = ThemeMode.values.firstWhere(
//             (e) => e.name == themeModeString,
//             orElse: () => ThemeMode.system,
//           );
//           emit(state.copyWith(themeMode: themeMode));
//         }

//         // Load other settings
//         emit(
//           state.copyWith(
//             fontFamily: settings['fontFamily'] as String? ?? 'Roboto',
//             layoutDirection: LayoutDirection.values.firstWhere(
//               (e) => e.name == (settings['layoutDirection'] as String? ?? 'ltr'),
//               orElse: () => LayoutDirection.ltr,
//             ),
//             textDirection: TextDirection.values.firstWhere(
//               (e) => e.name == (settings['textDirection'] as String? ?? 'ltr'),
//               orElse: () => TextDirection.ltr,
//             ),
//             enableRtlToolbarItems: settings['enableRtlToolbarItems'] as bool? ?? false,
//             locale: Locale(
//               settings['localeLanguageCode'] as String? ?? 'en',
//               settings['localeCountryCode'] as String? ?? 'US',
//             ),
//             isMenuCollapsed: settings['isMenuCollapsed'] as bool? ?? false,
//             menuOffset: (settings['menuOffset'] as num?)?.toDouble() ?? 0.0,
//             dateFormat: settings['dateFormat'] as String? ?? 'MM/dd/yyyy',
//             timeFormat: settings['timeFormat'] as String? ?? '12h',
//             timezoneId: settings['timezoneId'] as String? ?? 'UTC',
//             documentCursorColor: settings['documentCursorColor'] != null
//                 ? Color(int.parse(settings['documentCursorColor'] as String))
//                 : null,
//             documentSelectionColor: settings['documentSelectionColor'] != null
//                 ? Color(int.parse(settings['documentSelectionColor'] as String))
//                 : null,
//             textScaleFactor: (settings['textScaleFactor'] as num?)?.toDouble() ?? 1.0,
//           ),
//         );
//       }
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to load settings: $e'));
//     }
//   }

//   Future<void> _saveSettings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final settings = {
//         'themeMode': state.themeMode.name,
//         'fontFamily': state.fontFamily,
//         'layoutDirection': state.layoutDirection.name,
//         'textDirection': state.textDirection.name,
//         'enableRtlToolbarItems': state.enableRtlToolbarItems,
//         'localeLanguageCode': state.locale.languageCode,
//         'localeCountryCode': state.locale.countryCode,
//         'isMenuCollapsed': state.isMenuCollapsed,
//         'menuOffset': state.menuOffset,
//         'dateFormat': state.dateFormat,
//         'timeFormat': state.timeFormat,
//         'timezoneId': state.timezoneId,
//         'documentCursorColor': state.documentCursorColor?.value.toString(),
//         'documentSelectionColor': state.documentSelectionColor?.value.toString(),
//         'textScaleFactor': state.textScaleFactor,
//         'currentThemeName': state.currentTheme.name,
//       };

//       await prefs.setString(_settingsKey, jsonEncode(settings));
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to save settings: $e'));
//     }
//   }

//   Future<void> _loadThemes() async {
//     try {
//       final themesDirectory = await _getThemesDirectory();
//       if (!await themesDirectory.exists()) {
//         await themesDirectory.create(recursive: true);
//         return;
//       }

//       final themeFiles = themesDirectory
//           .listSync()
//           .where((entity) => entity is File && entity.path.endsWith('.json'))
//           .cast<File>();

//       final themes = <AppThemeData>[];

//       for (final file in themeFiles) {
//         try {
//           final jsonString = await file.readAsString();
//           final theme = AppThemeData.fromJson(jsonDecode(jsonString));
//           themes.add(theme);
//         } catch (e) {
//           print('Failed to load theme from ${file.path}: $e');
//         }
//       }

//       emit(state.copyWith(availableThemes: themes));

//       // Load current theme if specified
//       final prefs = await SharedPreferences.getInstance();
//       final currentThemeName = prefs.getString('currentThemeName');
//       if (currentThemeName != null) {
//         final currentTheme = themes.firstWhere(
//           (t) => t.name == currentThemeName,
//           orElse: () => state.currentTheme,
//         );
//         emit(state.copyWith(currentTheme: currentTheme));
//       }
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to load themes: $e'));
//     }
//   }

//   Future<void> _saveThemeToDirectory(JsonThemeData theme) async {
//     try {
//       final themesDirectory = await _getThemesDirectory();
//       final themeFile = File('${themesDirectory.path}/${theme.name}_theme.json');
//       await themeFile.writeAsString(jsonEncode(theme.toJson()));
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to save theme: $e'));
//     }
//   }

//   Future<void> _deleteThemeFromDirectory(String themeName) async {
//     try {
//       final themesDirectory = await _getThemesDirectory();
//       final themeFile = File('${themesDirectory.path}/${themeName}_theme.json');
//       if (await themeFile.exists()) {
//         await themeFile.delete();
//       }
//     } catch (e) {
//       emit(state.copyWith(errorMessage: 'Failed to delete theme file: $e'));
//     }
//   }

//   Future<Directory> _getThemesDirectory() async {
//     final appDir = await getApplicationDocumentsDirectory();
//     return Directory('${appDir.path}/$_themesDirectory');
//   }

//   void _validateTheme(AppThemeData theme) {
//     // Basic validation - you can add more comprehensive validation here
//     if (theme.name.isEmpty) {
//       throw Exception('Theme name cannot be empty');
//     }

//     if (theme.version.isEmpty) {
//       throw Exception('Theme version cannot be empty');
//     }

//     // Validate color schemes
//     _validateColorScheme(theme.light, 'light');
//     _validateColorScheme(theme.dark, 'dark');
//   }

//   void _validateColorScheme(AppColorScheme scheme, String mode) {
//     // Validate that all required colors are present and valid hex colors
//     final colors = [
//       scheme.text.primary,
//       scheme.text.secondary,
//       scheme.text.tertiary,
//       scheme.text.quaternary,
//       scheme.text.onFill,
//       scheme.text.action,
//       scheme.text.actionHover,
//       scheme.text.info,
//       scheme.text.infoHover,
//       scheme.text.success,
//       scheme.text.successHover,
//       scheme.text.warning,
//       scheme.text.warningHover,
//       scheme.text.error,
//       scheme.text.errorHover,
//       scheme.text.featured,
//       scheme.text.featuredHover,
//     ];

//     for (final color in colors) {
//       if (!_isValidHexColor(color)) {
//         throw Exception('Invalid hex color in $mode theme: $color');
//       }
//     }
//   }

//   bool _isValidHexColor(String color) {
//     return RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$').hasMatch(color);
//   }
// }
