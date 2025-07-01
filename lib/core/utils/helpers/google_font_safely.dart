import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _defaultFontFamilies = [
  'Arial',
  'Helvetica',
  'Times New Roman',
  'Courier New',
  'Georgia',
  'Palatino',
  'Garamond',
  'Bookman',
  'Comic Sans MS',
  'Impact',
  'Lucida Console',
  'Tahoma',
  'Verdana',
];

TextStyle getGoogleFontSafely(
  String fontFamily, {
  FontWeight? fontWeight,
  double? fontSize,
  Color? fontColor,
  double? letterSpacing,
  double? lineHeight,
}) {
  // if the font family is the built-in font family, we can use it directly
  if (_defaultFontFamilies.contains(fontFamily)) {
    return TextStyle(
      fontFamily: fontFamily.isEmpty ? null : fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: fontColor,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  } else {
    try {
      return GoogleFonts.getFont(
        fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: fontColor,
        letterSpacing: letterSpacing,
        height: lineHeight,
      );
    } on Exception catch (_) {}
  }

  return TextStyle(
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: fontColor,
    letterSpacing: letterSpacing,
    height: lineHeight,
  );
}
