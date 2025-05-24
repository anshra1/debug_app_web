// File: bin/test_generator.dart
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Show this help message',
    )
    ..addFlag(
      'force',
      abbr: 'f',
      negatable: false,
      help: 'Force overwrite existing test file',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show verbose output',
    );

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool || results.rest.isEmpty) {
      printUsage(parser);
      exit(0);
    }

    final filePath = results.rest.first;
    final generator = TestGenerator(
      force: results['force'] as bool,
      verbose: results['verbose'] as bool,
    )..generateTest(filePath);
  } catch (e) {
    print('Error: $e');
    printUsage(parser);
    exit(1);
  }
}

void printUsage(ArgParser parser) {
  print('Usage: dart run test_generator.dart [options] <file_path>');
  print(parser.usage);
}

class TestGenerator {
  TestGenerator({
    this.force = false,
    this.verbose = false,
  });
  final bool force;
  final bool verbose;

  void generateTest(String sourcePath) {
    if (!File(sourcePath).existsSync()) {
      throw 'Source file not found: $sourcePath';
    }

    final sourceFile = File(sourcePath);
    final testFile = _getTestFilePath(sourcePath);

    if (verbose) {
      print('Source file: $sourcePath');
      print('Test file path: ${testFile.path}');
    }

    if (testFile.existsSync() && !force) {
      print('\x1B[33mTest file already exists: ${testFile.path}\x1B[0m');
      print('Use --force to overwrite the existing test file.');
      return;
    }

    final className = _getClassName(sourcePath);
    final content = _generateTestContent(sourcePath, className);

    // Create test directory if it doesn't exist
    testFile.parent.createSync(recursive: true);

    // Write test file
    testFile.writeAsStringSync(content);
    print('\x1B[32mGenerated test file: ${testFile.path}\x1B[0m');
  }

  File _getTestFilePath(String sourcePath) {
    // Get the project root directory (assuming the script is run from project root)
    final projectDir = Directory.current.path;

    // Get the relative path from the project root to the source file
    final relativeSourcePath = path.relative(sourcePath, from: projectDir);

    // Create test file path in test directory maintaining the source file structure
    final sourceFileName = path.basename(sourcePath);
    final sourceDir = path.dirname(relativeSourcePath);

    // Remove 'lib' from the path if present
    final testSubDir = sourceDir.startsWith('lib/') ? sourceDir.substring(4) : sourceDir;

    final baseName = path.basenameWithoutExtension(sourceFileName);
    final testFileName = '${baseName}_test.dart';

    // Combine paths to create the test file path
    return File(
      path.join(
        projectDir,
        'test',
        testSubDir,
        testFileName,
      ),
    );
  }

  String _getClassName(String filePath) {
    final baseName = path.basenameWithoutExtension(filePath);
    // Convert snake_case or kebab-case to PascalCase
    final words = baseName.split(RegExp('[_-]'));
    return words.map((word) => word[0].toUpperCase() + word.substring(1)).join();
  }

  String _generateTestContent(String sourcePath, String className) {
    // Get the relative path from the test file to the source file
    final projectDir = Directory.current.path;
    final relativeSourcePath = path.relative(sourcePath, from: projectDir);

    // Adjust import path based on the test file location
    final importPath = relativeSourcePath.startsWith('lib/')
        ? relativeSourcePath.substring(4) // Remove 'lib/' prefix
        : relativeSourcePath;

    return '''import 'package:test/test.dart';
import 'package:${_getPackageName()}/$importPath';

void main() {
  group('$className', () {
    setUp(() {
      // Set up test fixtures before each test
    });

    tearDown(() {
      // Clean up after each test
    });

    test('should pass initial test', () {
      expect(true, isTrue);
    });

    // Add more test cases here
    
  });
}
''';
  }

  String _getPackageName() {
    // Read pubspec.yaml to get package name
    final pubspecFile = File('pubspec.yaml');
    if (!pubspecFile.existsSync()) {
      return 'app';
    }

    final content = pubspecFile.readAsStringSync();
    final nameMatch = RegExp(r'name:\s*([^\s]+)').firstMatch(content);
    return nameMatch?.group(1) ?? 'app';
  }
}
