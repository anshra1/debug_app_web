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
  const baseDir = 'bug_fingerprint';
  final tempDir = Directory(baseDir);

  // Function to clean up created files
  void cleanup() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  setUp(cleanup);

  tearDownAll(cleanup);

  testWidgets('triggers error, creates fingerprint files, and handles solution',
      (WidgetTester tester) async {
    // --- Phase 1: Test a new error ---

    final testError = StateError('This is a test integration error!');
    final fingerprint = FingerprintGenerator.generateFingerprint(testError.toString());
    final solutionFile = File(p.join(baseDir, '$fingerprint.txt'));
    final indexFile = File(p.join(baseDir, 'index.json'));

    // Override the default error handler to use our service
    FlutterError.onError = (details) async {
      // In a real app, you might have more complex logic here
      if (details.exception is Error) {
        await errorToAI.sendError(
          error: details.exception as Error,
          stackTrace: details.stack ?? StackTrace.current,
          additionalInformation: 'Error caught by integration test handler.',
        );
      }
    };

    // Build a simple app with a button that throws an error
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  // This action will throw the error we want to test
                  throw testError;
                },
                child: const Text('Throw Error'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to trigger the error
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Allow time for async file operations

    // VERIFY: Directory and index were created
    expect(tempDir.existsSync(), isTrue, reason: 'Base directory should be created');
    expect(indexFile.existsSync(), isTrue, reason: 'Index file should be created');

    // VERIFY: Solution file for the new error was created and is empty
    expect(solutionFile.existsSync(), isTrue, reason: 'Solution file should be created');
    expect(
      solutionFile.readAsStringSync(),
      isEmpty,
      reason: 'New solution file should be empty',
    );

    // VERIFY: Index contains the new fingerprint
    final indexContent =
        json.decode(indexFile.readAsStringSync()) as Map<String, dynamic>;
    expect(
      indexContent.containsKey(fingerprint),
      isTrue,
      reason: 'Index should contain the new fingerprint',
    );

    // --- Phase 2: Test a known error ---

    // Manually add a solution to the file to simulate it being "known"
    const knownSolution = 'The known solution is to turn it off and on again.';
    solutionFile.writeAsStringSync(knownSolution);

    // Tap the button again to trigger the same error
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // VERIFY: This time, the file content should remain unchanged
    expect(
      solutionFile.readAsStringSync(),
      knownSolution,
      reason: 'Known solution should not be overwritten',
    );

    // NOTE: We can't easily verify clipboard content in integration tests,
    // but we have verified that the file system logic works correctly for both new and known errors.
  });
}
