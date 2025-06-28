// import 'package:debug_app_web/theme_system.dart/extension/google_font_extension.dart';
// import 'package:debug_app_web/theme_system.dart/models/app_theme.dart';
// import 'package:debug_app_web/theme_system.dart/utils/size.dart';
// import 'package:flutter/material.dart';


// const defaultFontFamily = '';

// const builtInCodeFontFamily = 'RobotoMono';

// abstract class BaseAppearance {
//   final white = const Color(0xFFFFFFFF);

//   final Set<WidgetState> scrollbarInteractiveStates = <WidgetState>{
//     WidgetState.pressed,
//     WidgetState.hovered,
//     WidgetState.dragged,
//   };

//   TextStyle getFontStyle({
//     required String fontFamily,
//     double? fontSize,
//     FontWeight? fontWeight,
//     Color? fontColor,
//     double? letterSpacing,
//     double? lineHeight,
//   }) {
//     fontSize = fontSize ?? FontSizes.s14;
//     fontWeight = fontWeight ?? FontWeight.w400;
//     letterSpacing = fontSize * (letterSpacing ?? 0.005);

//     final textStyle = TextStyle(
//       fontFamily: fontFamily.isEmpty ? null : fontFamily,
//       fontSize: fontSize,
//       color: fontColor,
//       fontWeight: fontWeight,
//       letterSpacing: letterSpacing,
//       height: lineHeight,
//     );

//     if (fontFamily == defaultFontFamily) {
//       return textStyle;
//     }

//     try {
//       return getGoogleFontSafely(
//         fontFamily,
//         fontSize: fontSize,
//         fontColor: fontColor,
//         fontWeight: fontWeight,
//         letterSpacing: letterSpacing,
//         lineHeight: lineHeight,
//       );
//     } on Exception catch (_) {
//       return textStyle;
//     }
//   }

//   TextTheme getTextTheme({
//     required String fontFamily,
//     required Color fontColor,
//   }) {
//     return TextTheme(
//       displayLarge: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s32,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//         lineHeight: 42,
//       ), // h2
//       displayMedium: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s24,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//         lineHeight: 34,
//       ), // h3
//       displaySmall: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s20,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//         lineHeight: 28,
//       ), // h4
//       titleLarge: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s18,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//       ), 
//       titleMedium: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s16,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//       ), 
//       titleSmall: getFontStyle(
//         fontFamily: fontFamily,
//         fontSize: FontSizes.s14,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w600,
//       ), // subheading
//       bodyMedium: getFontStyle(
//         fontFamily: fontFamily,
//         fontColor: fontColor,
//       ), // body-regular
//       bodySmall: getFontStyle(
//         fontFamily: fontFamily,
//         fontColor: fontColor,
//         fontWeight: FontWeight.w400,
//       ), // body-thin
//     );
//   }

//   ThemeData getThemeData(
//     CustomAppTheme appTheme,
//     Brightness brightness,
//     String fontFamily,
//     String codeFontFamily,
//   );
// }
