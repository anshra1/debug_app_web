// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppThemeDataImpl _$$AppThemeDataImplFromJson(Map<String, dynamic> json) =>
    _$AppThemeDataImpl(
      themeName: json['themeName'] as String,
      textColorScheme: AppTextColorScheme.fromJson(
          json['textColorScheme'] as Map<String, dynamic>),
      textStyle:
          AppTextStyle.fromJson(json['textStyle'] as Map<String, dynamic>),
      iconColorScheme: AppIconColorScheme.fromJson(
          json['iconColorScheme'] as Map<String, dynamic>),
      borderColorScheme: AppBorderColorScheme.fromJson(
          json['borderColorScheme'] as Map<String, dynamic>),
      badgeColorScheme: AppBadgeColorScheme.fromJson(
          json['badgeColorScheme'] as Map<String, dynamic>),
      backgroundColorScheme: AppBackgroundColorScheme.fromJson(
          json['backgroundColorScheme'] as Map<String, dynamic>),
      fillColorScheme: AppFillColorScheme.fromJson(
          json['fillColorScheme'] as Map<String, dynamic>),
      surfaceColorScheme: AppSurfaceColorScheme.fromJson(
          json['surfaceColorScheme'] as Map<String, dynamic>),
      borderRadius: AppBorderRadius.fromJson(
          json['borderRadius'] as Map<String, dynamic>),
      spacing: AppSpacing.fromJson(json['spacing'] as Map<String, dynamic>),
      shadow: AppShadow.fromJson(json['shadow'] as Map<String, dynamic>),
      brandColorScheme: AppBrandColorScheme.fromJson(
          json['brandColorScheme'] as Map<String, dynamic>),
      surfaceContainerColorScheme: AppSurfaceContainerColorScheme.fromJson(
          json['surfaceContainerColorScheme'] as Map<String, dynamic>),
      otherColorsColorScheme: AppOtherColorsColorScheme.fromJson(
          json['otherColorsColorScheme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppThemeDataImplToJson(_$AppThemeDataImpl instance) =>
    <String, dynamic>{
      'themeName': instance.themeName,
      'textColorScheme': instance.textColorScheme,
      'textStyle': instance.textStyle,
      'iconColorScheme': instance.iconColorScheme,
      'borderColorScheme': instance.borderColorScheme,
      'badgeColorScheme': instance.badgeColorScheme,
      'backgroundColorScheme': instance.backgroundColorScheme,
      'fillColorScheme': instance.fillColorScheme,
      'surfaceColorScheme': instance.surfaceColorScheme,
      'borderRadius': instance.borderRadius,
      'spacing': instance.spacing,
      'shadow': instance.shadow,
      'brandColorScheme': instance.brandColorScheme,
      'surfaceContainerColorScheme': instance.surfaceContainerColorScheme,
      'otherColorsColorScheme': instance.otherColorsColorScheme,
    };
