import 'dart:io';

import 'package:debug_app_web/core/manager/file_manager/interfaces/decoder.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileManagerService {
  /// Creates a new FileManagerService instance.
  ///
  /// [lastBasePath] - The last used base path, if any
  /// [defaultBasePath] - Optional default base path to use if no last path exists
  FileManagerService({
    this.lastBasePath,
    String? defaultBasePath,
  }) : _defaultBasePath = defaultBasePath;

  /// Registry for managing decoders and encoders

  final String? _defaultBasePath;

  /// Default base path for file operations

  final String? lastBasePath;

  /// Cached resolved base path
  late String? _resolvedBasePath;

  /// Whether the service has been initialized
  bool _isInitialized = false;

  /// Should be called once during app startup.
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Resolve the base path
    _resolvedBasePath = _defaultBasePath ?? await _getDefaultBasePath();

    // Ensure the base directory exists
    final baseDir = Directory(_resolvedBasePath!);
    if (!baseDir.existsSync()) {
      baseDir.createSync(recursive: true);
    }

    _isInitialized = true;
  }

  /// Gets the platform-appropriate default base path using path_provider
  Future<String> _getDefaultBasePath() async {
    const appName = 'ErrorTracker Pro';
    final lastBasePath = this.lastBasePath ?? '';

    try {
      final appDir = await getApplicationDocumentsDirectory();
      return path.join(appDir.path, appName, lastBasePath);
    } catch (e) {
      // Fallback logic in case path_provider fails
      if (Platform.isAndroid || Platform.isIOS) {
        throw Exception('Failed to get application directory: $e');
      }

      // Fallback for desktop platforms
      if (Platform.isWindows) {
        final appData = Platform.environment['APPDATA'];
        return path.join(appData ?? '', appName, lastBasePath);
      } else if (Platform.isMacOS) {
        final home = Platform.environment['HOME'];
        return path.join(
          home ?? '',
          'Library',
          'Application Support',
          appName,
          lastBasePath,
        );
      } else if (Platform.isLinux) {
        final home = Platform.environment['HOME'];
        return path.join(home ?? '', '.config', appName, lastBasePath);
      }

      // Last resort fallback
      return path.join(Directory.current.path, lastBasePath);
    }
  }

  /// Checks if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Gets the current file path.
  ///
  /// Returns the resolved base path if initialized, otherwise throws an exception.
  String get currentPath {
    _ensureInitialized();
    return _resolvedBasePath!;
  }

  /// Gets all files in a directory and its subdirectories.

  /// [directoryPath] - Optional path to the directory to scan. If not provided, uses the base path
  /// [recursive] - Whether to scan subdirectories (default: true)
  /// [extensions] - Optional filter by file extensions (e.g., ['.json', '.yaml'])
  /// Returns a list of all matching files
  Future<List<File>> getAllFiles({
    String? directoryPath,
    bool recursive = true,
    List<String>? extensions,
  }) async {
    _ensureInitialized();

    final directory = Directory(directoryPath ?? _resolvedBasePath!);

    if (!directory.existsSync()) {
      throw Exception('Directory not found: ${directory.path}');
    }

    final files = <File>[];
    final stream = directory.list(recursive: recursive);

    await for (final entity in stream) {
      if (entity is File) {
        // Filter by extensions if provided
        if (extensions != null && extensions.isNotEmpty) {
          final fileExtension = path.extension(entity.path).toLowerCase();
          if (extensions.any((ext) => ext.toLowerCase() == fileExtension)) {
            files.add(entity);
          }
        } else {
          files.add(entity);
        }
      }
    }

    return files;
  }

  /// Copies a file from source to destination.
  Future<File> copy(File source, String destinationPath, {bool overwrite = false}) async {
    final destination = File(destinationPath);

    if (destination.existsSync() && !overwrite) {
      throw Exception('Destination already exists: $destinationPath');
    }

    // Ensure destination directory exists
    final destinationDir = Directory(path.dirname(destinationPath));
    if (!destinationDir.existsSync()) {
      await destinationDir.create(recursive: true);
    }

    return source.copy(destinationPath);
  }

  /// Deletes a file from the file system.
  Future<bool> delete(File file) async {
    if (!file.existsSync()) {
      throw Exception('File not found: ${file.path}');
    }

    await file.delete();
    return true;
  }

  /// Moves a file from current location to a new location.
  Future<File> move(File file, String newPath, {bool overwrite = false}) async {
    final newFile = await copy(file, newPath, overwrite: overwrite);
    await delete(file);
    return newFile;
  }

  /// Creates a new file with the given content.
  Future<File> createFile(
    String filePath,
    String content, {
    bool overwrite = false,
  }) async {
    final file = File(filePath);

    if (file.existsSync() && !overwrite) {
      throw Exception('File already exists: $filePath');
    }

    // Ensure parent directory exists
    final parentDir = Directory(path.dirname(filePath));
    if (!parentDir.existsSync()) {
      await parentDir.create(recursive: true);
    }

    return file.writeAsString(content);
  }

  /// Gets all decodable files of type T from a directory.
  ///
  /// [decoder] - The decoder to use for converting files to type T
  /// [directoryPath] - Directory to scan (optional, uses base path if not provided)
  /// [recursive] - Whether to scan subdirectories (default: true)
  /// Returns a list of decoded objects of type T
  Future<List<T>> getAllDecodedContents<T>({
    required Decoder<T> decoder,
    String? directoryPath,
    bool recursive = true,
  }) async {
    _ensureInitialized();

    // Use provided directory or default
    final targetDirectory = directoryPath ?? _resolvedBasePath!;

    // Get all files
    final files = await getAllFiles(
      directoryPath: targetDirectory,
      recursive: recursive,
    );

    // Try to decode files with the provided decoder
    final decodedObjects = <T>[];
    for (final file in files) {
      if (decoder.canDecode(file)) {
        try {
          final decodedObject = await decoder.decode(file);
          decodedObjects.add(decodedObject);
        } on Exception catch (e) {
          debugPrint('Warning: Decoder failed for file ${file.path}: $e');
        }
      }
    }

    return decodedObjects;
  }

  /// Finds the first decoded object of type T that matches the predicate.
  ///
  /// [decoder] - The decoder to use for converting files to type T
  /// [predicate] - Function that returns true for the desired object
  /// [directoryPath] - Directory to scan (optional, uses base path if not provided)
  /// [recursive] - Whether to scan subdirectories (default: true)
  /// Returns the first matching object or null if none found
  Future<T?> findDecodedWhere<T>(
    bool Function(T) predicate, {
    required Decoder<T> decoder,
    String? directoryPath,
    bool recursive = true,
  }) async {
    final allContents = await getAllDecodedContents<T>(
      decoder: decoder,
      directoryPath: directoryPath,
      recursive: recursive,
    );

    for (final content in allContents) {
      if (predicate(content)) {
        return content;
      }
    }

    return null;
  }

  /// Imports a file from an external path into the FileManager's resolved base path.
  ///
  /// [sourceFile] - The external file to import.
  /// [newFileName] - Optional new name for the file (default: original name).
  /// [subDirectory] - Optional subdirectory inside the base path.
  /// [overwrite] - Whether to overwrite if the file already exists (default: false).
  ///
  /// Returns the copied file in the base path.
  Future<File> importFileIntoManager(
    File sourceFile, {
    String? newFileName,
    String? subDirectory,
    bool overwrite = false,
  }) async {
    _ensureInitialized();

    if (!sourceFile.existsSync()) {
      throw Exception('Source file not found: ${sourceFile.path}');
    }

    // Resolve the target directory inside _resolvedBasePath
    var targetDirPath = _resolvedBasePath!;
    if (subDirectory != null && subDirectory.trim().isNotEmpty) {
      targetDirPath = path.join(_resolvedBasePath!, subDirectory.trim());
    }

    final targetDirectory = Directory(targetDirPath);
    if (!targetDirectory.existsSync()) {
      await targetDirectory.create(recursive: true);
    }

    // Resolve the final file name
    final fileName = newFileName ?? path.basename(sourceFile.path);
    final destinationPath = path.join(targetDirPath, fileName);

    // Use the existing copy() logic (with overwrite)
    return copy(sourceFile, destinationPath, overwrite: overwrite);
  }

  /// Imports a folder and all its contents into the FileManager's resolved base path.
  ///
  /// [sourceDirectory] - The folder to import.
  /// [targetFolderName] - Optional new name for the folder in the managed space.
  /// [subDirectory] - Optional subdirectory inside the base path.
  /// [overwrite] - Whether to overwrite files if they already exist (default: false).
  ///
  /// Returns the target directory where files were copied.
  Future<Directory> importFolderSaveIntoDirectory(
    Directory sourceDirectory, {
    String? targetFolderName,
    String? subDirectory,
    bool overwrite = false,
  }) async {
    _ensureInitialized();

    if (!sourceDirectory.existsSync()) {
      throw Exception('Source directory not found: ${sourceDirectory.path}');
    }

    // Resolve destination base folder
    var baseTargetDir = _resolvedBasePath!;
    if (subDirectory != null && subDirectory.trim().isNotEmpty) {
      baseTargetDir = path.join(baseTargetDir, subDirectory.trim());
    }

    // Create the full destination directory path
    final folderName = targetFolderName ?? path.basename(sourceDirectory.path);
    final destinationRoot = path.join(baseTargetDir, folderName);
    final destinationDir = Directory(destinationRoot);
    if (!destinationDir.existsSync()) {
      await destinationDir.create(recursive: true);
    }

    // Start recursive copy
    await for (final entity in sourceDirectory.list(recursive: true)) {
      if (entity is File) {
        final relativePath = path.relative(entity.path, from: sourceDirectory.path);
        final destinationPath = path.join(destinationRoot, relativePath);

        final destinationFile = File(destinationPath);
        final destinationParent = destinationFile.parent;
        if (!destinationParent.existsSync()) {
          await destinationParent.create(recursive: true);
        }

        if (!destinationFile.existsSync() || overwrite) {
          await entity.copy(destinationPath);
        }
      }
    }

    return Directory(destinationRoot);
  }

  // ==========================================
  // Utility Methods
  // ==========================================

  /// Checks if a file exists at the given path.
  bool exists(String filePath) {
    return File(filePath).existsSync();
  }

  /// Gets file information (size, modified date, etc.)
  FileStat getFileStats(String filePath) {
    return File(filePath).statSync();
  }

  // ==========================================
  // Private Helper Methods
  // ==========================================

  /// Ensures the service is initialized before operations.
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('FileManagerService not initialized. Call initialize() first.');
    }
  }
}
