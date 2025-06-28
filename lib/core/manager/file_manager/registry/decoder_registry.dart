// import 'package:debug_app_web/core/services/file_manager/interfaces/decoder.dart';

// /// Simple registry for managing multiple decoders per type with string keys.
// ///
// /// This allows you to register different decoders for the same type using tags:
// /// - Format-based: 'json', 'yaml', 'xml'
// /// - Version-based: 'v1', 'v2', 'legacy'
// /// - Source-based: 'local', 'remote', 'plugin'
// ///
// /// Usage example:
// /// ```dart
// /// final registry = DecoderRegistry.instance;
// ///
// /// // Register multiple decoders for AppTheme
// /// registry.register<AppTheme>('json', JsonThemeDecoder());
// /// registry.register<AppTheme>('yaml', YamlThemeDecoder());
// /// registry.register<AppTheme>('legacy', LegacyThemeDecoder());
// ///
// /// // Use specific decoder
// /// final decoder = registry.get<AppTheme>('json');
// /// final themes = await decoder.decode(file);
// /// ```
// class DecoderRegistry {
//   /// Factory constructor that returns the singleton
//   factory DecoderRegistry() => _instance;

//   /// Private constructor for singleton pattern
//   DecoderRegistry._();

//   /// Singleton instance of the registry
//   static final DecoderRegistry _instance = DecoderRegistry._();

//   /// Access to the singleton instance
//   static DecoderRegistry get instance => _instance;

//   // ==========================================
//   // Private Storage
//   // ==========================================

//   /// Storage structure: Type -> (Key -> Decoder)
//   /// Example: {AppTheme: {'json': JsonThemeDecoder, 'yaml': YamlThemeDecoder}}
//   final Map<Type, Map<String, Decoder<dynamic>>> _decoders = {};

//   /// Storage structure: Type -> (Key -> Encoder)
//   final Map<Type, Map<String, Encoder<dynamic>>> _encoders = {};

//   /// Default keys for each type (used when no key is specified)
//   final Map<Type, String> _defaultKeys = {};

//   // ==========================================
//   // Registration Methods
//   // ==========================================

//   /// Registers a decoder for type T with the given key.
//   ///
//   /// [key] - String identifier for this decoder ('json', 'yaml', etc.)
//   /// [decoder] - The decoder instance for type T
//   /// [setAsDefault] - Whether this should be the default decoder for type T
//   ///
//   /// Example:
//   /// ```dart
//   /// registry.register<AppTheme>('json', JsonThemeDecoder(), setAsDefault: true);
//   /// registry.register<AppTheme>('yaml', YamlThemeDecoder());
//   /// ```
//   void register<T>(String key, Decoder<T> decoder, {bool setAsDefault = false}) {
//     // Initialize type map if it doesn't exist
//     _decoders.putIfAbsent(T, () => {});

//     // Store the decoder
//     _decoders[T]![key] = decoder;

//     // Set as default if requested or if it's the first decoder for this type
//     if (setAsDefault || _defaultKeys[T] == null) {
//       _defaultKeys[T] = key;
//     }
//   }

//   /// Registers an encoder for type T with the given key.
//   ///
//   /// [key] - String identifier for this encoder (usually matches decoder key)
//   /// [encoder] - The encoder instance for type T
//   void registerEncoder<T>(String key, Encoder<T> encoder) {
//     _encoders.putIfAbsent(T, () => {});
//     _encoders[T]![key] = encoder;
//   }

//   /// Registers both decoder and encoder with the same key.
//   ///
//   /// Convenience method for when you have matching decoder/encoder pairs.
//   void registerPair<T>(
//     String key,
//     Decoder<T> decoder,
//     Encoder<T> encoder, {
//     bool setAsDefault = false,
//   }) {
//     register<T>(key, decoder, setAsDefault: setAsDefault);
//     registerEncoder<T>(key, encoder);
//   }

//   // ==========================================
//   // Retrieval Methods
//   // ==========================================

//   /// Gets the decoder for type T with the specified key.
//   ///
//   /// [key] - The decoder key to retrieve
//   /// Returns the decoder instance or null if not found
//   Decoder<T>? get<T>(String key) {
//     return _decoders[T]?[key] as Decoder<T>?;
//   }

//   /// Gets the default decoder for type T.
//   ///
//   /// Returns the decoder marked as default, or null if none registered.
//   Decoder<T>? getDefault<T>() {
//     final defaultKey = _defaultKeys[T];
//     if (defaultKey == null) return null;
//     return get<T>(defaultKey);
//   }

//   /// Gets the encoder for type T with the specified key.
//   ///
//   /// [key] - The encoder key to retrieve
//   /// Returns the encoder instance or null if not found
//   Encoder<T>? getEncoder<T>(String key) {
//     return _encoders[T]?[key] as Encoder<T>?;
//   }

