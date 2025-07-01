import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/decoders/theme_decoder.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('ThemeSetDecoder Tests', () {
    late ThemeSetDecoder decoder;
    late Directory tempDir;
    late String testThemesPath;

    setUpAll(() {
      decoder = ThemeSetDecoder();
    });

    setUp(() async {
      // Create a temporary directory for test themes
      tempDir = await Directory.systemTemp.createTemp('theme_decoder_test_');
      testThemesPath = tempDir.path;
    });

    tearDown(() async {
      // Clean up temporary directory
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    group('canDecode() Tests', () {
      test('should return true for valid .theme_design directory with required files',
          () async {
        // Arrange: Create a valid theme directory structure
        final themeDir = Directory(path.join(testThemesPath, 'ocean_blue.theme_design'));
        await themeDir.create(recursive: true);

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString('{}');
        await darkFile.writeAsString('{}');

        // Act
        final canDecode = decoder.canDecode(File(themeDir.path));

        // Assert
        expect(canDecode, isTrue);
      });

      test('should return false for directory without .theme_design suffix', () async {
        // Arrange: Create directory without .theme_design suffix
        final themeDir = Directory(path.join(testThemesPath, 'ocean_blue'));
        await themeDir.create(recursive: true);

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString('{}');
        await darkFile.writeAsString('{}');

        // Act
        final canDecode = decoder.canDecode(File(themeDir.path));

        // Assert
        expect(canDecode, isFalse);
      });

      test('should return false for directory missing light.json', () async {
        // Arrange: Create directory missing light.json
        final themeDir = Directory(path.join(testThemesPath, 'ocean_blue.theme_design'));
        await themeDir.create(recursive: true);

        final darkFile = File(path.join(themeDir.path, 'dark.json'));
        await darkFile.writeAsString('{}');

        // Act
        final canDecode = decoder.canDecode(File(themeDir.path));

        // Assert
        expect(canDecode, isFalse);
      });

      test('should return false for directory missing dark.json', () async {
        // Arrange: Create directory missing dark.json
        final themeDir = Directory(path.join(testThemesPath, 'ocean_blue.theme_design'));
        await themeDir.create(recursive: true);

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        await lightFile.writeAsString('{}');

        // Act
        final canDecode = decoder.canDecode(File(themeDir.path));

        // Assert
        expect(canDecode, isFalse);
      });

      test('should return false for non-existent directory', () {
        // Arrange: Non-existent directory
        final nonExistentDir =
            File(path.join(testThemesPath, 'non_existent.theme_design'));

        // Act
        final canDecode = decoder.canDecode(nonExistentDir);

        // Assert
        expect(canDecode, isFalse);
      });

      test('should return false for regular file instead of directory', () async {
        // Arrange: Create a regular file instead of directory
        final regularFile = File(path.join(testThemesPath, 'theme.theme_design'));
        await regularFile.writeAsString('not a directory');

        // Act
        final canDecode = decoder.canDecode(regularFile);

        // Assert
        expect(canDecode, isFalse);
      });
    });

    group('decode() Tests', () {
      test('should successfully decode valid theme directory', () async {
        // Arrange: Create valid theme directory with complete theme data
        final themeDir = Directory(path.join(testThemesPath, 'test_theme.theme_design'));
        await themeDir.create(recursive: true);

        final validLightTheme = _createValidLightThemeJson();
        final validDarkTheme = _createValidDarkThemeJson();

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString(jsonEncode(validLightTheme));
        await darkFile.writeAsString(jsonEncode(validDarkTheme));

        // Act
        final appThemeSet = await decoder.decode(File(themeDir.path));

        // Assert
        expect(appThemeSet, isA<AppThemeSet>());
        expect(appThemeSet.themeName, equals('test_theme'));
        expect(appThemeSet.isInbuilt, isFalse);
        expect(
          appThemeSet.lightThemeColors.textColorScheme.primary.value,
          equals(0xFF000000),
        );
        expect(
          appThemeSet.darkThemeColors.textColorScheme.primary.value,
          equals(0xFFFFFFFF),
        );
      });

      test('should throw exception for invalid theme directory', () async {
        // Arrange: Create invalid directory
        final invalidDir = Directory(path.join(testThemesPath, 'invalid_theme'));
        await invalidDir.create(recursive: true);

        // Act & Assert
        expect(
          () => decoder.decode(File(invalidDir.path)),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Invalid theme directory structure'),
            ),
          ),
        );
      });

      test('should throw exception for invalid JSON in light.json', () async {
        // Arrange: Create theme directory with invalid JSON
        final themeDir =
            Directory(path.join(testThemesPath, 'invalid_json.theme_design'));
        await themeDir.create(recursive: true);

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString('invalid json');
        await darkFile.writeAsString(jsonEncode(_createValidDarkThemeJson()));

        // Act & Assert
        expect(
          () => decoder.decode(File(themeDir.path)),
          throwsA(isA<Exception>()),
        );
      });

      test('should extract correct theme name from directory', () async {
        // Arrange: Create theme directory with specific name
        final themeDir =
            Directory(path.join(testThemesPath, 'ocean_blue_sunset.theme_design'));
        await themeDir.create(recursive: true);

        final validLightTheme = _createValidLightThemeJson();
        final validDarkTheme = _createValidDarkThemeJson();

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString(jsonEncode(validLightTheme));
        await darkFile.writeAsString(jsonEncode(validDarkTheme));

        // Act
        final appThemeSet = await decoder.decode(File(themeDir.path));

        // Assert
        expect(appThemeSet.themeName, equals('ocean_blue_sunset'));
      });
    });

    group('Validation Tests', () {
      test('should validate all color schemes successfully with valid data', () async {
        // Arrange: Create theme directory with valid complete theme data
        final themeDir =
            Directory(path.join(testThemesPath, 'valid_complete.theme_design'));
        await themeDir.create(recursive: true);

        final validLightTheme = _createValidLightThemeJson();
        final validDarkTheme = _createValidDarkThemeJson();

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString(jsonEncode(validLightTheme));
        await darkFile.writeAsString(jsonEncode(validDarkTheme));

        // Act & Assert - Should not throw any exceptions
        final result = await decoder.decode(File(themeDir.path));
        expect(result, isA<AppThemeSet>());
      });

      test('should throw exception for empty badge colors', () async {
        // Arrange: Create theme directory with empty badge colors
        final themeDir =
            Directory(path.join(testThemesPath, 'empty_badges.theme_design'));
        await themeDir.create(recursive: true);

        final invalidTheme = _createValidLightThemeJson();
        (invalidTheme['badgeColorScheme'] as Map<String, dynamic>)['badgeColors'] =
            <Map<String, dynamic>>[];

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString(jsonEncode(invalidTheme));
        await darkFile.writeAsString(jsonEncode(_createValidDarkThemeJson()));

        // Act & Assert
        expect(
          () => decoder.decode(File(themeDir.path)),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('BadgeColorScheme must contain at least one badge color'),
            ),
          ),
        );
      });
    });

    group('Theme Creation Tests', () {
      test('should create valid light and dark themes', () async {
        // Arrange: Create complete theme directory
        final themeDir =
            Directory(path.join(testThemesPath, 'complete_theme.theme_design'));
        await themeDir.create(recursive: true);

        final validLightTheme = _createValidLightThemeJson();
        final validDarkTheme = _createValidDarkThemeJson();

        final lightFile = File(path.join(themeDir.path, 'light.json'));
        final darkFile = File(path.join(themeDir.path, 'dark.json'));

        await lightFile.writeAsString(jsonEncode(validLightTheme));
        await darkFile.writeAsString(jsonEncode(validDarkTheme));

        // Act
        final appThemeSet = await decoder.decode(File(themeDir.path));

        // Assert
        final lightThemeData = appThemeSet.getLightTheme();
        final darkThemeData = appThemeSet.getDarkTheme();

        expect(lightThemeData.themeName, equals('complete_theme'));
        expect(darkThemeData.themeName, equals('complete_theme'));

        // Verify different colors for light and dark themes
        expect(
          lightThemeData.textColorScheme.primary.value,
          isNot(equals(darkThemeData.textColorScheme.primary.value)),
        );
        expect(
          lightThemeData.backgroundColorScheme.primary.value,
          isNot(equals(darkThemeData.backgroundColorScheme.primary.value)),
        );
      });
    });
  });
}

