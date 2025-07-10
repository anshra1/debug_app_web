// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_theme_color_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImportThemeColorSetImpl _$$ImportThemeColorSetImplFromJson(
        Map<String, dynamic> json) =>
    _$ImportThemeColorSetImpl(
      themeName: json['themeName'] as String,
      textColorScheme: AppTextColorScheme.fromJson(
          json['textColorScheme'] as Map<String, dynamic>),
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
      surfaceContainerColorScheme: AppSurfaceContainerColorScheme.fromJson(
          json['surfaceContainerColorScheme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ImportThemeColorSetImplToJson(
        _$ImportThemeColorSetImpl instance) =>
    <String, dynamic>{
      'themeName': instance.themeName,
      'textColorScheme': instance.textColorScheme,
      'iconColorScheme': instance.iconColorScheme,
      'borderColorScheme': instance.borderColorScheme,
      'badgeColorScheme': instance.badgeColorScheme,
      'backgroundColorScheme': instance.backgroundColorScheme,
      'fillColorScheme': instance.fillColorScheme,
      'surfaceColorScheme': instance.surfaceColorScheme,
      'surfaceContainerColorScheme': instance.surfaceContainerColorScheme,
    };
