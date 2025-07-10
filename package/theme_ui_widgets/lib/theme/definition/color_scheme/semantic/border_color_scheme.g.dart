// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_color_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppBorderColorSchemeImpl _$$AppBorderColorSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$AppBorderColorSchemeImpl(
      primary:
          const ColorConverter().fromJson((json['primary'] as num).toInt()),
      secondary:
          const ColorConverter().fromJson((json['secondary'] as num).toInt()),
      tertiary:
          const ColorConverter().fromJson((json['tertiary'] as num).toInt()),
      disabled:
          const ColorConverter().fromJson((json['disabled'] as num).toInt()),
      focus: const ColorConverter().fromJson((json['focus'] as num).toInt()),
      error: const ColorConverter().fromJson((json['error'] as num).toInt()),
      success:
          const ColorConverter().fromJson((json['success'] as num).toInt()),
      warning:
          const ColorConverter().fromJson((json['warning'] as num).toInt()),
    );

Map<String, dynamic> _$$AppBorderColorSchemeImplToJson(
        _$AppBorderColorSchemeImpl instance) =>
    <String, dynamic>{
      'primary': const ColorConverter().toJson(instance.primary),
      'secondary': const ColorConverter().toJson(instance.secondary),
      'tertiary': const ColorConverter().toJson(instance.tertiary),
      'disabled': const ColorConverter().toJson(instance.disabled),
      'focus': const ColorConverter().toJson(instance.focus),
      'error': const ColorConverter().toJson(instance.error),
      'success': const ColorConverter().toJson(instance.success),
      'warning': const ColorConverter().toJson(instance.warning),
    };
