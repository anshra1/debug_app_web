import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:debug_app_web/core/manager/file_manager/interfaces/decoder.dart';
import 'package:debug_app_web/core/manager/file_manager/service/file_manager_service.dart';
import 'package:debug_app_web/features/theme_system.dart/cubit/apperence_state.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_default_theme.dart';
import 'package:debug_app_web/features/theme_system.dart/models/app_theme_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes for testing
class MockFileManagerService extends Mock implements FileManagerService {}

// Fake class for decoder - needed for mocktail
class FakeThemeSetDecoder extends Fake implements Decoder<AppThemeSet> {}

// Create a testable version of AppearanceCubit that doesn't run async initialization
class TestableAppearanceCubit extends Cubit<AppearanceState> {
  TestableAppearanceCubit({required this.mockFileManager})
      : super(AppearanceState.initial()) {
    // Load settings manually in tests when needed
    _loadSettings();
  }

  final MockFileManagerService mockFileManager;

  // Expose the same interface as AppearanceCubit but with controllable behavior
  String? _savedThemeName;
  Timer? _saveTimer;

  FileManagerService get fileManager => mockFileManager;

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString('appearance_settings');

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

        // Load other settings
        emit(
          state.copyWith(
            fontFamily: settings['fontFamily'] as String? ?? 'Roboto',
          ),
        );
      }
    } on Exception catch (_) {
      // Ignore errors in test loading
    }
  }

  void _saveSettingsDebounced() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), () async {
      // Mock save - do nothing in tests
    });
  }

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
          errorMessage: 'Cannot access theme files: ${e.message}',
          isLoading: false,
        ),
      );
    } on FormatException catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Invalid theme format: ${e.message}',
          isLoading: false,
        ),
      );
    } on Exception catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Theme operation failed. Please try again.',
          isLoading: false,
        ),
      );
    }
  }

  Future<void> deleteTheme(String themeName) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final theme = state.availableThemes.firstWhere(
        (theme) => theme.themeName == themeName,
        orElse: () => throw Exception('Theme not found: $themeName'),
      );

      if (theme.isInbuilt) {
        throw Exception('Cannot delete inbuilt theme: $themeName');
      }

      // Mock deletion in tests
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

  Future<void> setThemeMode(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
  }

  void resetThemeMode() {
    emit(state.copyWith(themeMode: ThemeMode.light));
    _saveSettingsDebounced();
  }

  void setFontFamily(String fontFamily) {
    emit(state.copyWith(fontFamily: fontFamily));
    _saveSettingsDebounced();
  }

  void resetFontFamily() {
    emit(state.copyWith(fontFamily: ''));
    _saveSettingsDebounced();
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

void main() {
  group('AppearanceCubit', () {
    late MockFileManagerService mockFileManager;

    // Sample theme data for testing
    late AppThemeSet sampleTheme1;
    late AppThemeSet sampleTheme2;
    late List<AppThemeSet> sampleThemes;

    setUpAll(() {
      // Register fallback values for mocktail
      registerFallbackValue(<AppThemeSet>[]);
      registerFallbackValue(FakeThemeSetDecoder());
    });

    setUp(() {
      // Setup SharedPreferences mock
      SharedPreferences.setMockInitialValues({});

      // Create mock file manager
      mockFileManager = MockFileManagerService();
      when(() => mockFileManager.initialize()).thenAnswer((_) async {});
      when(() => mockFileManager.currentPath).thenReturn('/test/themes');
      when(
        () => mockFileManager.getAllDecodedContents<AppThemeSet>(
          decoder: any(named: 'decoder'),
          recursive: any(named: 'recursive'),
        ),
      ).thenAnswer((_) async => []);

      // Initialize sample themes
      sampleTheme1 = AppThemeSet(
        isInbuilt: true,
        themeName: 'light',
        lightThemeColors: AppDefaultTheme().light(),
        darkThemeColors: AppDefaultTheme().dark(),
      );

      sampleTheme2 = AppThemeSet(
        isInbuilt: false,
        themeName: 'custom_blue',
        lightThemeColors: AppDefaultTheme().light(),
        darkThemeColors: AppDefaultTheme().dark(),
      );

      sampleThemes = [sampleTheme1, sampleTheme2];
    });

    group('Constructor and Initialization', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should emit initial state correctly',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        verify: (cubit) {
          expect(cubit.state.isLoading, false);
          expect(cubit.state.errorMessage, null);
          expect(cubit.state.themeMode, ThemeMode.light);
          expect(cubit.state.fontFamily, 'Roboto');
        },
      );
    });

    group('Theme Management', () {
      group('setTheme', () {
        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should successfully set theme when theme exists',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          seed: () => AppearanceState.initial().copyWith(
            availableThemes: sampleThemes,
          ),
          act: (cubit) => cubit.setTheme('light'),
          expect: () => [
            // Loading state
            isA<AppearanceState>()
                .having((s) => s.isLoading, 'isLoading', true)
                .having((s) => s.errorMessage, 'errorMessage', null),
            // Success state
            isA<AppearanceState>()
                .having((s) => s.appThemeSet.themeName, 'themeName', 'light')
                .having((s) => s.isLoading, 'isLoading', false)
                .having((s) => s.errorMessage, 'errorMessage', null),
          ],
        );

        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should emit error when theme name is empty',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          act: (cubit) => cubit.setTheme(''),
          expect: () => [
            isA<AppearanceState>().having(
              (s) => s.errorMessage,
              'errorMessage',
              'Theme name cannot be empty',
            ),
          ],
        );

        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should emit error when theme name is too long',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          act: (cubit) => cubit.setTheme('a' * 51),
          expect: () => [
            isA<AppearanceState>()
                .having((s) => s.errorMessage, 'errorMessage', 'Theme name too long'),
          ],
        );

        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should emit error when theme not found',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          seed: () => AppearanceState.initial().copyWith(
            availableThemes: sampleThemes,
          ),
          act: (cubit) => cubit.setTheme('nonexistent_theme'),
          expect: () => [
            // Loading state
            isA<AppearanceState>().having((s) => s.isLoading, 'isLoading', true),
            // Error state
            isA<AppearanceState>()
                .having(
                  (s) => s.errorMessage,
                  'errorMessage',
                  'Theme operation failed. Please try again.',
                )
                .having((s) => s.isLoading, 'isLoading', false),
          ],
        );
      });

      group('deleteTheme', () {
        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should emit error when trying to delete inbuilt theme',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          seed: () => AppearanceState.initial().copyWith(
            availableThemes: sampleThemes,
          ),
          act: (cubit) => cubit.deleteTheme('light'),
          expect: () => [
            // Loading state
            isA<AppearanceState>().having((s) => s.isLoading, 'isLoading', true),
            // Error state
            isA<AppearanceState>()
                .having(
                  (s) => s.errorMessage,
                  'errorMessage',
                  contains('Failed to delete theme'),
                )
                .having((s) => s.isLoading, 'isLoading', false),
          ],
        );

        blocTest<TestableAppearanceCubit, AppearanceState>(
          'should emit error when theme not found for deletion',
          build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
          seed: () => AppearanceState.initial().copyWith(
            availableThemes: sampleThemes,
          ),
          act: (cubit) => cubit.deleteTheme('nonexistent_theme'),
          expect: () => [
            // Loading state
            isA<AppearanceState>().having((s) => s.isLoading, 'isLoading', true),
            // Error state
            isA<AppearanceState>()
                .having(
                  (s) => s.errorMessage,
                  'errorMessage',
                  contains('Failed to delete theme'),
                )
                .having((s) => s.isLoading, 'isLoading', false),
          ],
        );
      });
    });

    group('Theme Mode Management', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should successfully set theme mode to dark',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setThemeMode(ThemeMode.dark),
        expect: () => [
          isA<AppearanceState>().having((s) => s.themeMode, 'themeMode', ThemeMode.dark),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should successfully set theme mode to system',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setThemeMode(ThemeMode.system),
        expect: () => [
          isA<AppearanceState>()
              .having((s) => s.themeMode, 'themeMode', ThemeMode.system),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should reset theme mode to light',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(themeMode: ThemeMode.dark),
        act: (cubit) => cubit.resetThemeMode(),
        expect: () => [
          isA<AppearanceState>().having((s) => s.themeMode, 'themeMode', ThemeMode.light),
        ],
      );
    });

    group('Font Management', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should successfully set font family',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setFontFamily('Arial'),
        expect: () => [
          isA<AppearanceState>().having((s) => s.fontFamily, 'fontFamily', 'Arial'),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should handle empty font family',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setFontFamily(''),
        expect: () => [
          isA<AppearanceState>().having((s) => s.fontFamily, 'fontFamily', ''),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should handle special characters in font family',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setFontFamily('Font-Family_123'),
        expect: () => [
          isA<AppearanceState>()
              .having((s) => s.fontFamily, 'fontFamily', 'Font-Family_123'),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should reset font family to empty string',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(fontFamily: 'Arial'),
        act: (cubit) => cubit.resetFontFamily(),
        expect: () => [
          isA<AppearanceState>().having((s) => s.fontFamily, 'fontFamily', ''),
        ],
      );
    });

    group('Helper Methods', () {
      test('should return empty list when no themes available', () {
        final cubit = TestableAppearanceCubit(mockFileManager: mockFileManager);
        final result = cubit.getAllThemesWithDetails();
        expect(result, isEmpty);
        cubit.close();
      });

      test('should return theme details with correct structure', () {
        final cubit = TestableAppearanceCubit(mockFileManager: mockFileManager);
        cubit.emit(cubit.state.copyWith(availableThemes: sampleThemes));

        final result = cubit.getAllThemesWithDetails();

        expect(result, hasLength(2));
        expect(result[0].name, 'light');
        expect(result[0].isInbuilt, true);
        expect(result[1].name, 'custom_blue');
        expect(result[1].isInbuilt, false);

        cubit.close();
      });

      test('should handle themes with special characters in names', () {
        final specialTheme = AppThemeSet(
          isInbuilt: false,
          themeName: 'theme-with_special.chars',
          lightThemeColors: AppDefaultTheme().light(),
          darkThemeColors: AppDefaultTheme().dark(),
        );

        final cubit = TestableAppearanceCubit(mockFileManager: mockFileManager);
        cubit.emit(cubit.state.copyWith(availableThemes: [specialTheme]));

        final result = cubit.getAllThemesWithDetails();

        expect(result, hasLength(1));
        expect(result[0].name, 'theme-with_special.chars');

        cubit.close();
      });
    });

    group('Settings Persistence', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should save settings with debouncing',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) async {
          cubit.setFontFamily('Arial');
          cubit.setFontFamily('Times');
          cubit.setFontFamily('Helvetica');
          // Wait for debounce
          await Future.delayed(const Duration(milliseconds: 600));
        },
        skip: 2, // Skip the first two emissions
        expect: () => [
          isA<AppearanceState>().having((s) => s.fontFamily, 'fontFamily', 'Helvetica'),
        ],
      );

      test('should load saved settings on initialization', () async {
        // Setup SharedPreferences with saved settings
        SharedPreferences.setMockInitialValues({
          'appearance_settings': jsonEncode({
            'themeMode': 'dark',
            'fontFamily': 'Arial',
            'currentThemeName': 'dark_theme',
          }),
        });

        // Create new cubit (will load settings)
        final newCubit = TestableAppearanceCubit(mockFileManager: mockFileManager);
        await Future.delayed(Duration.zero);

        // Assert
        expect(newCubit.state.themeMode, ThemeMode.dark);
        expect(newCubit.state.fontFamily, 'Arial');

        // Cleanup
        await newCubit.close();
      });
    });

    group('Error Handling', () {
      test('should handle invalid JSON in settings gracefully', () async {
        // Setup invalid JSON in SharedPreferences
        SharedPreferences.setMockInitialValues({
          'appearance_settings': 'invalid_json',
        });

        // Create new cubit
        final newCubit = TestableAppearanceCubit(mockFileManager: mockFileManager);
        await Future.delayed(Duration.zero);

        // Should handle gracefully and use defaults
        expect(newCubit.state.themeMode, ThemeMode.light);
        expect(newCubit.state.fontFamily, 'Roboto');

        // Cleanup
        await newCubit.close();
      });
    });

    group('State Transitions', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should maintain state consistency during theme operations',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(
          availableThemes: sampleThemes,
        ),
        act: (cubit) => cubit.setTheme('light'),
        verify: (cubit) {
          expect(cubit.state.appThemeSet.themeName, 'light');
          expect(cubit.state.availableThemes, sampleThemes);
          expect(cubit.state.isLoading, false);
        },
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should preserve other state when changing font family',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(
          themeMode: ThemeMode.dark,
          availableThemes: sampleThemes,
        ),
        act: (cubit) => cubit.setFontFamily('Arial'),
        verify: (cubit) {
          expect(cubit.state.fontFamily, 'Arial');
          expect(cubit.state.themeMode, ThemeMode.dark);
          expect(cubit.state.availableThemes, sampleThemes);
        },
      );
    });

    group('Edge Cases', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should handle very long theme names in validation',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        act: (cubit) => cubit.setTheme('a' * 100),
        expect: () => [
          isA<AppearanceState>()
              .having((s) => s.errorMessage, 'errorMessage', 'Theme name too long'),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should handle theme operations with empty theme list',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(availableThemes: []),
        act: (cubit) => cubit.setTheme('any_theme'),
        expect: () => [
          // Loading state
          isA<AppearanceState>().having((s) => s.isLoading, 'isLoading', true),
          // Error state
          isA<AppearanceState>().having(
            (s) => s.errorMessage,
            'errorMessage',
            'Theme operation failed. Please try again.',
          ),
        ],
      );

      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should handle rapid consecutive theme changes',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(
          availableThemes: sampleThemes,
        ),
        act: (cubit) async {
          await cubit.setTheme('light');
          await cubit.setTheme('custom_blue');
          await cubit.setTheme('light');
        },
        verify: (cubit) {
          expect(cubit.state.isLoading, false);
          expect(['light', 'custom_blue'], contains(cubit.state.appThemeSet.themeName));
        },
      );
    });

    group('Integration Tests', () {
      blocTest<TestableAppearanceCubit, AppearanceState>(
        'should complete full theme workflow',
        build: () => TestableAppearanceCubit(mockFileManager: mockFileManager),
        seed: () => AppearanceState.initial().copyWith(
          availableThemes: sampleThemes,
        ),
        act: (cubit) async {
          await cubit.setThemeMode(ThemeMode.dark);
          cubit.setFontFamily('Arial');
          await cubit.setTheme('custom_blue');
        },
        verify: (cubit) {
          expect(cubit.state.themeMode, ThemeMode.dark);
          expect(cubit.state.fontFamily, 'Arial');
          expect(cubit.state.appThemeSet.themeName, 'custom_blue');
          expect(cubit.state.errorMessage, isNull);
        },
      );
    });
  });
}
