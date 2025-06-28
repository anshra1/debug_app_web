import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/interfaces/decoder.dart';
import 'package:debug_app_web/core/manager/file_manager/service/file_manager_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

// Mock decoder implementations for testing
class MockJsonDecoder implements Decoder<Map<String, dynamic>> {
  @override
  bool canDecode(File file) => file.path.endsWith('.json');

  @override
  Future<Map<String, dynamic>> decode(File file) async {
    final content = await file.readAsString();
    return jsonDecode(content) as Map<String, dynamic>;
  }
}

class MockFailingDecoder implements Decoder<String> {
  @override
  bool canDecode(File file) => file.path.endsWith('.fail');

  @override
  Future<String> decode(File file) async {
    throw Exception('Simulated decoding failure');
  }
}

// Test model for decoder testing
class TestModel {
  TestModel({required this.name, required this.value});

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        name: json['name'] as String,
        value: json['value'] as int,
      );
  final String name;
  final int value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}

class MockTestModelDecoder implements Decoder<TestModel> {
  @override
  bool canDecode(File file) => file.path.endsWith('.test.json');

  @override
  Future<TestModel> decode(File file) async {
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return TestModel.fromJson(json);
  }
}

void main() {
  group('FileManagerService Fixed Tests', () {
    late Directory tempDir;
    late String testBasePath;
    late FileManagerService fileManager;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('file_manager_test_');
      testBasePath = tempDir.path;
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    group('Fixed Decoder Operations', () {
      setUp(() async {
        fileManager = FileManagerService(defaultBasePath: testBasePath);
        await fileManager.initialize();
      });

      test('should decode all compatible files (order independent)', () async {
        // Create test files
        await File(path.join(testBasePath, 'data1.json'))
            .writeAsString('{"name": "test1", "value": 1}');
        await File(path.join(testBasePath, 'data2.json'))
            .writeAsString('{"name": "test2", "value": 2}');
        await File(path.join(testBasePath, 'data.txt')).writeAsString('text content');

        final decoder = MockJsonDecoder();
        final decodedObjects =
            await fileManager.getAllDecodedContents<Map<String, dynamic>>(
          decoder: decoder,
        );

        expect(decodedObjects.length, equals(2));
        // Check that both expected names are present (order not guaranteed)
        final names = decodedObjects.map((obj) => obj['name'] as String).toList();
        expect(names, containsAll(['test1', 'test2']));
      });
    });

    group('Fixed Error Handling', () {
      test('should throw exception when calling async operations without initialization',
          () async {
        fileManager = FileManagerService(defaultBasePath: testBasePath);

        expect(() => fileManager.getAllFiles(), throwsException);
        await expectLater(
          () => fileManager.createFile('test.txt', 'content'),
          throwsA(isA<Exception>()),
        );
        expect(
          () => fileManager.getAllDecodedContents(decoder: MockJsonDecoder()),
          throwsException,
        );
      });
    });

    group('Fixed Initialization', () {
      test('should initialize with last base path (when no defaultBasePath provided)',
          () async {
        // lastBasePath only works when defaultBasePath is null
        const lastPath = 'last_directory';
        fileManager = FileManagerService(
          lastBasePath: lastPath,
          // Don't provide defaultBasePath so lastBasePath is used
        );
        await fileManager.initialize();

        expect(fileManager.isInitialized, isTrue);
        // The path should contain the last path
        expect(fileManager.currentPath, contains(lastPath));
      });

      test('should ignore lastBasePath when defaultBasePath is provided', () async {
        // This demonstrates the correct behavior: defaultBasePath takes precedence
        const lastPath = 'last_directory';
        fileManager = FileManagerService(
          lastBasePath: lastPath,
          defaultBasePath: testBasePath, // This takes precedence
        );
        await fileManager.initialize();

        expect(fileManager.isInitialized, isTrue);
        // Should use defaultBasePath, not lastBasePath
        expect(fileManager.currentPath, equals(testBasePath));
        expect(fileManager.currentPath, isNot(contains(lastPath)));
      });
    });

    group('Comprehensive File Operations', () {
      setUp(() async {
        fileManager = FileManagerService(defaultBasePath: testBasePath);
        await fileManager.initialize();
      });

      test('should create, copy, move and delete files', () async {
        // Create
        final file = await fileManager.createFile(
          path.join(testBasePath, 'test.txt'),
          'test content',
        );
        expect(file.existsSync(), isTrue);

        // Copy
        final copiedFile = await fileManager.copy(
          file,
          path.join(testBasePath, 'copied.txt'),
        );
        expect(copiedFile.existsSync(), isTrue);
        expect(await copiedFile.readAsString(), equals('test content'));

        // Move
        final movedFile = await fileManager.move(
          copiedFile,
          path.join(testBasePath, 'moved.txt'),
        );
        expect(movedFile.existsSync(), isTrue);
        expect(copiedFile.existsSync(), isFalse);

        // Delete
        await fileManager.delete(file);
        await fileManager.delete(movedFile);
        expect(file.existsSync(), isFalse);
        expect(movedFile.existsSync(), isFalse);
      });
    });
  });
}
