import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theme_ui_widgets/theme/definition/text_style/default_text_style.dart';

part 'text_style.freezed.dart';
part 'text_style.g.dart';

@freezed
class AppTextStyle with _$AppTextStyle {
  const factory AppTextStyle({
    @Default(DisplayLarge(fontFamily: '')) DisplayLarge displayLarge,
    @Default(DisplayMedium(fontFamily: '')) DisplayMedium displayMedium,
    @Default(DisplaySmall(fontFamily: '')) DisplaySmall displaySmall,
    @Default(HeadlineLarge(fontFamily: '')) HeadlineLarge headlineLarge,
    @Default(HeadlineMedium(fontFamily: '')) HeadlineMedium headlineMedium,
    @Default(HeadlineSmall(fontFamily: '')) HeadlineSmall headlineSmall,
    @Default(TitleLarge(fontFamily: '')) TitleLarge titleLarge,
    @Default(TitleMedium(fontFamily: '')) TitleMedium titleMedium,
    @Default(TitleSmall(fontFamily: '')) TitleSmall titleSmall,
    @Default(BodyLarge(fontFamily: '')) BodyLarge bodyLarge,
    @Default(BodyMedium(fontFamily: '')) BodyMedium bodyMedium,
    @Default(BodySmall(fontFamily: '')) BodySmall bodySmall,
    @Default(LabelLarge(fontFamily: '')) LabelLarge labelLarge,
    @Default(LabelMedium(fontFamily: '')) LabelMedium labelMedium,
    @Default(LabelSmall(fontFamily: '')) LabelSmall labelSmall,
  }) = _AppTextStyle;

  factory AppTextStyle.fromJson(Map<String, dynamic> json) =>
      _$AppTextStyleFromJson(json);



  factory AppTextStyle.customFontFamily(String fontFamily) => AppTextStyle(
        displayLarge: DisplayLarge(fontFamily: fontFamily),
        displayMedium: DisplayMedium(fontFamily: fontFamily),
        displaySmall: DisplaySmall(fontFamily: fontFamily),
        headlineLarge: HeadlineLarge(fontFamily: fontFamily),
        headlineMedium: HeadlineMedium(fontFamily: fontFamily),
        headlineSmall: HeadlineSmall(fontFamily: fontFamily),
        titleLarge: TitleLarge(fontFamily: fontFamily),
        titleMedium: TitleMedium(fontFamily: fontFamily),
        titleSmall: TitleSmall(fontFamily: fontFamily),
        bodyLarge: BodyLarge(fontFamily: fontFamily),
        bodyMedium: BodyMedium(fontFamily: fontFamily),
        bodySmall: BodySmall(fontFamily: fontFamily),
        labelLarge: LabelLarge(fontFamily: fontFamily),
        labelMedium: LabelMedium(fontFamily: fontFamily),
        labelSmall: LabelSmall(fontFamily: fontFamily),
      );
}

extension AppTextStyleLerp on AppTextStyle {
  AppTextStyle lerpWith(AppTextStyle other, double t) {
    return AppTextStyle(
      displayLarge: displayLarge.lerpWith(other.displayLarge, t),
      displayMedium: displayMedium.lerpWith(other.displayMedium, t),
      displaySmall: displaySmall.lerpWith(other.displaySmall, t),
      headlineLarge: headlineLarge.lerpWith(other.headlineLarge, t),
      headlineMedium: headlineMedium.lerpWith(other.headlineMedium, t),
      headlineSmall: headlineSmall.lerpWith(other.headlineSmall, t),
      titleLarge: titleLarge.lerpWith(other.titleLarge, t),
      titleMedium: titleMedium.lerpWith(other.titleMedium, t),
      titleSmall: titleSmall.lerpWith(other.titleSmall, t),
      bodyLarge: bodyLarge.lerpWith(other.bodyLarge, t),
      bodyMedium: bodyMedium.lerpWith(other.bodyMedium, t),
      bodySmall: bodySmall.lerpWith(other.bodySmall, t),
      labelLarge: labelLarge.lerpWith(other.labelLarge, t),
      labelMedium: labelMedium.lerpWith(other.labelMedium, t),
      labelSmall: labelSmall.lerpWith(other.labelSmall, t),
    );
  }
}
