import 'package:flutter/material.dart' show Color, Colors;

class DarkColorsToken {
  // Background color for the entire app (used in Scaffold -> scaffoldBackgroundColor)
  static const Color scaffoldBackgroundColor = Color(0xff1f654f);

  // Primary brand color (used in ElevatedButton, Toggle switches, active icons)
  static const Color primaryColor = Color(0xff1e5dd2);

  // Slightly lighter primary for containers (used in ColorScheme.primaryContainer)
  // Filled buttons, chips, nav bars, sliders (when using primary as base)
  static const Color primaryContainer = Color(0xff4c7eea);

  // Light variant of secondary (used in ColorScheme.secondaryContainer)
  //Chips, toggles, rails, segments (when using secondary accent elements)
  static const Color secondryContainerColor = Color(0xff66fff9);

  

  // Primary text color (used across the app on dark backgrounds)
  static const Color textPrimary = Colors.white;

  // Accent color (used in FloatingActionButton, Switch active thumb, icons)
  static const Color secondary = Color(0xff03dac6);

  // Error state color (used in InputDecorationTheme.errorBorder, validation messages)
  static const Color error = Color(0xffcf6679);

  // Text/icon color that sits on top of secondary-colored elements
  static const Color textInverse = Colors.black;

  // Success status color (used in badges, notifications, status indicators)
  static const Color success = Color(0xFF66BB6A);

  // Warning status color (used in alerts, warning chips, banners)
  static const Color warning = Color(0xFFFFB74D);

  // Informational status color (used in banners, helper text, chips)
  static const Color info = Color(0xFF64B5F6);

  // Divider and outline border color (used in InputDecorationTheme, ListTile dividers)
  static const Color border = Color(0xFF373737);

  // Background color for input fields (used in InputDecorationTheme.fillColor)
  static const Color backgroundSecondary = Color(0xff2b2f33); 

  // Focus border color for input fields (used in InputDecorationTheme.focusedBorder)
  static const Color borderFocus = Color(0xff4c7eea);

  // Surface color for cards, sheets, dialogs, and app bars (used in AppBarTheme, CardTheme)
  static const Color surface = Color(0xff1c1f23);

  // custom colors specific to the app

  // Background color used in main containers (e.g. navigation panel, sidebars)
  static const Color containerBackgroundColor = Color(0xff101204);

  // Card background color (used in Card widget)
  static const Color containerCardBackgroundColor = Color(0xff22272b);

  // Top bar background (used in AppBar -> backgroundColor)
  static const Color topBarBackgroundColor = Color(0xff1d2125);
}

class LightColorsToken {
  // Used for overall app background
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5); // light grey background

  // Primary brand color used in buttons, highlights, etc.
  static const Color primaryColor = Color(0xFF1e5dd2);

  // Slightly lighter variant of primaryColor for containers
  static const Color primaryContainer = Color(0xFF4c7eea);

  // Accent color for secondary actions (FABs, switches)
  static const Color secondary = Color(0xFF03dac6);

  // Lighter version of secondary
  static const Color secondryContainerColor = Color(0xFF66FFF9);

  // Text color for content on light backgrounds
  static const Color textPrimary = Colors.black;

  // Text/icon color that goes on top of `secondary` and `primary`
  static const Color textInverse = Colors.white;

  // Error color for form validations or alerts
  static const Color error = Color(0xffb00020);

  // Success, warning, info states
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Border color for inputs, cards, etc.
  static const Color border = Color(0xFFBDBDBD);

  // Focused border color (e.g., TextFields)
  static const Color borderFocus = Color(0xFF1e5dd2);

  // Background fill for input fields
  static const Color backgroundSecondary = Color(0xFFF0F0F0);

  // Background color for app bars, cards, sheets
  static const Color surface = Colors.white;
}