//   /// Gets a decoder by key, falling back to default if key not found.
//   ///
//   /// [key] - Preferred decoder key
//   /// Returns the requested decoder, default decoder, or null
//   Decoder<T>? getOrDefault<T>(String? key) {
//     if (key != null) {
//       final decoder = get<T>(key);
//       if (decoder != null) return decoder;
//     }
//     return getDefault<T>();
//   }

//   // ==========================================
//   // Query Methods
//   // ==========================================

//   /// Gets all available keys for type T.
//   ///
//   /// Returns a list of all registered decoder keys for the type.
//   List<String> getKeys<T>() {
//     return _decoders[T]?.keys.toList() ?? [];
//   }

//   /// Gets all available encoder keys for type T.
//   List<String> getEncoderKeys<T>() {
//     return _encoders[T]?.keys.toList() ?? [];
//   }

//   /// Checks if a decoder exists for type T with the given key.
//   bool hasDecoder<T>(String key) {
//     return _decoders[T]?.containsKey(key) ?? false;
//   }

//   /// Checks if an encoder exists for type T with the given key.
//   bool hasEncoder<T>(String key) {
//     return _encoders[T]?.containsKey(key) ?? false;
//   }

//   /// Checks if any decoders are registered for type T.
//   bool hasAnyDecoder<T>() {
//     return _decoders[T]?.isNotEmpty ?? false;
//   }

//   /// Gets the default key for type T.
//   String? getDefaultKey<T>() {
//     return _defaultKeys[T];
//   }

//   /// Gets all registered types that have decoders.
//   List<Type> get registeredTypes => _decoders.keys.toList();

//   // ==========================================
//   // Management Methods
//   // ==========================================

//   /// Removes a decoder by type and key.
//   ///
//   /// [key] - The decoder key to remove
//   /// Returns true if the decoder was removed, false if not found
//   bool removeDecoder<T>(String key) {
//     final typeMap = _decoders[T];
//     if (typeMap == null) return false;

//     final removed = typeMap.remove(key) != null;

//     // If this was the default, clear the default (or set a new one)
//     if (_defaultKeys[T] == key) {
//       if (typeMap.keys.isNotEmpty) {
//         _defaultKeys[T] = typeMap.keys.first;
//       } else {
//         _defaultKeys.remove(T);
//       }
//     }

//     return removed;
//   }

//   /// Removes an encoder by type and key.
//   bool removeEncoder<T>(String key) {
//     return _encoders[T]?.remove(key) != null;
//   }

//   /// Sets the default decoder key for type T.
//   ///
//   /// The key must already be registered.
//   /// Returns true if successful, false if key doesn't exist.
//   bool setDefault<T>(String key) {
//     if (!hasDecoder<T>(key)) return false;
//     _defaultKeys[T] = key;
//     return true;
//   }

//   /// Clears all decoders and encoders for type T.
//   void clearType<T>() {
//     _decoders.remove(T);
//     _encoders.remove(T);
//     _defaultKeys.remove(T);
//   }

//   /// Clears all registered decoders and encoders.
//   ///
//   /// Useful for testing or resetting the registry.
//   void clear() {
//     _decoders.clear();
//     _encoders.clear();
//     _defaultKeys.clear();
//   }

//   // ==========================================
//   // Debug and Info Methods
//   // ==========================================

//   /// Gets debugging information about the registry state.
//   ///
//   /// Returns a map with current registration status.
//   Map<String, dynamic> getDebugInfo() {
//     return {
//       'totalTypes': _decoders.length,
//       'totalDecoders': _decoders.values.fold(0, (sum, map) => sum + map.length),
//       'totalEncoders': _encoders.values.fold(0, (sum, map) => sum + map.length),
//       'registeredTypes': _decoders.keys.map((type) => type.toString()).toList(),
//       'defaultKeys': _defaultKeys.map((type, key) => MapEntry(type.toString(), key)),
//       'decodersByType': _decoders.map(
//         (type, decoders) => MapEntry(
//           type.toString(),
//           decoders.keys.toList(),
//         ),
//       ),
//     };
//   }

//   /// Validates the registry state.
//   ///
//   /// Checks for common issues like missing defaults.
//   /// Returns a list of validation warnings.
//   List<String> validate() {
//     final warnings = <String>[];

//     for (final type in _decoders.keys) {
//       final decoders = _decoders[type]!;

//       // Check if type has decoders but no default
//       if (decoders.isNotEmpty && _defaultKeys[type] == null) {
//         warnings.add('Type $type has decoders but no default key');
//       }

//       // Check if default key exists
//       final defaultKey = _defaultKeys[type];
//       if (defaultKey != null && !decoders.containsKey(defaultKey)) {
//         warnings.add('Type $type has invalid default key: $defaultKey');
//       }
//     }

//     return warnings;
//   }
// }
