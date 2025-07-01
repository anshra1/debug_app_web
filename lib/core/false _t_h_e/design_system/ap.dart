import 'package:flutter/material.dart';

class AppColorTokens {
  // ----------------------------
  // 🎯 Brand
  // ----------------------------
  /// Main brand button, FABs → ElevatedButton, AppBar background
  static const primary = Color(0xff1976d2); // Example color
  static const onPrimary = Color(0xffffffff); // Example color

  /// Secondary actions/buttons → OutlinedButton, secondary CTA
  static const secondary = Color(0xff9c27b0); // Example color
  static const onSecondary = Color(0xffffffff); // Example color

  /// Marketing highlights, callouts → Banner, onboarding step
  static const accent = Color(0xffff9800); // Example color
  static const onAccent = Color(0xffffffff); // Example color

  // ----------------------------
  // 🧱 Backgrounds & Surfaces
  // ----------------------------
  /// App root background → Scaffold.backgroundColor
  static const background = Color(0xfff5f5f5); // Example color

  /// Card backgrounds, sheets → Card, BottomSheet
  static const surface = Color(0xffffffff); // Example color

  /// Nested cards or layers → Tooltips, elevation overlays
  static const surfaceVariant = Color(0xffeeeeee); // Example color
  static const onSurfaceVariant = Color(0xff000000); // Example color;

  /// Text/icons on surfaces → TextTheme.bodyText1.color
  static const onSurface = Color(0xff000000); // Example color

  // ----------------------------
  // 🌑 Inverse Theme (dark mode, modals)
  // ----------------------------
  /// Dialogs, dark sheets → Dialog, BottomSheet.dark()
  static const inverseSurface = Color(0xff000000); // Example color
  static const onInverseSurface = Color(0xffffffff); // Example color

  // ----------------------------
  // ❗ Feedback States
  // ----------------------------
  /// Error states, error buttons → Forms, error alerts
  static const error = Color(0xffb00020); // Example color
  static const onError = Color(0xffffffff); // Example color
  static const errorContainer = Color(0xffffebee); // Example color

  /// Status indicators → Snackbar, badge, banners
  static const success = Color(0xff4caf50); // Example color
  static const warning = Color(0xffffc107); // Example color
  static const info = Color(0xff2196f3); // Example color

  static const successContainer = Color(0xffe8f5e9); // Example color
  static const warningContainer = Color(0xfffff3e0); // Example color
  static const infoContainer = Color(0xffe1f5fe); // Example color

  // ----------------------------
  // 📏 Borders, Outlines, Overlays
  // ----------------------------
  /// Separators & outlines → Divider, BorderSide
  static const border = Color(0xffe0e0e0); // Example color
  static const divider = Color(0xffe0e0e0); // Example color
  static const outline = Color(0xffbdbdbd); // Example color

  /// Overlay behind dialogs/menus → showDialog background
  static const scrim = Color(0x99000000); // 60% black

  // ----------------------------
  // ✏️ Text Colors
  // ----------------------------
  /// Default and secondary text → Text, TextField.labelStyle
  static const textPrimary = Color(0xff000000); // Example color
  static const textSecondary = Color(0xff616161); // Example color

  /// Typography system → Headings, footers, UI hints
  static const headlineText = Color(0xff000000); // Example color
  static const bodyText = Color(0xff212121); // Example color
  static const captionText = Color(0xff757575); // Example color

  static const disabledText = Color(0xffbdbdbd); // Example color

  // ----------------------------
  // 🧩 Interaction States
  // ----------------------------
  /// Button/interactions → Button states, menu item hover
  static const focus = Color(0xff1976d2); // Example color
  static const hover = Color(0xffe3f2fd); // Example color
  static const selected = Color(0xffbbdefb); // Example color
  static const pressed = Color(0xff1976d2); // Example color

  /// Disabled UI → Form fields, buttons
  static const disabled = Color(0xffe0e0e0); // Example color
  static const disabledBackground = Color(0xfff5f5f5); // Example color
  static const disabledBorder = Color(0xffe0e0e0); // Example color

  // ----------------------------
  // 🌫️ Elevation (Shadow Layers)
  // ----------------------------
  /// Box shadows or backgrounds → Cards, modals
  static const elevation1 = Color(0x1A000000); // 10% black
  static const elevation2 = Color(0x33000000); // 20% black
  static const elevation3 = Color(0x4D000000); // 30% black

  // ----------------------------
  // 🔗 Link Text
  // ----------------------------
  /// Text links → Inline links or footers
  static const link = Color(0xff1976d2); // Example color
  static const linkVisited = Color(0xff9c27b0); // Example color
}
