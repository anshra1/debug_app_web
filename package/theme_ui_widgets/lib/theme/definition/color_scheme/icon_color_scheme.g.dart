// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_color_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppIconColorSchemeImpl _$$AppIconColorSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$AppIconColorSchemeImpl(
      primary:
          const ColorConverter().fromJson((json['primary'] as num).toInt()),
      secondary:
          const ColorConverter().fromJson((json['secondary'] as num).toInt()),
      tertiary:
          const ColorConverter().fromJson((json['tertiary'] as num).toInt()),
      quaternary:
          const ColorConverter().fromJson((json['quaternary'] as num).toInt()),
      onFill: const ColorConverter().fromJson((json['onFill'] as num).toInt()),
      featuredThick: const ColorConverter()
          .fromJson((json['featuredThick'] as num).toInt()),
      featuredThickHover: const ColorConverter()
          .fromJson((json['featuredThickHover'] as num).toInt()),
      infoThick:
          const ColorConverter().fromJson((json['infoThick'] as num).toInt()),
      infoThickHover: const ColorConverter()
          .fromJson((json['infoThickHover'] as num).toInt()),
      successThick: const ColorConverter()
          .fromJson((json['successThick'] as num).toInt()),
      successThickHover: const ColorConverter()
          .fromJson((json['successThickHover'] as num).toInt()),
      warningThick: const ColorConverter()
          .fromJson((json['warningThick'] as num).toInt()),
      warningThickHover: const ColorConverter()
          .fromJson((json['warningThickHover'] as num).toInt()),
      errorThick:
          const ColorConverter().fromJson((json['errorThick'] as num).toInt()),
      errorThickHover: const ColorConverter()
          .fromJson((json['errorThickHover'] as num).toInt()),
    );

Map<String, dynamic> _$$AppIconColorSchemeImplToJson(
        _$AppIconColorSchemeImpl instance) =>
    <String, dynamic>{
      'primary': const ColorConverter().toJson(instance.primary),
      'secondary': const ColorConverter().toJson(instance.secondary),
      'tertiary': const ColorConverter().toJson(instance.tertiary),
      'quaternary': const ColorConverter().toJson(instance.quaternary),
      'onFill': const ColorConverter().toJson(instance.onFill),
      'featuredThick': const ColorConverter().toJson(instance.featuredThick),
      'featuredThickHover':
          const ColorConverter().toJson(instance.featuredThickHover),
      'infoThick': const ColorConverter().toJson(instance.infoThick),
      'infoThickHover': const ColorConverter().toJson(instance.infoThickHover),
      'successThick': const ColorConverter().toJson(instance.successThick),
      'successThickHover':
          const ColorConverter().toJson(instance.successThickHover),
      'warningThick': const ColorConverter().toJson(instance.warningThick),
      'warningThickHover':
          const ColorConverter().toJson(instance.warningThickHover),
      'errorThick': const ColorConverter().toJson(instance.errorThick),
      'errorThickHover':
          const ColorConverter().toJson(instance.errorThickHover),
    };
