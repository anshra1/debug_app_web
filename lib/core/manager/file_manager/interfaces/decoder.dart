import 'dart:io';

/// Basic interface for decoding file content into typed Dart objects.
///
/// This simple interface supports tagged registry where multiple decoders
/// can exist for the same type T, differentiated by string keys.
///
/// Example usage:
/// ```dart
/// class JsonThemeDecoder implements Decoder<AppTheme> {
///   @override
///   bool canDecode(File file) => file.path.endsWith('.json');
///
///   @override
///   Future<AppTheme> decode(File file) async {
///     final content = await file.readAsString();
///     return AppTheme.fromJson(jsonDecode(content));
///   }
/// }
/// ```
abstract class Decoder<T> {
  /// Determines if this decoder can handle the given file.
  ///
  /// Check file extensions, content format, or any other criteria
  /// to determine if this decoder can process the file.
  ///
  /// [file] - The file to check for compatibility
  /// Returns true if this decoder can process the file
  bool canDecode(File file);

  /// Decodes the file content into a typed Dart object.
  ///
  /// Read the file, parse its content, and return an instance of type T.
  /// Should throw exceptions if the file format is invalid or decoding fails.
  ///
  /// [file] - The file to decode
  /// Returns the decoded object of type T
  /// Throws exception if decoding fails
  Future<T> decode(File file);
}

/// Optional interface for encoding typed objects back to file content.
///
/// Not required for basic file reading, but useful for saving objects.
abstract class Encoder<T> {
  /// Encodes a typed object into file content.
  ///
  /// [object] - The object to encode
  /// Returns the encoded content as a string
  /// Throws exception if encoding fails
  Future<String> encode(T object);

  /// Returns the preferred file extension for encoded files.
  ///
  /// Used when creating new files of this type.
  String get fileExtension;
}

