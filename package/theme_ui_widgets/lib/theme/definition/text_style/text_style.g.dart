// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_text_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppTextStyleImpl _$$AppTextStyleImplFromJson(Map<String, dynamic> json) =>
    _$AppTextStyleImpl(
      displayLarge: json['displayLarge'] == null
          ? const DisplayLarge(fontFamily: '')
          : DisplayLarge.fromJson(json['displayLarge'] as Map<String, dynamic>),
      displayMedium: json['displayMedium'] == null
          ? const DisplayMedium(fontFamily: '')
          : DisplayMedium.fromJson(
              json['displayMedium'] as Map<String, dynamic>),
      displaySmall: json['displaySmall'] == null
          ? const DisplaySmall(fontFamily: '')
          : DisplaySmall.fromJson(json['displaySmall'] as Map<String, dynamic>),
      headlineLarge: json['headlineLarge'] == null
          ? const HeadlineLarge(fontFamily: '')
          : HeadlineLarge.fromJson(
              json['headlineLarge'] as Map<String, dynamic>),
      headlineMedium: json['headlineMedium'] == null
          ? const HeadlineMedium(fontFamily: '')
          : HeadlineMedium.fromJson(
              json['headlineMedium'] as Map<String, dynamic>),
      headlineSmall: json['headlineSmall'] == null
          ? const HeadlineSmall(fontFamily: '')
          : HeadlineSmall.fromJson(
              json['headlineSmall'] as Map<String, dynamic>),
      titleLarge: json['titleLarge'] == null
          ? const TitleLarge(fontFamily: '')
          : TitleLarge.fromJson(json['titleLarge'] as Map<String, dynamic>),
      titleMedium: json['titleMedium'] == null
          ? const TitleMedium(fontFamily: '')
          : TitleMedium.fromJson(json['titleMedium'] as Map<String, dynamic>),
      titleSmall: json['titleSmall'] == null
          ? const TitleSmall(fontFamily: '')
          : TitleSmall.fromJson(json['titleSmall'] as Map<String, dynamic>),
      bodyLarge: json['bodyLarge'] == null
          ? const BodyLarge(fontFamily: '')
          : BodyLarge.fromJson(json['bodyLarge'] as Map<String, dynamic>),
      bodyMedium: json['bodyMedium'] == null
          ? const BodyMedium(fontFamily: '')
          : BodyMedium.fromJson(json['bodyMedium'] as Map<String, dynamic>),
      bodySmall: json['bodySmall'] == null
          ? const BodySmall(fontFamily: '')
          : BodySmall.fromJson(json['bodySmall'] as Map<String, dynamic>),
      labelLarge: json['labelLarge'] == null
          ? const LabelLarge(fontFamily: '')
          : LabelLarge.fromJson(json['labelLarge'] as Map<String, dynamic>),
      labelMedium: json['labelMedium'] == null
          ? const LabelMedium(fontFamily: '')
          : LabelMedium.fromJson(json['labelMedium'] as Map<String, dynamic>),
      labelSmall: json['labelSmall'] == null
          ? const LabelSmall(fontFamily: '')
          : LabelSmall.fromJson(json['labelSmall'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppTextStyleImplToJson(_$AppTextStyleImpl instance) =>
    <String, dynamic>{
      'displayLarge': instance.displayLarge,
      'displayMedium': instance.displayMedium,
      'displaySmall': instance.displaySmall,
      'headlineLarge': instance.headlineLarge,
      'headlineMedium': instance.headlineMedium,
      'headlineSmall': instance.headlineSmall,
      'titleLarge': instance.titleLarge,
      'titleMedium': instance.titleMedium,
      'titleSmall': instance.titleSmall,
      'bodyLarge': instance.bodyLarge,
      'bodyMedium': instance.bodyMedium,
      'bodySmall': instance.bodySmall,
      'labelLarge': instance.labelLarge,
      'labelMedium': instance.labelMedium,
      'labelSmall': instance.labelSmall,
    };
