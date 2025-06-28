import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/file_manager.dart';
import 'package:debug_app_web/core/manager/file_manager/interfaces/decoder.dart';
import 'package:path/path.dart' as path;

/// Base decoder class with common functionality for file-based decoders.
///
/// Provides utility methods that most decoders will need, such as:
/// - File extension checking
/// - Content reading
/// - Error handling patterns
///
/// Example usage:
/// ```dart
/// class JsonThemeDecoder extends BaseDecoder<AppTheme> {
///   @override
///   List<String> get supportedExtensions => ['.json'];
///
///   @override
///   Future<AppTheme> decodeContent(String content, File file) async {
///     final json = jsonDecode(content);
///     return AppTheme.fromJson(json);
///   }
/// }
/// ```
abstract class BaseDecoder<T> implements Decoder<T> {
  /// List of file extensions this decoder supports.
  ///
  /// Override this in subclasses to specify supported extensions.
  /// Example: ['.json', '.theme.json']
  List<String> get supportedExtensions;

  /// Decodes the raw file content into a typed object.
  ///
  /// Subclasses implement this method to handle the actual parsing logic.
  /// The base class handles file reading and error wrapping.
  ///
  /// [content] - Raw file content as string
  /// [file] - Original file for additional context/error messages
  /// Returns the decoded object of type T
  Future<T> decodeContent(String content, File file);

  @override
  bool canDecode(File file) {
    // Check file extension first (quick filter)
    if (supportedExtensions.isNotEmpty) {
      final fileExtension = path.extension(file.path).toLowerCase();
      if (!supportedExtensions.any((ext) => ext.toLowerCase() == fileExtension)) {
        return false;
      }
    }

    // Check if file exists and is readable
    if (!file.existsSync()) {
      return false;
    }

    // Additional validation can be done by subclasses
    return canDecodeFile(file);
  }

  @override
  Future<T> decode(File file) async {
    try {
      // Validate that we can decode this file
      if (!canDecode(file)) {
        throw Exception('Cannot decode file: ${file.path}');
      }

      // Read file content
      final content = await file.readAsString();

      // Validate content is not empty
      if (content.trim().isEmpty) {
        throw Exception('File is empty: ${file.path}');
      }

      // Delegate to subclass for actual decoding
      return await decodeContent(content, file);
    } catch (e) {
      throw Exception('Failed to decode ${file.path}: $e');
    }
  }

  /// Additional file validation that subclasses can override.
  ///
  /// This is called after basic extension and existence checks.
  /// Subclasses can add content-specific validation here.
  ///
  /// [file] - The file to validate
  /// Returns true if the file can be decoded
  bool canDecodeFile(File file) {
    return true; // Default: accept all files that pass extension check
  }

  /// Helper method to safely read JSON-like content.
  ///
  /// Validates that the content looks like valid JSON before parsing.
  bool looksLikeJson(String content) {
    final trimmed = content.trim();
    return (trimmed.startsWith('{') && trimmed.endsWith('}')) ||
        (trimmed.startsWith('[') && trimmed.endsWith(']'));
  }

  /// Helper method to get file name without extension.
  String getFileNameWithoutExtension(File file) {
    final fileName = path.basename(file.path);
    final lastDotIndex = fileName.lastIndexOf('.');
    return lastDotIndex != -1 ? fileName.substring(0, lastDotIndex) : fileName;
  }

  /// Helper method to get relative path from a base directory.
  String getRelativePath(File file, String baseDirectory) {
    return path.relative(file.path, from: baseDirectory);
  }
}
