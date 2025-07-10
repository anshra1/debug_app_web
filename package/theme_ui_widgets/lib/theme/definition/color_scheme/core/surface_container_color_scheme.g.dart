// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surface_container_color_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSurfaceContainerColorSchemeImpl
    _$$AppSurfaceContainerColorSchemeImplFromJson(Map<String, dynamic> json) =>
        _$AppSurfaceContainerColorSchemeImpl(
          layer01:
              const ColorConverter().fromJson((json['layer01'] as num).toInt()),
          layer02:
              const ColorConverter().fromJson((json['layer02'] as num).toInt()),
          layer03:
              const ColorConverter().fromJson((json['layer03'] as num).toInt()),
        );

Map<String, dynamic> _$$AppSurfaceContainerColorSchemeImplToJson(
        _$AppSurfaceContainerColorSchemeImpl instance) =>
    <String, dynamic>{
      'layer01': const ColorConverter().toJson(instance.layer01),
      'layer02': const ColorConverter().toJson(instance.layer02),
      'layer03': const ColorConverter().toJson(instance.layer03),
    };
