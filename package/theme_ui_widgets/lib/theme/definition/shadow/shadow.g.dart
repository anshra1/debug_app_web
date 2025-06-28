// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shadow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppShadowImpl _$$AppShadowImplFromJson(Map<String, dynamic> json) =>
    _$AppShadowImpl(
      small: (json['small'] as List<dynamic>)
          .map((e) => AppBoxShadow.fromJson(e as Map<String, dynamic>))
          .toList(),
      medium: (json['medium'] as List<dynamic>)
          .map((e) => AppBoxShadow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppShadowImplToJson(_$AppShadowImpl instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
    };

_$AppBoxShadowImpl _$$AppBoxShadowImplFromJson(Map<String, dynamic> json) =>
    _$AppBoxShadowImpl(
      offsetX: (json['offsetX'] as num).toDouble(),
      offsetY: (json['offsetY'] as num).toDouble(),
      blurRadius: (json['blurRadius'] as num).toDouble(),
      spreadRadius: (json['spreadRadius'] as num).toDouble(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$AppBoxShadowImplToJson(_$AppBoxShadowImpl instance) =>
    <String, dynamic>{
      'offsetX': instance.offsetX,
      'offsetY': instance.offsetY,
      'blurRadius': instance.blurRadius,
      'spreadRadius': instance.spreadRadius,
      'color': instance.color,
    };
