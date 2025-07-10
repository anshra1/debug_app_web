// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_color_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SingleBadgeColorImpl _$$SingleBadgeColorImplFromJson(
        Map<String, dynamic> json) =>
    _$SingleBadgeColorImpl(
      light1: const ColorConverter().fromJson((json['light1'] as num).toInt()),
      light2: const ColorConverter().fromJson((json['light2'] as num).toInt()),
      light3: const ColorConverter().fromJson((json['light3'] as num).toInt()),
      thick1: const ColorConverter().fromJson((json['thick1'] as num).toInt()),
      thick2: const ColorConverter().fromJson((json['thick2'] as num).toInt()),
      thick3: const ColorConverter().fromJson((json['thick3'] as num).toInt()),
    );

Map<String, dynamic> _$$SingleBadgeColorImplToJson(
        _$SingleBadgeColorImpl instance) =>
    <String, dynamic>{
      'light1': const ColorConverter().toJson(instance.light1),
      'light2': const ColorConverter().toJson(instance.light2),
      'light3': const ColorConverter().toJson(instance.light3),
      'thick1': const ColorConverter().toJson(instance.thick1),
      'thick2': const ColorConverter().toJson(instance.thick2),
      'thick3': const ColorConverter().toJson(instance.thick3),
    };

_$AppBadgeColorSchemeImpl _$$AppBadgeColorSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$AppBadgeColorSchemeImpl(
      badgeColors: (json['badgeColors'] as List<dynamic>)
          .map((e) => SingleBadgeColor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AppBadgeColorSchemeImplToJson(
        _$AppBadgeColorSchemeImpl instance) =>
    <String, dynamic>{
      'badgeColors': instance.badgeColors,
    };
