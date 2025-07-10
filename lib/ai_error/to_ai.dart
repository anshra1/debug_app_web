import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/ai_error/fingerprint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';

class ToAI {
  factory ToAI() => _instance;

  ToAI._internal() {
    _indexFile = File(p.join(_baseDirectory, 'index.json'));
    _initializeSync();
  }
  // Using absolute path for the directory
  final String _baseDirectory =
      '/home/ansh/Studio Projects/Clone/debug_app_web/bug-fingerprint';
  final String _hashFolderPath =
      '/home/ansh/Studio Projects/Clone/debug_app_web/bug-fingerprint/hash_folder';
  final _lock = Lock();
  late final File _indexFile;

  // Singleton pattern
  static final ToAI _instance = ToAI._internal();

  // Synchronous initialization to ensure directory structure exists
  void _initializeSync() {
    try {
      // Create main directory if it doesn't exist
      final dir = Directory(_baseDirectory);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      // Create hash folder if it doesn't exist
      final hashDir = Directory(_hashFolderPath);
      if (!hashDir.existsSync()) {
        hashDir.createSync(recursive: true);
      }

      // Create index.json if it doesn't exist
      if (!_indexFile.existsSync()) {
        _indexFile.writeAsStringSync('{}');
      }
    } catch (e) {
      // Error handling silently
    }
  }

  Future<void> sendError({
    required Object error,
    required StackTrace stackTrace,
    String? additionalInformation,
  }) async {
    if (!kDebugMode) {
      return;
    }

    try {
      // Step 1: Generate fingerprint
      final fingerprint = FingerprintGenerator.generateFingerprint(error);

      // Step 2: Check for existing solution
      final solution = await _checkExistingSolution(fingerprint);

      if (solution != null && solution.isNotEmpty) {
        // Step 3a: Solution exists - copy solution + additional info + stacktrace
        final clipboardContent = _formatExistingSolutionInfo(
          solution: solution,
          stackTrace: stackTrace,
          additionalInfo: additionalInformation,
        );
        await Clipboard.setData(ClipboardData(text: clipboardContent));
      } else {
        // Create empty solution file and update index
        await _lock.synchronized(() async {
          final index = await _readIndex();
          if (!index.containsKey(fingerprint)) {
            // Store fingerprint file in hash folder
            index[fingerprint] = 'hash_folder/$fingerprint.txt';
            await _writeIndex(index);
            await _createNewSolutionFile(fingerprint);
          }
        });

        // Copy error details to clipboard
        final clipboardContent = _formatNewErrorInfo(
          error: error,
          stackTrace: stackTrace,
          additionalInfo: additionalInformation,
        );
        await Clipboard.setData(ClipboardData(text: clipboardContent));
      }
    } on Exception catch (e, _) {
      // Error handling silently
    }
  }

  Future<void> addSolution({
    required String fingerprint,
    required String solution,
  }) async {
    if (!kDebugMode) {
      return;
    }

    await _lock.synchronized(() async {
      try {
        final index = await _readIndex();
        if (index.containsKey(fingerprint)) {
          final relativePath = index[fingerprint] as String;
          final solutionPath = p.join(_baseDirectory, relativePath);
          final solutionFile = File(solutionPath);

          // Check if the file already has content to decide whether to add newlines.
          final isExistingContent = await solutionFile.length() > 0;

          // Format the new solution with a timestamped header.
          final header = '--- SOLUTION ADDED AT ${DateTime.now().toIso8601String()} ---';
          final formattedSolution =
              isExistingContent ? '\n\n$header\n$solution' : '$header\n$solution';

          // Append the new, formatted solution to the file.
          await solutionFile.writeAsString(
            formattedSolution,
            mode: FileMode.append,
          );
        }
      } catch (e) {
        // Error handling silently
      }
    });
  }

  Future<Map<String, dynamic>> _readIndex() async {
    try {
      final content = await _indexFile.readAsString();
      return json.decode(content) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  Future<void> _writeIndex(Map<String, dynamic> index) async {
    try {
      final content = const JsonEncoder.withIndent('  ').convert(index);
      await _indexFile.writeAsString(content);
    } catch (e) {
      // Error handling silently
    }
  }

  Future<String?> _checkExistingSolution(String fingerprint) async {
    try {
      final index = await _readIndex();
      if (index.containsKey(fingerprint)) {
        final relativePath = index[fingerprint] as String;
        final solutionPath = p.join(_baseDirectory, relativePath);
        final solutionFile = File(solutionPath);
        if (await solutionFile.exists()) {
          return await solutionFile.readAsString();
        } else {
          // The file is listed in the index but is missing on disk. Re-create it.
          await _createNewSolutionFile(fingerprint);
          // Return null because the file is new and has no solution content yet.
          return null;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _createNewSolutionFile(String fingerprint) async {
    try {
      final file = File(p.join(_hashFolderPath, '$fingerprint.txt'));
      if (!await file.exists()) {
        await file.create(recursive: true);
      }
    } catch (e) {
      // Error handling silently
    }
  }

  String _formatExistingSolutionInfo({
    required String solution,
    required StackTrace stackTrace,
    String? additionalInfo,
  }) {
    final buffer = StringBuffer()
      ..writeln('✅ POTENTIAL SOLUTION:')
      ..writeln(solution)
      ..writeln()
      ..writeln('🧱 STACK TRACE:')
      ..writeln(stackTrace.toString());

    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('ℹ️ ADDITIONAL INFO:')
        ..writeln(additionalInfo);
    }

    return buffer.toString();
  }

  String _formatNewErrorInfo({
    required Object error,
    required StackTrace stackTrace,
    String? additionalInfo,
  }) {
    final buffer = StringBuffer()
      ..writeln('🔍 ERROR:')
      ..writeln(error.toString())
      ..writeln()
      ..writeln('🧱 STACK TRACE:')
      ..writeln(stackTrace.toString());

    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('ℹ️ ADDITIONAL INFO:')
        ..writeln(additionalInfo);
    }

    return buffer.toString();
  }
}
