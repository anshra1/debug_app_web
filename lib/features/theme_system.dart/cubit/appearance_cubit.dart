// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/decoders/theme_decoder.dart';
import 'package:debug_app_web/core/manager/file_manager/service/file_manager_service.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/apperence_state.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_theme_set.dart';
import 'package:debug_app_web/features/theme_system.dart/utils/inbuilt_themes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_ui_widgets/theme/definition/theme_data.dart';

class AppearanceCubit extends Cubit<AppearanceState> {
  AppearanceCubit() : super(AppearanceState.initial()) {
    _setupPlatformBrightnessListener();
  }

  // Constants
  static const String _settingsKey = 'appearance_settings';
  static const String _themesDirectory = 'themes';
  static const String _themeFileExtension = '.theme_design';
 

  late final FileManagerService fileManager;

  String? _savedThemeName;

  Timer? _saveTimer;

  void _saveSettingsDebounced() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), _saveSettings);
  }

  // Platform brightness listener setup
  void _setupPlatformBrightnessListener() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      // Only notify if we're in system mode
      if (state.themeMode == ThemeMode.system) {
        emit(state.copyWith()); // Trigger rebuild to check system brightness
      }
    };
  }

  @override
  Future<void> close() {
    // Clean up the brightness listener
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
    _saveTimer?.cancel();
    return super.close();
  }

  // System brightness detection
  bool get isDarkMode {
    switch (state.themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark;
    }
  }

  // Get current theme data based on mode
  AppThemeData get currentThemeData {
    return isDarkMode
        ? state.appThemeSet.getDarkTheme()
        : state.appThemeSet.getLightTheme();
  }

  Future<void> init() async {
    fileManager = FileManagerService(
      lastBasePath: _themesDirectory,
    );
    await fileManager.initialize();
    await _loadSettings();
    await _loadThemes();
  }

  // Theme Management Methods

  Future<void> setTheme(String themeName) async {
    if (themeName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Theme name cannot be empty'));
      return;
    }

    if (themeName.length > 50) {
      emit(state.copyWith(errorMessage: 'Theme name too long'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final selectedTheme = state.availableThemes.firstWhere(
        (theme) => theme.themeName == themeName,
        orElse: () => throw Exception('Theme not found: $themeName'),
      );

      await _saveSettings();

      emit(
        state.copyWith(
          appThemeSet: selectedTheme,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } on FileSystemException catch (e) {
      emit(state.copyWith(errorMessage: 'Cannot access theme files: ${e.message}'));
    } on FormatException catch (e) {
      emit(state.copyWith(errorMessage: 'Invalid theme format: ${e.message}'));
    } on Exception catch (_) {
      emit(state.copyWith(errorMessage: 'Theme operation failed. Please try again.'));
    }
  }

  Future<void> uploadTheme() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Pick a directory instead of individual files
      final directoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Theme Directory (.theme_design)',
      );

      if (directoryPath == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      // Validate it's a .theme_design directory
      if (!directoryPath.endsWith(_themeFileExtension)) {
        throw Exception('Please select a $_themeFileExtension directory');
      }

      await _loadThemeFromFile(directoryPath);

      emit(state.copyWith(isLoading: false));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to upload theme: $e',
        ),
      );
    }
  }

  Future<void> deleteTheme(String themeName) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Check if it's an inbuilt theme (shouldn't be deleted)
      final theme = state.availableThemes.firstWhere(
        (theme) => theme.themeName == themeName,
        orElse: () => throw Exception('Theme not found: $themeName'),
      );

      if (theme.isInbuilt) {
        throw Exception('Cannot delete inbuilt theme: $themeName');
      }

      // Find the theme directory
      if (!fileManager.isInitialized) {
        throw Exception('File manager not initialized');
      }

      final themeDirectoryName = '$themeName.theme_design';
      final themeDirectoryPath = path.join(fileManager.currentPath, themeDirectoryName);
      final themeDirectory = Directory(themeDirectoryPath);

      if (!themeDirectory.existsSync()) {
        throw Exception('Theme directory not found: $themeDirectoryName');
      }

      // Delete the entire theme directory
      await themeDirectory.delete(recursive: true);

      // Reload themes to update the list
      await _loadThemes();

      emit(state.copyWith(isLoading: false));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete theme: $e',
        ),
      );
    }
  }

  // Theme Mode Management Methods
  Future<void> setThemeMode(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    await _saveSettings();
  }

   void toggleThemeMode() {
    final currentMode = state.themeMode;
    setThemeMode(currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  void resetThemeMode() {
    emit(state.copyWith(themeMode: ThemeMode.light));
    _saveSettingsDebounced(); // Save the preference
  }

  // Font Management Methods
  void setFontFamily(String fontFamily) {
    emit(state.copyWith(fontFamily: fontFamily));
    _saveSettingsDebounced(); // Save the preference
  }

  void resetFontFamily() {
    emit(state.copyWith(fontFamily: ''));
    _saveSettingsDebounced(); // Save the preference
  }

  // Layout and Text Direction Methods
  void setLayoutDirection(LayoutDirection layoutDirection) {}
  void setTextDirection(TextDirection textDirection) {}

  Future<void> setEnableRTLToolbarItems(bool value) async {}

  // Locale Management Methods
  void setLocale(Locale locale) {}

  // Text Scale Factor Methods
  void setTextScaleFactor(double textScaleFactor) {}

  // Date/Time Format Methods
  void setDateFormat(String dateFormat) {}
  void setTimeFormat(String timeFormat) {}
  void setTimezoneId(String timezoneId) {}

  // Menu State Methods
  void setMenuCollapsed(bool collapsed) {}
  void setMenuOffset(double offset) {}

  // Private Helper Methods
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);

      if (settingsJson != null) {
        final settings = jsonDecode(settingsJson) as Map<String, dynamic>;

        // Load theme mode
        final themeModeString = settings['themeMode'] as String?;
        if (themeModeString != null) {
          final themeMode = ThemeMode.values.firstWhere(
            (e) => e.name == themeModeString,
            orElse: () => ThemeMode.system,
          );
          emit(state.copyWith(themeMode: themeMode));
        }

        // Store theme name to set after themes are loaded
        final savedThemeName = settings['currentThemeName'] as String?;
        if (savedThemeName != null) {
          _savedThemeName = savedThemeName;
        }

        // Load other settings
        emit(
          state.copyWith(
            fontFamily: settings['fontFamily'] as String? ?? 'Roboto',
            layoutDirection: LayoutDirection.values.firstWhere(
              (e) => e.name == (settings['layoutDirection'] as String? ?? 'ltr'),
              orElse: () => LayoutDirection.ltr,
            ),
            textDirection: TextDirection.values.firstWhere(
              (e) => e.name == (settings['textDirection'] as String? ?? 'ltr'),
              orElse: () => TextDirection.ltr,
            ),
            enableRtlToolbarItems: settings['enableRtlToolbarItems'] as bool? ?? false,
            locale: Locale(
              settings['localeLanguageCode'] as String? ?? 'en',
              settings['localeCountryCode'] as String? ?? 'US',
            ),
            isMenuCollapsed: settings['isMenuCollapsed'] as bool? ?? false,
            menuOffset: (settings['menuOffset'] as num?)?.toDouble() ?? 0.0,
            dateFormat: settings['dateFormat'] as String? ?? 'MM/dd/yyyy',
            timeFormat: settings['timeFormat'] as String? ?? '12h',
            timezoneId: settings['timezoneId'] as String? ?? 'UTC',
            documentCursorColor: settings['documentCursorColor'] != null
                ? Color(int.parse(settings['documentCursorColor'] as String))
                : null,
            documentSelectionColor: settings['documentSelectionColor'] != null
                ? Color(int.parse(settings['documentSelectionColor'] as String))
                : null,
            textScaleFactor: (settings['textScaleFactor'] as num?)?.toDouble() ?? 1.0,
          ),
        );
      }
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to load settings: $e'));
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settings = {
        'themeMode': state.themeMode.name,
        'fontFamily': state.fontFamily,
        'layoutDirection': state.layoutDirection.name,
        'textDirection': state.textDirection.name,
        'enableRtlToolbarItems': state.enableRtlToolbarItems,
        'localeLanguageCode': state.locale.languageCode,
        'localeCountryCode': state.locale.countryCode,
        'isMenuCollapsed': state.isMenuCollapsed,
        'menuOffset': state.menuOffset,
        'dateFormat': state.dateFormat,
        'timeFormat': state.timeFormat,
        'timezoneId': state.timezoneId,
        'documentCursorColor': state.documentCursorColor?.toARGB32().toString(),
        'documentSelectionColor': state.documentSelectionColor?.toARGB32().toString(),
        'textScaleFactor': state.textScaleFactor,
        'currentThemeName': state.appThemeSet.themeName,
      };

      await prefs.setString(_settingsKey, jsonEncode(settings));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to save settings: $e'));
    }
  }

  Future<void> _loadThemes() async {
    try {
      // Get inbuilt themes
      final inbuiltThemesList = inbuiltThemes();

      // Get imported themes from file system if file manager is available
      var importedThemes = <AppThemeSet>[];
      try {
        if (fileManager.isInitialized) {
          importedThemes = await fileManager.getAllDecodedContents<AppThemeSet>(
            decoder: ThemeSetDecoder(),
            recursive: false, // Only look in the themes directory, not subdirectories
          );
        }
      } catch (e) {
        // File manager not initialized yet, use empty list
        importedThemes = [];
      }

      // Combine inbuilt and imported themes
      final allThemes = [...inbuiltThemesList, ...importedThemes];

      emit(state.copyWith(availableThemes: allThemes));

      // Set theme after loading themes (if a specific theme was saved)
      if (_savedThemeName != null) {
        final savedTheme = allThemes.firstWhere(
          (theme) => theme.themeName == _savedThemeName,
          orElse: () => allThemes.first,
        );
        emit(state.copyWith(appThemeSet: savedTheme));
        _savedThemeName = null; // Clear after using
      }
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to load themes: $e'));
    }
  }

  Future<void> _loadThemeFromFile(String filePath) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final file = File(filePath);
      final decoder = ThemeSetDecoder();

      if (!decoder.canDecode(file)) {
        throw Exception('Invalid theme file format. Expected .theme_design directory.');
      }

      // Save theme to themes directory
      if (fileManager.isInitialized) {
        await fileManager.importFolderSaveIntoDirectory(
          Directory(filePath),
          overwrite: true,
        );
      } else {
        throw Exception('File manager not initialized');
      }

      // Reload all themes to include the new one
      await _loadThemes();

      emit(state.copyWith(isLoading: false));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load theme: $e',
        ),
      );
    }
  }

  List<({String name, bool isInbuilt})> getAllThemesWithDetails() {
    return state.availableThemes
        .map(
          (theme) => (
            name: theme.themeName,
            isInbuilt: theme.isInbuilt,
          ),
        )
        .toList();
  }
}
