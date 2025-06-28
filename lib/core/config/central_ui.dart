import 'dart:ui';

import 'package:flutter/material.dart' show Colors;

class UIConfig {
// ----------------------------
// 🌑 Dark Theme Tokens
// ----------------------------

// 🎯 Brand
  static const Color primary = Color(0xFF10A37F); // Greenish teal (same across themes)
  static const Color onPrimary = Color(0xFFFFFFFF);

// 🧱 Backgrounds & Surfaces
  static const Color backgroundDark = Color(0xFF111111); // App root background
  static const Color surfaceDark = Color(0xFF1E1E1E); // Cards, modals, etc.
  static const Color onSurfaceDark = Color(0xFFFFFFFF); // Light text on dark surfaces

  static const Color surfaceVariantDark =
      Color(0xFF2A2A2A); // Nested cards or input fields
  static const Color onSurfaceVariantDark = Color(0xFFCCCCCC); // Subtle text/icons

// 🌑 Inverse Theme (used for dialogs/popups in dark mode)
  static const Color inverseSurfaceDark = Color(0xFFFFFFFF); // Light dialogs
  static const Color onInverseSurfaceDark =
      Color(0xFF202123); // Dark text on light surfaces

// ❗ Feedback
  static const Color errorDark = Color(0xFFDA3F3F);
  static const Color onErrorDark = Color(0xFFFFFFFF);
  static Color errorContainerDark = const Color(0xFFFF4D4D).withOpacity(0.15); // Red wash

  static const Color successDark = Color(0xFF2AB47A);
  static Color successContainerDark = const Color(0xFF2AB47A).withOpacity(0.1);

  static const Color warningDark = Color(0xFFFFC107);
  static Color warningContainerDark = const Color(0xFFFFC107).withOpacity(0.1);

  static const Color infoDark = Color(0xFF2196F3);
  static Color infoContainerDark = const Color(0xFF2196F3).withOpacity(0.1);

// 📏 Borders & Dividers
  static const Color borderDark = Color(0xFF333333); // Thin gray line
  static const Color dividerDark = Color(0xFF444444);
  static const Color outlineDark = Color(0xFF555555);
  static const Color scrimDark = Color(0x99000000); // Translucent black

// ✏️ Text
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // Primary text
  static const Color textSecondaryDark = Color(0xFFCCCCCC); // Subtle text
  static const Color headlineTextDark = Color(0xFFFFFFFF);
  static const Color bodyTextDark = Color(0xFFAAAAAA);
  static const Color captionTextDark = Color(0xFF888888);
  static const Color disabledTextDark = Color(0xFF555555);

// 🧩 States
  static const Color focusDark = Color(0xFF10A37F); // Same brand color
  static const Color hoverDark = Color(0xFF2A2A2A); // Slight highlight
  static const Color selectedDark = Color(0xFF3A3A3A); // Selected item
  static const Color pressedDark = Color(0xFF1A7F64); // Pressed state

  static const Color disabledDark = Color(0xFF444444);
  static const Color disabledBackgroundDark = Color(0xFF222222);
  static const Color disabledBorderDark = Color(0xFF333333);

// 🌫️ Elevation Shadows (dark mode)
  static const Color elevation1Dark = Color(0x1AFFFFFF); // 10% white overlay
  static const Color elevation2Dark = Color(0x33FFFFFF); // 20%
  static const Color elevation3Dark = Color(0x4DFFFFFF); // 30%

// 🔗 Links
  static const Color linkDark = Color(0xFF0B57D0);
  static const Color linkVisitedDark = Color(0xFF6B2BC8);

// ----------------------------
// 🔗 Links
// ----------------------------
  static const Color link = Color(0xFF0B57D0);
  static const Color linkVisited = Color(0xFF6B2BC8);
  //-------------------------------------------------

  // editor Background
  static const Color appBackgroundColor = backgroundDark;
  static const double middlePanelPadding = 4;

  // define colors  app colors

  // sidebar
  static const double sideBarWidth = 450;
  static const double sidebarListItemBorderRadius = 4;
  static const double sidebarListItemHeight = 120;
  static const double sidebarFontSize = 16;
  static const Color sidebarBackgroundColor = Colors.black;
  static const Color sidebarTextColor = Color(0xffECEFF1); // almost white
  static const Color sidebarListTileColor = Color(0xff2F2F2F); // almost white
  static const Color sideBarHeaderColor = Color(0xff202224);

  // Top Bar
  static const double topBarHeight = 60;
  static const Color topBarBackgroundColor = backgroundDark;
  static const double topBarFontSize = 16;

  static const Color topBarIconColor = textPrimaryDark; // almost white
  static const Color topBarPrimaryTextColor = textPrimaryDark; // almost white
  static const Color topBarSecondaryTextColor = textSecondaryDark;

  // Error Card
  static const double errorCardBorderRadius = 8;
  static const Color errorCardIconColor = Color(0xffECEFF1); // almost white
  static const Color errorCardBackgroundColor = Colors.black;
  static const Color errorCardHeaderColor = Color(0xff2F2F2F);
  static const Color errorCardTextColor = Color(0xffECEFF1);
  static const double errorCardFontSize = 20;

  // stack trace card
  static const Color stackTraceCardHeaderColor = Color(0xff2F2F2F);
  static const Color stackTraceCardTextColor = Color(0xffECEFF1);
  static const double stackTraceCardFontSize = 18;

  // border color

  static const Color borderColor = Color(0xff343541); // almost white
  static const Color borderColor2 = Color(0xff343541); // almost white
}
