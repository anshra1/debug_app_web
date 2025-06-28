import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_text_style.freezed.dart';
part 'default_text_style.g.dart';

// Industry standard breakpoints
class ResponsiveBreakpoints {
  static double scaleFont(double fontSize, [BuildContext? context]) {
    if (context == null) return fontSize; // Use base size if no context

    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery == null) return fontSize; // Use base size if no MediaQuery

    double width = mediaQuery.size.width;
    double scaleFactor;

    // Industry standard breakpoints and scaling
    if (width <= 600) {
      scaleFactor = 1.0; // Base size for mobile
    } else if (width <= 1024) {
      scaleFactor = 1.125; // 12.5% larger for tablet
    } else {
      // Fluid scaling for desktop with max cap
      scaleFactor = 1.0 + ((width - 600) / 3000);
      scaleFactor = scaleFactor.clamp(1.0, 1.25); // Cap at 25% larger
    }

    return fontSize * scaleFactor;
  }
}

@freezed
class DisplayLarge with _$DisplayLarge {
  const factory DisplayLarge({
    required String fontFamily,
  }) = _DisplayLarge;

  factory DisplayLarge.fromJson(Map<String, dynamic> json) =>
      _$DisplayLargeFromJson(json);

  const DisplayLarge._();

  DisplayLarge lerpWith(DisplayLarge other, double t) {
    return DisplayLarge(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 57,
        height: 64 / 57,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 57,
        height: 64 / 57,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 57,
        height: 64 / 57,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class DisplayMedium with _$DisplayMedium {
  const factory DisplayMedium({
    required String fontFamily,
  }) = _DisplayMedium;

  factory DisplayMedium.fromJson(Map<String, dynamic> json) =>
      _$DisplayMediumFromJson(json);

  const DisplayMedium._();

  DisplayMedium lerpWith(DisplayMedium other, double t) {
    return DisplayMedium(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 45,
        height: 52 / 45,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 45,
        height: 52 / 45,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 45,
        height: 52 / 45,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class DisplaySmall with _$DisplaySmall {
  const factory DisplaySmall({
    required String fontFamily,
  }) = _DisplaySmall;

  factory DisplaySmall.fromJson(Map<String, dynamic> json) =>
      _$DisplaySmallFromJson(json);

  const DisplaySmall._();

  DisplaySmall lerpWith(DisplaySmall other, double t) {
    return DisplaySmall(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 36,
        height: 44 / 36,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 36,
        height: 44 / 36,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 36,
        height: 44 / 36,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class HeadlineLarge with _$HeadlineLarge {
  const factory HeadlineLarge({
    required String fontFamily,
  }) = _HeadlineLarge;

  factory HeadlineLarge.fromJson(Map<String, dynamic> json) =>
      _$HeadlineLargeFromJson(json);

  const HeadlineLarge._();

  HeadlineLarge lerpWith(HeadlineLarge other, double t) {
    return HeadlineLarge(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class HeadlineMedium with _$HeadlineMedium {
  const factory HeadlineMedium({
    required String fontFamily,
  }) = _HeadlineMedium;

  factory HeadlineMedium.fromJson(Map<String, dynamic> json) =>
      _$HeadlineMediumFromJson(json);

  const HeadlineMedium._();

  HeadlineMedium lerpWith(HeadlineMedium other, double t) {
    return HeadlineMedium(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class HeadlineSmall with _$HeadlineSmall {
  const factory HeadlineSmall({
    required String fontFamily,
  }) = _HeadlineSmall;

  factory HeadlineSmall.fromJson(Map<String, dynamic> json) =>
      _$HeadlineSmallFromJson(json);

  const HeadlineSmall._();

  HeadlineSmall lerpWith(HeadlineSmall other, double t) {
    return HeadlineSmall(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 24,
        height: 32 / 24,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class TitleLarge with _$TitleLarge {
  const factory TitleLarge({
    required String fontFamily,
  }) = _TitleLarge;

  factory TitleLarge.fromJson(Map<String, dynamic> json) => _$TitleLargeFromJson(json);

  const TitleLarge._();

  TitleLarge lerpWith(TitleLarge other, double t) {
    return TitleLarge(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 22,
        height: 28 / 22,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 22,
        height: 28 / 22,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 22,
        height: 28 / 22,
        letterSpacing: 0,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class TitleMedium with _$TitleMedium {
  const factory TitleMedium({
    required String fontFamily,
  }) = _TitleMedium;

  factory TitleMedium.fromJson(Map<String, dynamic> json) => _$TitleMediumFromJson(json);

  const TitleMedium._();

  TitleMedium lerpWith(TitleMedium other, double t) {
    return TitleMedium(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.15,
        color: color,
        weight: weight ?? FontWeight.w500,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.15,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.15,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class TitleSmall with _$TitleSmall {
  const factory TitleSmall({
    required String fontFamily,
  }) = _TitleSmall;

  factory TitleSmall.fromJson(Map<String, dynamic> json) => _$TitleSmallFromJson(json);

  const TitleSmall._();

  TitleSmall lerpWith(TitleSmall other, double t) {
    return TitleSmall(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w500,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class BodyLarge with _$BodyLarge {
  const factory BodyLarge({
    required String fontFamily,
  }) = _BodyLarge;

  factory BodyLarge.fromJson(Map<String, dynamic> json) => _$BodyLargeFromJson(json);

  const BodyLarge._();

  BodyLarge lerpWith(BodyLarge other, double t) {
    return BodyLarge(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 16,
        height: 24 / 16,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class BodyMedium with _$BodyMedium {
  const factory BodyMedium({
    required String fontFamily,
  }) = _BodyMedium;

  factory BodyMedium.fromJson(Map<String, dynamic> json) => _$BodyMediumFromJson(json);

  const BodyMedium._();

  BodyMedium lerpWith(BodyMedium other, double t) {
    return BodyMedium(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class BodySmall with _$BodySmall {
  const factory BodySmall({
    required String fontFamily,
  }) = _BodySmall;

  factory BodySmall.fromJson(Map<String, dynamic> json) => _$BodySmallFromJson(json);

  const BodySmall._();

  BodySmall lerpWith(BodySmall other, double t) {
    return BodySmall(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.4,
        color: color,
        weight: weight ?? FontWeight.w400,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.4,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.4,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class LabelLarge with _$LabelLarge {
  const factory LabelLarge({
    required String fontFamily,
  }) = _LabelLarge;

  factory LabelLarge.fromJson(Map<String, dynamic> json) => _$LabelLargeFromJson(json);

  const LabelLarge._();

  LabelLarge lerpWith(LabelLarge other, double t) {
    return LabelLarge(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w500,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 14,
        height: 20 / 14,
        letterSpacing: 0.1,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class LabelMedium with _$LabelMedium {
  const factory LabelMedium({
    required String fontFamily,
  }) = _LabelMedium;

  factory LabelMedium.fromJson(Map<String, dynamic> json) => _$LabelMediumFromJson(json);

  const LabelMedium._();

  LabelMedium lerpWith(LabelMedium other, double t) {
    return LabelMedium(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w500,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 12,
        height: 16 / 12,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}

@freezed
class LabelSmall with _$LabelSmall {
  const factory LabelSmall({
    required String fontFamily,
  }) = _LabelSmall;

  factory LabelSmall.fromJson(Map<String, dynamic> json) => _$LabelSmallFromJson(json);

  const LabelSmall._();

  LabelSmall lerpWith(LabelSmall other, double t) {
    return LabelSmall(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }

  TextStyle standard({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w500,
      );

  TextStyle enhanced({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w600,
      );

  TextStyle prominent({
    BuildContext? context,
    String? family,
    Color? color,
    FontWeight? weight,
  }) =>
      _textStyle(
        context: context,
        family: family ?? fontFamily,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.5,
        color: color,
        weight: weight ?? FontWeight.w700,
      );

  static TextStyle _textStyle({
    BuildContext? context,
    required String family,
    required double fontSize,
    required double height,
    required double letterSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) =>
      TextStyle(
        inherit: false,
        fontSize: ResponsiveBreakpoints.scaleFont(fontSize, context),
        decoration: decoration,
        fontStyle: FontStyle.normal,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: family.isEmpty ? null : family,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
      );
}
