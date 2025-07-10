import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/ai_error/to_ai.dart';
import 'package:debug_app_web/ai_error/fingerprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final errorToAI = ToAI();
  const baseDir = '/home/ansh/Studio Projects/Clone/debug_app_web/bug-fingerprint';
  final tempDir = Directory(baseDir);

  // This function is now only for targeted cleanup in setUp
  void cleanup(File solutionFile, File indexFile) {
    if (solutionFile.existsSync()) {
      solutionFile.deleteSync();
    }
    // We only delete the index if we are sure it's from our test
    // A more robust approach might be to read and remove the specific key
    if (indexFile.existsSync()) {
      final indexContent =
          json.decode(indexFile.readAsStringSync()) as Map<String, dynamic>;
      if (indexContent.length == 1) {
        indexFile.deleteSync();
      }
    }
  }

  tearDownAll(() {
    // Do nothing here to persist the directory after tests.
  });

  testWidgets(
      'When a new fingerprint is generated, it creates an entry in index.json and a corresponding .txt file',
      (WidgetTester tester) async {
    // ARRANGE: Define a new, unique error and determine its expected fingerprint and file paths.
    final testError = UnsupportedError('This specific error has never happened before.');
    final fingerprint = FingerprintGenerator.generateFingerprint(testError.toString());
    final solutionFilePath = p.join(baseDir, '$fingerprint.txt');
    final solutionFile = File(solutionFilePath);
    final indexFile = File(p.join(baseDir, 'index.json'));

    // Clean up artifacts from previous runs of *this specific test*
    if (solutionFile.existsSync()) {
      solutionFile.deleteSync();
    }

    // Make JSON file handling more robust
    if (indexFile.existsSync()) {
      final content = indexFile.readAsStringSync();
      if (content.isNotEmpty) {
        final index = json.decode(content) as Map<String, dynamic>;
        if (index.containsKey(fingerprint)) {
          index.remove(fingerprint);
          indexFile.writeAsStringSync(json.encode(index));
        }
      }
    }

    // Set up the global error handler to delegate to our service.
    FlutterError.onError = (details) async {
      if (details.exception is Error) {
        await errorToAI.sendError(
          error: details.exception as Error,
          stackTrace: details.stack ?? StackTrace.current,
        );
      }
    };

    // Build a simple UI to trigger the error.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: () => throw testError,
            child: const Text('Trigger New Error'),
          ),
        ),
      ),
    );

    // ACT: Tap the button to throw the error and trigger the service.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for async file I/O to complete.

    // ASSERT: Verify that both the index.json and the specific .txt file were created as expected.

    // 1. Check that the .txt file for the fingerprint was created.
    expect(
      solutionFile.existsSync(),
      isTrue,
      reason: 'A .txt file for the new fingerprint should be created.',
    );

    // 2. Check that the new .txt file is empty as per requirements.
    expect(
      solutionFile.readAsStringSync(),
      isEmpty,
      reason: 'The new solution .txt file should initially be empty.',
    );

    // 3. Check that the index.json file was also created.
    expect(
      indexFile.existsSync(),
      isTrue,
      reason: 'The index.json file should be created.',
    );

    // 4. Check that index.json contains the new fingerprint and the correct file path.
    final indexContent =
        json.decode(indexFile.readAsStringSync()) as Map<String, dynamic>;
    expect(
      indexContent.containsKey(fingerprint),
      isTrue,
      reason: 'The index.json should contain the new fingerprint key.',
    );
    expect(
      indexContent[fingerprint],
      '$fingerprint.txt',
      reason: 'The value in the index should be the correct filename.',
    );
  });
}