// Helper method to create valid light theme JSON
Map<String, dynamic> _createValidLightThemeJson() {
  return {
    'themeName': 'Test Light Theme',
    'textColorScheme': {
      'primary': '#000000',
      'secondary': '#666666',
      'tertiary': '#999999',
      'quaternary': '#cccccc',
      'onFill': '#ffffff',
      'action': '#2196f3',
      'actionHover': '#1976d2',
      'info': '#2196f3',
      'infoHover': '#1976d2',
      'success': '#4caf50',
      'successHover': '#388e3c',
      'warning': '#ff9800',
      'warningHover': '#f57c00',
      'error': '#f44336',
      'errorHover': '#d32f2f',
      'featured': '#9c27b0',
      'featuredHover': '#7b1fa2',
    },
    'iconColorScheme': {
      'primary': '#000000',
      'secondary': '#666666',
      'tertiary': '#999999',
      'quaternary': '#cccccc',
      'onFill': '#ffffff',
      'featuredThick': '#9c27b0',
      'featuredThickHover': '#7b1fa2',
      'infoThick': '#2196f3',
      'infoThickHover': '#1976d2',
      'successThick': '#4caf50',
      'successThickHover': '#388e3c',
      'warningThick': '#ff9800',
      'warningThickHover': '#f57c00',
      'errorThick': '#f44336',
      'errorThickHover': '#d32f2f',
    },
    'borderColorScheme': {
      'primary': '#e0e0e0',
      'primaryHover': '#bdbdbd',
      'secondary': '#757575',
      'secondaryHover': '#616161',
      'tertiary': '#424242',
      'tertiaryHover': '#212121',
      'themeThick': '#2196f3',
      'themeThickHover': '#1976d2',
      'infoThick': '#2196f3',
      'infoThickHover': '#1976d2',
      'successThick': '#4caf50',
      'successThickHover': '#388e3c',
      'warningThick': '#ff9800',
      'warningThickHover': '#f57c00',
      'errorThick': '#f44336',
      'errorThickHover': '#d32f2f',
      'featuredThick': '#9c27b0',
      'featuredThickHover': '#7b1fa2',
    },
    'badgeColorScheme': {
      'badgeColors': [
        {
          'light1': '#e3f2fd',
          'light2': '#bbdefb',
          'light3': '#90caf9',
          'thick1': '#42a5f5',
          'thick2': '#2196f3',
          'thick3': '#1976d2',
        }
      ],
    },
    'backgroundColorScheme': {
      'primary': '#ffffff',
    },
    'fillColorScheme': {
      'primary': '#f5f5f5',
      'primaryHover': '#eeeeee',
      'secondary': '#e0e0e0',
      'secondaryHover': '#d5d5d5',
      'tertiary': '#bdbdbd',
      'tertiaryHover': '#9e9e9e',
      'quaternary': '#757575',
      'quaternaryHover': '#616161',
      'content': '#ffffff',
      'contentHover': '#f8f9fa',
      'contentVisible': '#f1f3f4',
      'contentVisibleHover': '#e8eaed',
      'themeThick': '#2196f3',
      'themeThickHover': '#1976d2',
      'themeSelect': '#e3f2fd',
      'textSelect': '#bbdefb',
      'infoLight': '#e3f2fd',
      'infoLightHover': '#bbdefb',
      'infoThick': '#2196f3',
      'infoThickHover': '#1976d2',
      'successLight': '#e8f5e8',
      'successLightHover': '#c8e6c9',
      'warningLight': '#fff3e0',
      'warningLightHover': '#ffe0b2',
      'errorLight': '#ffebee',
      'errorLightHover': '#ffcdd2',
      'errorThick': '#f44336',
      'errorThickHover': '#d32f2f',
      'errorSelect': '#ffebee',
      'featuredLight': '#f3e5f5',
      'featuredLightHover': '#e1bee7',
      'featuredThick': '#9c27b0',
      'featuredThickHover': '#7b1fa2',
    },
    'surfaceColorScheme': {
      'primary': '#ffffff',
      'primaryHover': '#f5f5f5',
      'layer01': '#ffffff',
      'layer01Hover': '#f5f5f5',
      'layer02': '#fafafa',
      'layer02Hover': '#f0f0f0',
      'layer03': '#f5f5f5',
      'layer03Hover': '#eeeeee',
      'layer04': '#f0f0f0',
      'layer04Hover': '#e8e8e8',
      'inverse': '#212121',
      'secondary': '#424242',
      'overlay': '#00000080',
    },
    'brandColorScheme': {
      'skyline': '#00b5ff',
      'aqua': '#00c8ff',
      'violet': '#9327ff',
      'amethyst': '#8427e0',
      'berry': '#e3006d',
      'coral': '#fb006d',
      'golden': '#f7931e',
      'amber': '#ffbd00',
      'lemon': '#ffce00',
    },
    'surfaceContainerColorScheme': {
      'layer01': '#f5f5f5',
      'layer02': '#eeeeee',
      'layer03': '#e0e0e0',
    },
    'otherColorsColorScheme': {
      'textHighlight': '#e3f2fd',
    },
  };
}

