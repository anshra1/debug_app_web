import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/ai_error/to_ai.dart';
import 'package:debug_app_web/ai_error/fingerprint.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  late ToAI errorToAI;
  const baseDir = 'bug_fingerprint';
  late Directory tempDir;

  // To capture clipboard data
  final log = <MethodCall>[];
  String? clipboardData;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    errorToAI = ToAI();
    tempDir = Directory(baseDir);

    // Mock clipboard
    // ignore: deprecated_member_use
    SystemChannels.platform.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      if (methodCall.method == 'Clipboard.setData') {
        clipboardData = (methodCall.arguments as Map)['text'] as String?;
      }
      return null;
    });

    // Clean up before each test
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
    log.clear();
    clipboardData = null;
    SystemChannels.platform.setMockMethodCallHandler(null);
  });

  group(
    'ErrorToAI',
    () {
      test('should create directory and index file for a new error', () async {
        // Arrange
        final error = ArgumentError('A new kind of error');
        final stackTrace = StackTrace.current;

        // Act
        await errorToAI.sendError(error: error, stackTrace: stackTrace);

        // Assert
        final indexFile = File(p.join(baseDir, 'index.json'));
        expect(tempDir.existsSync(), isTrue);
        expect(indexFile.existsSync(), isTrue);
        expect(indexFile.readAsStringSync(), isNot('{}'));
      });

      test('should create an empty solution file for a new error', () async {
        // Arrange
        final error = ArgumentError('A new kind of error');
        final stackTrace = StackTrace.current;
        final fingerprint = FingerprintGenerator.generateFingerprint(error.toString());
        final solutionFile = File(p.join(baseDir, '$fingerprint.txt'));

        // Act
        await errorToAI.sendError(error: error, stackTrace: stackTrace);

        // Assert
        expect(solutionFile.existsSync(), isTrue);
        expect(solutionFile.readAsStringSync(), isEmpty);
      });

      test('should copy correct info to clipboard for a new error', () async {
        // Arrange
        final error = ArgumentError('A new kind of error');
        final stackTrace = StackTrace.current;
        const additionalInfo = 'This happened during a test run.';

        // Act
        await errorToAI.sendError(
          error: error,
          stackTrace: stackTrace,
          additionalInformation: additionalInfo,
        );

        // Assert
        expect(clipboardData, isNotNull);
        expect(clipboardData, contains('🔍 ERROR:'));
        expect(clipboardData, contains(error.toString()));
        expect(clipboardData, contains('🧱 STACK TRACE:'));
        expect(clipboardData, contains('ℹ️ ADDITIONAL INFO:'));
        expect(clipboardData, contains(additionalInfo));
        expect(clipboardData, isNot(contains('✅ SOLUTION:')));
      });

      test('should use existing solution when fingerprint matches', () async {
        // Arrange
        final error = ArgumentError('An error we have seen before');
        final stackTrace = StackTrace.current;
        const solution = 'The solution is to restart the flux capacitor.';
        final fingerprint = FingerprintGenerator.generateFingerprint(error.toString());

        // Setup the existing state
        tempDir.createSync(recursive: true);
        final indexFile = File(p.join(baseDir, 'index.json'));
        final solutionFile = File(p.join(baseDir, '$fingerprint.txt'));

        indexFile.writeAsStringSync(json.encode({fingerprint: '$fingerprint.txt'}));
        solutionFile.writeAsStringSync(solution);

        // Act
        await errorToAI.sendError(error: error, stackTrace: stackTrace);

        // Assert
        expect(clipboardData, isNotNull);
        expect(clipboardData, contains('✅ SOLUTION:'));
        expect(clipboardData, contains(solution));
        expect(clipboardData, contains('🧱 STACK TRACE:'));
        expect(clipboardData, isNot(contains('🔍 ERROR:')));
      });

      test('should not overwrite existing solution file', () async {
        // Arrange
        final error = ArgumentError('An error we have seen before');
        final stackTrace = StackTrace.current;
        const originalSolution = 'This is the original solution.';
        final fingerprint = FingerprintGenerator.generateFingerprint(error.toString());

        // First call to create the file and index
        await errorToAI.sendError(error: error, stackTrace: stackTrace);

        // Manually add a solution
        final solutionFile = File(p.join(baseDir, '$fingerprint.txt'));
        solutionFile.writeAsStringSync(originalSolution);

        // Second call with the same error
        await errorToAI.sendError(error: error, stackTrace: stackTrace);

        // Assert
        expect(solutionFile.readAsStringSync(), originalSolution);
      });
    },
  );
}
