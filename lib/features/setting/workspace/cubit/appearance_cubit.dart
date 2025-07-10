import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/constants/inbuilt_themes.dart';
import 'package:debug_app_web/core/manager/file_manager/decoders/theme_decoder.dart';
import 'package:debug_app_web/core/manager/file_manager/service/file_manager_service.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/apperence_state.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_ui_widgets/theme/definition/text_style/app_text_style.dart';
import 'package:theme_ui_widgets/theme_ui_widgets.dart' show AppThemeData;

enum UserTimeFormat {
  twelveHour('12h'),
  twentyFourHour('24h');

  final String value;
  const UserTimeFormat(this.value);
}

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

  // Get current theme data based on mode with user's font choice applied
  AppThemeData get currentThemeData {
    final baseTheme =
        isDarkMode ? state.appThemeSet.getDarkTheme() : state.appThemeSet.getLightTheme();

    // Apply user's font choice if specified, otherwise use theme's default
    final userFontFamily = state.fontFamily;
    if (userFontFamily != null && userFontFamily.isNotEmpty) {
      return baseTheme.copyWith(
        textStyle: AppTextStyle.customFontFamily(userFontFamily),
      );
    }

    return baseTheme;
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
      final selectedThemeIndex = state.availableThemes.indexWhere(
        (theme) => theme.themeName == themeName,
      );

      if (selectedThemeIndex == -1) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Theme not found: $themeName',
          ),
        );
        return;
      }

      final selectedTheme = state.availableThemes[selectedThemeIndex];

      await _saveSettings();

      emit(
        state.copyWith(
          appThemeSet: selectedTheme,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } on FileSystemException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Cannot access theme files: ${e.message}',
        ),
      );
    } on FormatException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid theme format: ${e.message}',
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Theme operation failed. Please try again.',
        ),
      );
    }
  }

  Future<void> uploadTheme() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // Add timeout to prevent hanging
      final directoryPath = await FilePicker.platform
          .getDirectoryPath(
        dialogTitle: 'Select Theme Directory (.theme_design)',
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          return null;
        },
      );

      if (directoryPath == null) {
        // User cancelled the selection
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'User cancelled the selection',
          ),
        );
        return;
      }

      // Validate it's a .theme_design directory
      if (!directoryPath.endsWith(_themeFileExtension)) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Please select a $_themeFileExtension directory',
          ),
        );
        return;
      }

      // Extract theme name from directory path
      final themeName = path.basenameWithoutExtension(directoryPath);

      // Check if theme with this name already exists
      final existingTheme = state.availableThemes.any(
        (theme) => theme.themeName.toLowerCase() == themeName.toLowerCase(),
      );

      if (existingTheme) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                'A theme with the name "$themeName" already exists. Please choose a different theme or rename the existing one.',
          ),
        );
        return;
      }

      await _loadThemeFromFile(directoryPath);

      emit(state.copyWith(isLoading: false, errorMessage: null));
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

      // Check if theme exists
      final themeIndex = state.availableThemes.indexWhere(
        (theme) => theme.themeName == themeName,
      );

      if (themeIndex == -1) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Theme not found: $themeName',
          ),
        );
        return;
      }

      final theme = state.availableThemes[themeIndex];

      if (theme.isInbuilt) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Cannot delete inbuilt theme: $themeName',
          ),
        );
        return;
      }

      // Check if it's the currently active theme (shouldn't be deleted)
      if (state.appThemeSet.themeName == themeName) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                'Cannot delete currently active theme: $themeName. Please switch to a different theme first.',
          ),
        );
        return;
      }

      // Find the theme directory
      if (!fileManager.isInitialized) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'File manager not initialized',
          ),
        );
        return;
      }

      final themeDirectoryName = '$themeName.theme_design';
      final themeDirectoryPath = path.join(fileManager.currentPath, themeDirectoryName);
      final themeDirectory = Directory(themeDirectoryPath);

      if (!themeDirectory.existsSync()) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Theme directory not found: $themeDirectoryName',
          ),
        );
        return;
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
  void setDateFormat(String dateFormat) {
    emit(state.copyWith(dateFormat: dateFormat));
    _saveSettingsDebounced();
  }

  void toggleTimeFormat() {
    final newFormat = state.timeFormat == '24h' ? '12h' : '24h';
    emit(state.copyWith(timeFormat: newFormat));
    _saveSettingsDebounced();
  }

  void setTimezoneId(String timezoneId) {
    emit(state.copyWith(timezoneId: timezoneId));
    _saveSettingsDebounced();
  }

  // Menu State Methods
  void setMenuCollapsed(bool collapsed) {}
  void setMenuOffset(double offset) {}

  // Error Management Methods
  void clearErrorMessage() {
    emit(state.copyWith(errorMessage: null));
  }

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
            fontFamily: settings['fontFamily'] as String? ?? state.fontFamily,
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

      // Get imported themes using our custom scanner
      final importedThemes = await _loadImportedThemes();

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

  Future<List<AppThemeSet>> _loadImportedThemes() async {
    final importedThemes = <AppThemeSet>[];

    if (!fileManager.isInitialized) {
      return importedThemes;
    }

    try {
      final themesDir = Directory(fileManager.currentPath);

      if (!themesDir.existsSync()) {
        return importedThemes;
      }

      final contents = themesDir.listSync();

      for (final item in contents) {
        if (item is Directory && item.path.endsWith('.theme_design')) {
          try {
            final decoder = ThemeSetDecoder();
            if (decoder.canDecode(File(item.path))) {
              final theme = await decoder.decode(File(item.path));
              importedThemes.add(theme);
            }
          } catch (e) {
            // Skip invalid themes
          }
        }
      }

      return importedThemes;
    } on Exception catch (e) {
      return importedThemes;
    }
  }

  Future<void> _loadThemeFromFile(String filePath) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final file = File(filePath);
      final decoder = ThemeSetDecoder();

      if (!decoder.canDecode(file)) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Invalid theme file format. Expected .theme_design directory.',
          ),
        );
        return;
      }

      // Save theme to themes directory
      if (fileManager.isInitialized) {
        await fileManager.importFolderSaveIntoDirectory(
          Directory(filePath),
          overwrite: true,
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'File manager not initialized',
          ),
        );
        return;
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
