import 'dart:ui';

/// Utility class for converting hex color strings to Color objects and integers
class HexColorConverter {
  /// Converts a hex color string to a Color object
  /// Supports both 6-char (#RRGGBB) and 8-char (#AARRGGBB) formats
  ///
  /// Example:
  /// ```dart
  /// final color = HexColorConverter.hexToColor('#FF0000'); // Red
  /// final colorWithAlpha = HexColorConverter.hexToColor('#80FF0000'); // Semi-transparent red
  /// ```
  static Color hexToColor(String hex) {
    if (!isValidHexColor(hex)) {
      throw ArgumentError('Invalid hex color format: $hex');
    }

    final cleanHex = hex.replaceAll('#', '');

    if (cleanHex.length == 6) {
      // Add full opacity if no alpha channel
      return Color(int.parse('FF$cleanHex', radix: 16));
    } else {
      return Color(int.parse(cleanHex, radix: 16));
    }
  }

  /// Converts a hex color string to an integer value
  /// This is specifically for JSON serialization compatibility
  ///
  /// Example:
  /// ```dart
  /// final colorInt = HexColorConverter.hexToInt('#FF0000'); // 0xFFFF0000
  /// ```
  static int hexToInt(String hex) {
    if (!isValidHexColor(hex)) {
      throw ArgumentError('Invalid hex color format: $hex');
    }

    final cleanHex = hex.replaceAll('#', '');

    if (cleanHex.length == 6) {
      // Add full opacity if no alpha channel
      return int.parse('FF$cleanHex', radix: 16);
    } else {
      return int.parse(cleanHex, radix: 16);
    }
  }

  /// Converts a Color object to a hex string
  ///
  /// Example:
  /// ```dart
  /// final hex = HexColorConverter.colorToHex(Colors.red); // "#FFFF0000"
  /// ```
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Validates if a string is a valid hex color format
  /// Supports both 6-char (#RRGGBB) and 8-char (#AARRGGBB) formats
  ///
  /// Example:
  /// ```dart
  /// final isValid = HexColorConverter.isValidHexColor('#FF0000'); // true
  /// final isInvalid = HexColorConverter.isValidHexColor('red'); // false
  /// ```
  static bool isValidHexColor(String value) {
    if (value.isEmpty || !value.startsWith('#')) {
      return false;
    }

    final cleanHex = value.substring(1);

    // Check if it's a valid hex length (6 or 8 characters)
    if (cleanHex.length != 6 && cleanHex.length != 8) {
      return false;
    }

    // Check if all characters are valid hex
    return RegExp(r'^[0-9A-Fa-f]+$').hasMatch(cleanHex);
  }

  /// Recursively converts hex color strings to integers in a JSON map
  /// This is used for preprocessing JSON data before deserialization
  ///
  /// Example:
  /// ```dart
  /// final json = {'color': '#FF0000', 'nested': {'color2': '#00FF00'}};
  /// final converted = HexColorConverter.convertHexColorsInJson(json);
  /// // Result: {'color': 0xFFFF0000, 'nested': {'color2': 0xFF00FF00}}
  /// ```
  static Map<String, dynamic> convertHexColorsInJson(Map<String, dynamic> json) {
    final result = <String, dynamic>{};

    for (final entry in json.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String && isValidHexColor(value)) {
        // Convert hex string to color integer
        result[key] = hexToInt(value);
      } else if (value is Map<String, dynamic>) {
        // Recursively process nested maps
        result[key] = convertHexColorsInJson(value);
      } else if (value is List) {
        // Process lists (e.g., badgeColors array)
        result[key] = _convertHexColorsInList(value);
      } else {
        // Keep other values as-is
        result[key] = value;
      }
    }

    return result;
  }

  /// Helper method to convert hex colors in a list
  static List<dynamic> _convertHexColorsInList(List<dynamic> list) {
    return list.map((item) {
      if (item is Map<String, dynamic>) {
        return convertHexColorsInJson(item);
      } else if (item is String && isValidHexColor(item)) {
        return hexToInt(item);
      } else {
        return item;
      }
    }).toList();
  }

  /// Validates a color value and throws descriptive errors
  ///
  /// Example:
  /// ```dart
  /// HexColorConverter.validateColor(Colors.red, 'Primary Color');
  /// ```
  static void validateColor(Color color, String colorName) {
    // Get ARGB values
    final alpha = (color.a * 255.0).round() & 0xff;
    final red = (color.r * 255.0).round() & 0xff;
    final green = (color.g * 255.0).round() & 0xff;
    final blue = (color.b * 255.0).round() & 0xff;

    // Validate ranges
    if (alpha < 0 || alpha > 255) {
      throw ArgumentError('$colorName has invalid alpha value: $alpha');
    }

    if (red < 0 || red > 255) {
      throw ArgumentError('$colorName has invalid red value: $red');
    }

    if (green < 0 || green > 255) {
      throw ArgumentError('$colorName has invalid green value: $green');
    }

    if (blue < 0 || blue > 255) {
      throw ArgumentError('$colorName has invalid blue value: $blue');
    }
  }

  /// Creates a color from individual ARGB components with validation
  ///
  /// Example:
  /// ```dart
  /// final color = HexColorConverter.createColorFromARGB(255, 255, 0, 0); // Red
  /// ```
  static Color createColorFromARGB(int alpha, int red, int green, int blue) {
    // Validate input ranges
    if (alpha < 0 || alpha > 255) {
      throw ArgumentError('Alpha must be between 0 and 255, got: $alpha');
    }
    if (red < 0 || red > 255) {
      throw ArgumentError('Red must be between 0 and 255, got: $red');
    }
    if (green < 0 || green > 255) {
      throw ArgumentError('Green must be between 0 and 255, got: $green');
    }
    if (blue < 0 || blue > 255) {
      throw ArgumentError('Blue must be between 0 and 255, got: $blue');
    }

    return Color.fromARGB(alpha, red, green, blue);
  }
}

/// Extension methods for String to provide convenient hex color conversion
extension HexColorString on String {
  /// Converts this hex string to a Color object
  ///
  /// Example:
  /// ```dart
  /// final color = '#FF0000'.toColor(); // Red
  /// ```
  Color toColor() => HexColorConverter.hexToColor(this);

  /// Converts this hex string to an integer
  ///
  /// Example:
  /// ```dart
  /// final colorInt = '#FF0000'.toColorInt(); // 0xFFFF0000
  /// ```
  int toColorInt() => HexColorConverter.hexToInt(this);

  /// Checks if this string is a valid hex color
  ///
  /// Example:
  /// ```dart
  /// final isValid = '#FF0000'.isValidHexColor(); // true
  /// ```
  bool isValidHexColor() => HexColorConverter.isValidHexColor(this);
}

/// Extension methods for Color to provide convenient hex conversion
extension ColorHex on Color {
  /// Converts this color to a hex string
  ///
  /// Example:
  /// ```dart
  /// final hex = Colors.red.toHex(); // "#FFFF0000"
  /// ```
  String toHex() => HexColorConverter.colorToHex(this);

  /// Validates this color and throws descriptive errors if invalid
  ///
  /// Example:
  /// ```dart
  /// Colors.red.validate('Primary Color');
  /// ```
  void validate(String colorName) => HexColorConverter.validateColor(this, colorName);
}
