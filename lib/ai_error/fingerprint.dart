import 'dart:convert';

import 'package:crypto/crypto.dart';

class FingerprintGenerator {
  static String generateFingerprint(Object errorBlock) {
    final flutterErrorLine = extractFlutterErrorLine(errorBlock.toString());
    final normalized = normalizeFlutterError(flutterErrorLine);
  
    return sha1Hash(normalized);
  }

  static String extractFlutterErrorLine(String block) {
    
    final lines = block.split('\n');
    String? firstLine;
    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.startsWith('Flutter error:')) {
        return trimmedLine;
      }
      if (firstLine == null && trimmedLine.isNotEmpty) {
        firstLine = trimmedLine;
      }
    }
    return firstLine ?? 'Flutter error: Unknown error';
  }

  static String normalizeFlutterError(String errorLine) {
   
    return errorLine
        .replaceAll(RegExp("'[^']*'"), '') // remove single quotes
        .replaceAll(RegExp('"[^"]*"'), '') // remove double quotes
        .replaceAll(RegExp(r'\d+'), '') // remove all numbers
        .replaceAll(RegExp(r'package:[^)\s]+'), '') // remove package refs
        .replaceAll(RegExp(r'[\\/]([\w._-]+[/\\])+[\w._-]+\.dart'), '') // remove paths
        .replaceAll(RegExp(r':\d+:\d+'), '') // remove line/column info
        .replaceAll(RegExp(r'\s+'), ' ') // normalize spaces
        .trim()
        .toLowerCase();
  }

  static String sha1Hash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }
}