// Helper method to create valid dark theme JSON
Map<String, dynamic> _createValidDarkThemeJson() {
  return {
    'themeName': 'Test Dark Theme',
    'textColorScheme': {
      'primary': '#ffffff',
      'secondary': '#b0b0b0',
      'tertiary': '#808080',
      'quaternary': '#606060',
      'onFill': '#000000',
      'action': '#64b5f6',
      'actionHover': '#42a5f5',
      'info': '#64b5f6',
      'infoHover': '#42a5f5',
      'success': '#81c784',
      'successHover': '#66bb6a',
      'warning': '#ffb74d',
      'warningHover': '#ffa726',
      'error': '#e57373',
      'errorHover': '#ef5350',
      'featured': '#ce93d8',
      'featuredHover': '#ba68c8',
    },
    'iconColorScheme': {
      'primary': '#ffffff',
      'secondary': '#b0b0b0',
      'tertiary': '#808080',
      'quaternary': '#606060',
      'onFill': '#000000',
      'featuredThick': '#ce93d8',
      'featuredThickHover': '#ba68c8',
      'infoThick': '#64b5f6',
      'infoThickHover': '#42a5f5',
      'successThick': '#81c784',
      'successThickHover': '#66bb6a',
      'warningThick': '#ffb74d',
      'warningThickHover': '#ffa726',
      'errorThick': '#e57373',
      'errorThickHover': '#ef5350',
    },
    'borderColorScheme': {
      'primary': '#424242',
      'primaryHover': '#616161',
      'secondary': '#757575',
      'secondaryHover': '#9e9e9e',
      'tertiary': '#bdbdbd',
      'tertiaryHover': '#e0e0e0',
      'themeThick': '#64b5f6',
      'themeThickHover': '#42a5f5',
      'infoThick': '#64b5f6',
      'infoThickHover': '#42a5f5',
      'successThick': '#81c784',
      'successThickHover': '#66bb6a',
      'warningThick': '#ffb74d',
      'warningThickHover': '#ffa726',
      'errorThick': '#e57373',
      'errorThickHover': '#ef5350',
      'featuredThick': '#ce93d8',
      'featuredThickHover': '#ba68c8',
    },
    'badgeColorScheme': {
      'badgeColors': [
        {
          'light1': '#0d47a1',
          'light2': '#1565c0',
          'light3': '#1976d2',
          'thick1': '#2196f3',
          'thick2': '#42a5f5',
          'thick3': '#64b5f6',
        }
      ],
    },
    'backgroundColorScheme': {
      'primary': '#121212',
    },
    'fillColorScheme': {
      'primary': '#1e1e1e',
      'primaryHover': '#2a2a2a',
      'secondary': '#303030',
      'secondaryHover': '#383838',
      'tertiary': '#424242',
      'tertiaryHover': '#4a4a4a',
      'quaternary': '#616161',
      'quaternaryHover': '#757575',
      'content': '#1e1e1e',
      'contentHover': '#2a2a2a',
      'contentVisible': '#303030',
      'contentVisibleHover': '#383838',
      'themeThick': '#64b5f6',
      'themeThickHover': '#42a5f5',
      'themeSelect': '#0d47a1',
      'textSelect': '#1565c0',
      'infoLight': '#0d47a1',
      'infoLightHover': '#1565c0',
      'infoThick': '#64b5f6',
      'infoThickHover': '#42a5f5',
      'successLight': '#1b5e20',
      'successLightHover': '#2e7d32',
      'warningLight': '#e65100',
      'warningLightHover': '#ef6c00',
      'errorLight': '#b71c1c',
      'errorLightHover': '#c62828',
      'errorThick': '#e57373',
      'errorThickHover': '#ef5350',
      'errorSelect': '#b71c1c',
      'featuredLight': '#4a148c',
      'featuredLightHover': '#6a1b9a',
      'featuredThick': '#ce93d8',
      'featuredThickHover': '#ba68c8',
    },
    'surfaceColorScheme': {
      'primary': '#1e1e1e',
      'primaryHover': '#2a2a2a',
      'layer01': '#1e1e1e',
      'layer01Hover': '#2a2a2a',
      'layer02': '#252525',
      'layer02Hover': '#303030',
      'layer03': '#2a2a2a',
      'layer03Hover': '#353535',
      'layer04': '#303030',
      'layer04Hover': '#383838',
      'inverse': '#e0e0e0',
      'secondary': '#424242',
      'overlay': '#00000080',
    },
    'brandColorScheme': {
      'skyline': '#00b5ff',
      'aqua': '#00c8ff',
      'violet': '#9327ff',
      'amethyst': '#8427e0',
      'berry': '#e3006d',
      'coral': '#fb006d',
      'golden': '#f7931e',
      'amber': '#ffbd00',
      'lemon': '#ffce00',
    },
    'surfaceContainerColorScheme': {
      'layer01': '#1e1e1e',
      'layer02': '#2a2a2a',
      'layer03': '#353535',
    },
    'otherColorsColorScheme': {
      'textHighlight': '#0d47a1',
    },
  };
}
