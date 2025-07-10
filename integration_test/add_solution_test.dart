import 'dart:async';
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

  tearDownAll(() {
    // We are keeping the files for inspection, so no cleanup.
  });

  testWidgets(
      'addSolution method correctly writes a solution to an existing fingerprint file',
      (WidgetTester tester) async {
    // ARRANGE
    final errorHandled = Completer<void>();
    final testError = UnsupportedError(
      'This is the error for which we will provide a solution.',
    );
    final fingerprint = FingerprintGenerator.generateFingerprint(testError.toString());
    final solutionFilePath = p.join(baseDir, '$fingerprint.txt');
    final solutionFile = File(solutionFilePath);

    // Clean up from previous specific test runs.
    if (solutionFile.existsSync()) {
      solutionFile.deleteSync();
    }

    // Build the UI.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: () async {
              try {
                throw testError;
              } on Error catch (e, stackTrace) {
                // Directly call the service instead of relying on global handler
                await errorToAI.sendError(error: e, stackTrace: stackTrace);
                errorHandled.complete();
              }
            },
            child: const Text('Trigger Error for Solution Test'),
          ),
        ),
      ),
    );

    // ACT 1: Trigger the error to create the empty file.
    await tester.tap(find.byType(ElevatedButton));
    await errorHandled.future; // Wait for the async onPressed to finish

    // ASSERT 1: Verify the file was created and is empty.
    expect(
      solutionFile.existsSync(),
      isTrue,
      reason: 'The solution file should be created first.',
    );
    expect(
      solutionFile.readAsStringSync(),
      isEmpty,
      reason: 'The solution file should be initially empty.',
    );

    // ACT 2: Call the addSolution method to write to the file.
    const solutionText = 'The official solution is to consult the user manual.';
    await errorToAI.addSolution(
      fingerprint: fingerprint,
      solution: solutionText,
    );

    await tester.pumpAndSettle();

    // ASSERT 2: Read the file and verify its content matches the solution.
    expect(
      solutionFile.existsSync(),
      isTrue,
      reason: 'The solution file should still exist after writing to it.',
    );
    expect(
      solutionFile.readAsStringSync(),
      solutionText,
      reason: 'The file content should match the provided solution.',
    );
  });
}
