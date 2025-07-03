import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/decoders/theme_decoder.dart';
import 'package:debug_app_web/core/manager/file_manager/service/file_manager_service.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;

// Mock classes for testing
class MockFileManagerService extends Mock implements FileManagerService {}

// Fake classes for mocktail
class FakeDirectory extends Fake implements Directory {}

class FakeFile extends Fake implements File {}

void main() {
  group('Theme Upload Functionality Tests', () {
    late Directory testFixturesDir;

    // Test theme paths
    late String testThemePath;
    late String forestGreenThemePath;
    late String invalidThemePath;

    setUpAll(() {
      // Register fallback values
      registerFallbackValue(FakeDirectory());
      registerFallbackValue(FakeFile());
      registerFallbackValue(ThemeSetDecoder());
    });

    setUp(() {
      // Get the project root directory and test fixtures
      final projectRoot = Directory.current;
      testFixturesDir =
          Directory(path.join(projectRoot.path, 'test', 'fixtures', 'themes'));

      // Set up test theme paths
      testThemePath = path.join(testFixturesDir.path, 'test_theme.theme_design');
      forestGreenThemePath =
          path.join(testFixturesDir.path, 'forest_green_test.theme_design');
      invalidThemePath = path.join(testFixturesDir.path, 'invalid_theme.theme_design');
    });

    group('Test Theme Validation', () {
      test('should validate test theme directory exists', () {
        final testThemeDir = Directory(testThemePath);
        expect(
          testThemeDir.existsSync(),
          isTrue,
          reason: 'Test theme directory should exist at $testThemePath',
        );
      });

      test('should validate forest green theme directory exists', () {
        final forestGreenDir = Directory(forestGreenThemePath);
        expect(
          forestGreenDir.existsSync(),
          isTrue,
          reason: 'Forest green theme directory should exist at $forestGreenThemePath',
        );
      });

      test('should validate light.json exists in test theme', () {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        expect(
          lightFile.existsSync(),
          isTrue,
          reason: 'light.json should exist in test theme',
        );
      });

      test('should validate dark.json exists in test theme', () {
        final darkFile = File(path.join(testThemePath, 'dark.json'));
        expect(
          darkFile.existsSync(),
          isTrue,
          reason: 'dark.json should exist in test theme',
        );
      });

      test('should validate light.json exists in forest green theme', () {
        final lightFile = File(path.join(forestGreenThemePath, 'light.json'));
        expect(
          lightFile.existsSync(),
          isTrue,
          reason: 'light.json should exist in forest green theme',
        );
      });

      test('should validate dark.json exists in forest green theme', () {
        final darkFile = File(path.join(forestGreenThemePath, 'dark.json'));
        expect(
          darkFile.existsSync(),
          isTrue,
          reason: 'dark.json should exist in forest green theme',
        );
      });
    });

    group('Theme JSON Structure Validation', () {
      test('should parse test theme light.json correctly', () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final content = await lightFile.readAsString();

        expect(
          () => jsonDecode(content),
          returnsNormally,
          reason: 'Test theme light.json should be valid JSON',
        );

        final json = jsonDecode(content) as Map<String, dynamic>;

        // Check required top-level fields
        expect(json, containsPair('themeName', 'Test Theme Light'));
        expect(json, contains('textColorScheme'));
        expect(json, contains('iconColorScheme'));
        expect(json, contains('borderColorScheme'));
        expect(json, contains('fillColorScheme'));
        expect(json, contains('surfaceColorScheme'));
        expect(json, contains('backgroundColorScheme'));
        expect(json, contains('badgeColorScheme'));
        expect(json, contains('brandColorScheme'));
        expect(json, contains('surfaceContainerColorScheme'));
        expect(json, contains('otherColorsColorScheme'));
      });

      test('should parse test theme dark.json correctly', () async {
        final darkFile = File(path.join(testThemePath, 'dark.json'));
        final content = await darkFile.readAsString();

        expect(
          () => jsonDecode(content),
          returnsNormally,
          reason: 'Test theme dark.json should be valid JSON',
        );

        final json = jsonDecode(content) as Map<String, dynamic>;

        // Check required top-level fields
        expect(json, containsPair('themeName', 'Test Theme Dark'));
        expect(json, contains('textColorScheme'));
        expect(json, contains('iconColorScheme'));
        expect(json, contains('borderColorScheme'));
        expect(json, contains('fillColorScheme'));
        expect(json, contains('surfaceColorScheme'));
        expect(json, contains('backgroundColorScheme'));
        expect(json, contains('badgeColorScheme'));
        expect(json, contains('brandColorScheme'));
        expect(json, contains('surfaceContainerColorScheme'));
        expect(json, contains('otherColorsColorScheme'));
      });

      test('should have matching theme names between light and dark for test theme',
          () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final darkFile = File(path.join(testThemePath, 'dark.json'));

        final lightContent = await lightFile.readAsString();
        final darkContent = await darkFile.readAsString();

        final lightJson = jsonDecode(lightContent) as Map<String, dynamic>;
        final darkJson = jsonDecode(darkContent) as Map<String, dynamic>;

        // Theme names should follow the pattern "Theme Name Light" and "Theme Name Dark"
        final lightThemeName = lightJson['themeName'] as String;
        final darkThemeName = darkJson['themeName'] as String;

        expect(lightThemeName, contains('Test Theme'));
        expect(darkThemeName, contains('Test Theme'));
        expect(lightThemeName, contains('Light'));
        expect(darkThemeName, contains('Dark'));
      });

      test('should validate color format in theme files', () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final content = await lightFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;

        // Check textColorScheme colors are valid hex format
        final textColors = json['textColorScheme'] as Map<String, dynamic>;
        for (final colorValue in textColors.values) {
          if (colorValue is String) {
            expect(
              colorValue,
              matches(r'^#[0-9A-Fa-f]{6}$|^#[0-9A-Fa-f]{8}$'),
              reason: 'Color $colorValue should be in valid hex format',
            );
          }
        }
      });
    });

    group('Theme Structure Validation', () {
      test('should validate all required color schemes exist', () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final content = await lightFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;

        final requiredSchemes = [
          'textColorScheme',
          'iconColorScheme',
          'borderColorScheme',
          'fillColorScheme',
          'surfaceColorScheme',
          'backgroundColorScheme',
          'badgeColorScheme',
          'brandColorScheme',
          'surfaceContainerColorScheme',
          'otherColorsColorScheme',
        ];

        for (final scheme in requiredSchemes) {
          expect(
            json,
            contains(scheme),
            reason: 'Theme should contain $scheme',
          );
          expect(
            json[scheme],
            isA<Map<String, dynamic>>(),
            reason: '$scheme should be a map',
          );
        }
      });

      test('should validate textColorScheme has required fields', () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final content = await lightFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;

        final textColorScheme = json['textColorScheme'] as Map<String, dynamic>;
        final requiredFields = [
          'primary',
          'secondary',
          'tertiary',
          'quaternary',
          'onFill',
          'action',
          'actionHover',
          'info',
          'infoHover',
          'success',
          'successHover',
          'warning',
          'warningHover',
          'error',
          'errorHover',
          'featured',
          'featuredHover',
        ];

        for (final field in requiredFields) {
          expect(
            textColorScheme,
            contains(field),
            reason: 'textColorScheme should contain $field',
          );
        }
      });

      test('should validate badgeColorScheme structure', () async {
        final lightFile = File(path.join(testThemePath, 'light.json'));
        final content = await lightFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;

        final badgeColorScheme = json['badgeColorScheme'] as Map<String, dynamic>;
        expect(badgeColorScheme, contains('badgeColors'));

        final badgeColors = badgeColorScheme['badgeColors'] as List<dynamic>;
        expect(
          badgeColors,
          isNotEmpty,
          reason: 'badgeColors should not be empty',
        );

        // Check first badge color structure
        final firstBadge = badgeColors.first as Map<String, dynamic>;
        final requiredBadgeFields = [
          'light1',
          'light2',
          'light3',
          'thick1',
          'thick2',
          'thick3',
        ];

        for (final field in requiredBadgeFields) {
          expect(
            firstBadge,
            contains(field),
            reason: 'Badge color should contain $field',
          );
        }
      });
    });

    group('Theme Decoder Tests', () {
      test('should decode test theme successfully', () async {
        final decoder = ThemeSetDecoder();
        // The decoder expects a File path to the directory, not a Directory object
        final themeFile = File(testThemePath);

        // The decoder should be able to decode the theme directory
        expect(
          () async {
            final result = await decoder.decode(themeFile);
            expect(result, isA<AppThemeSet>());
            expect(result.themeName, equals('test_theme'));
          },
          returnsNormally,
        );
      });

      test('should decode forest green theme successfully', () async {
        final decoder = ThemeSetDecoder();
        final themeFile = File(forestGreenThemePath);

        expect(
          () async {
            final result = await decoder.decode(themeFile);
            expect(result, isA<AppThemeSet>());
            expect(result.themeName, equals('forest_green_test'));
          },
          returnsNormally,
        );
      });

      test('should handle missing light.json gracefully', () async {
        final decoder = ThemeSetDecoder();
        final invalidFile = File(invalidThemePath);

        // Create a directory without the required files
        final invalidDir = Directory(invalidThemePath);
        if (!invalidDir.existsSync()) {
          invalidDir.createSync(recursive: true);
        }

        try {
          expect(
            () async {
              await decoder.decode(invalidFile);
            },
            throwsA(isA<Exception>()),
          );
        } finally {
          // Clean up
          if (invalidDir.existsSync()) {
            invalidDir.deleteSync(recursive: true);
          }
        }
      });
    });

    group('Theme Upload Integration Tests', () {
      test('should successfully create AppThemeSet from test theme', () async {
        final decoder = ThemeSetDecoder();
        final themeFile = File(testThemePath);

        final result = await decoder.decode(themeFile);

        expect(result.themeName, equals('test_theme'));
        expect(result.isInbuilt, isFalse);
        expect(result.lightThemeColors, isNotNull);
        expect(result.darkThemeColors, isNotNull);

        // Check theme properties
        expect(result.lightThemeColors.themeName, contains('Light'));
        expect(result.darkThemeColors.themeName, contains('Dark'));

        // Verify color schemes exist
        expect(result.lightThemeColors.textColorScheme, isNotNull);
        expect(result.lightThemeColors.iconColorScheme, isNotNull);
        expect(result.lightThemeColors.fillColorScheme, isNotNull);
        expect(result.lightThemeColors.surfaceColorScheme, isNotNull);
      });

      test('should handle different theme color variations', () async {
        final decoder = ThemeSetDecoder();
        final forestGreenFile = File(forestGreenThemePath);

        final result = await decoder.decode(forestGreenFile);

        expect(result.themeName, equals('forest_green_test'));

        // Verify the themes have different color schemes
        final testThemeFile = File(testThemePath);
        final testResult = await decoder.decode(testThemeFile);

        // The themes should have different primary colors
        expect(
          result.lightThemeColors.textColorScheme.primary,
          isNot(equals(testResult.lightThemeColors.textColorScheme.primary)),
        );
      });

      test('should validate theme decoder can check file format', () {
        final decoder = ThemeSetDecoder();
        final themeFile = File(testThemePath);

        expect(
          decoder.canDecode(themeFile),
          isTrue,
          reason: 'Decoder should be able to decode valid theme directory',
        );

        // Test with invalid file
        final invalidFile = File('invalid_path.txt');
        expect(
          decoder.canDecode(invalidFile),
          isFalse,
          reason: 'Decoder should reject invalid files',
        );
      });
    });

    group('File System Error Handling', () {
      test('should handle non-existent theme directory', () {
        final decoder = ThemeSetDecoder();
        final nonExistentFile = File('non_existent_theme.theme_design');

        expect(
          () async {
            await decoder.decode(nonExistentFile);
          },
          throwsA(isA<Exception>()),
        );
      });

      test('should handle malformed JSON gracefully', () async {
        // Create a temporary theme directory with malformed JSON
        final tempDir =
            Directory(path.join(testFixturesDir.path, 'malformed_test.theme_design'));
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
        tempDir.createSync(recursive: true);

        // Create malformed light.json
        final lightFile = File(path.join(tempDir.path, 'light.json'));
        await lightFile.writeAsString('{ invalid json }');

        // Create valid dark.json
        final darkFile = File(path.join(tempDir.path, 'dark.json'));
        await darkFile.writeAsString('{"themeName": "Test"}');

        try {
          final decoder = ThemeSetDecoder();
          final themeFile = File(tempDir.path);

          expect(
            () async {
              await decoder.decode(themeFile);
            },
            throwsA(isA<Exception>()),
          );
        } finally {
          // Clean up
          if (tempDir.existsSync()) {
            tempDir.deleteSync(recursive: true);
          }
        }
      });
    });
  });
}
