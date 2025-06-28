import 'package:flutter/material.dart';

/// Semantic, scalable, and theme-safe color system.
/// Based on Material 3 Design Tokens, ready for component mapping.

class LightColors {
  LightColors();

  // === Brand Colors ===

  /// Use for:
  /// - `ElevatedButton`, `FAB`, toggles
  /// - `TabBar` indicator
  /// - Selected state in components
  final primary = const Color(0xFF005AC1);

  /// Text or icon on primary bg (e.g. on ElevatedButton)
  final onPrimary = const Color(0xFFFFFFFF);

  /// Background fill for branded components:
  /// - `Card` with brand color
  /// - `FilledButton` background
  final primaryContainer = const Color(0xFFD8E2FF);

  /// Text/icon on `primaryContainer`
  final onPrimaryContainer = const Color(0xFF001A41);

  // === Secondary Colors ===

  /// Used for:
  /// - `OutlinedButton` border
  /// - Chips, accents, tabs
  final secondary = const Color(0xFF4C5F80);

  /// Text/icon on `secondary`
  final onSecondary = const Color(0xFFFFFFFF);

  /// Background for:
  /// - Chips
  /// - Tag-style UI
  final secondaryContainer = const Color(0xFFD6E3F8);

  /// Text/icon on `secondaryContainer`
  final onSecondaryContainer = const Color(0xFF071E35);


  // === Error Colors ===

  /// Use for:
  /// - Error icons
  /// - Text fields with error
  /// - Snackbar/Alert backgrounds
  final error = const Color(0xFFBA1A1A);

  /// Text/icon on `error`
  final onError = const Color(0xFFFFFFFF);

  /// Background for error containers (e.g. cards/snackbars)
  final errorContainer = const Color(0xFFFFDAD6);

  /// Text/icon on `errorContainer`
  final onErrorContainer = const Color(0xFF410002);

  // === Neutral / Surfaces ===

  /// App's scaffold background
  /// Used in `Scaffold`, `Modal`, `BottomSheet`
  final background = const Color(0xFFFDFDFD);

  /// Text/icon on `background`
  final onBackground = const Color(0xFF1B1B1F);

  /// For cards, dialogs, surfaces inside background
  final surface = const Color(0xFFFFFFFF);

  /// Text/icon on `surface`
  final onSurface = const Color(0xFF1B1B1F);

  /// Used for variants of surface like `Divider`, `Card` border
  final surfaceVariant = const Color(0xFFE0E0E0);

  // === Outline & Shadows ===

  /// Borders for inputs, containers, outlines, dividers
  final outline = const Color(0xFF79747E);

  /// Shadow for elevated widgets like `Card`, `Menu`, `Dialog`
  final shadow = const Color(0xFF000000);

  // === Disabled States ===

  /// Background for disabled buttons, text fields, etc.
  final disabled = const Color(0xFFE0E0E0);

  /// Text/icons on `disabled` bg
  final onDisabled = const Color(0xFF9E9E9E);

  // === Inverse (for dark-on-light or toast-on-appbar)

  /// Surface for reversed color context (e.g. top bar over light theme)
  final inverseSurface = const Color(0xFF2F3033);

  /// Text/icons on `inverseSurface`
  final inverseOnSurface = const Color(0xFFF1F1F1);

  /// Brand color used on dark surface (e.g., `SnackBar`, inverted states)
  final inversePrimary = const Color(0xFFAFC6FF);

  // === Focus / Feedback ===

  /// Focus ring or ripple effect (interactive feedback)
  final focus = const Color(0xFF005AC1).withOpacity(0.3);
}
