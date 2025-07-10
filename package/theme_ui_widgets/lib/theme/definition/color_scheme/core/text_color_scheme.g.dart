// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_color_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppTextColorSchemeImpl _$$AppTextColorSchemeImplFromJson(
        Map<String, dynamic> json) =>
    _$AppTextColorSchemeImpl(
      primary:
          const ColorConverter().fromJson((json['primary'] as num).toInt()),
      secondary:
          const ColorConverter().fromJson((json['secondary'] as num).toInt()),
      tertiary:
          const ColorConverter().fromJson((json['tertiary'] as num).toInt()),
      quaternary:
          const ColorConverter().fromJson((json['quaternary'] as num).toInt()),
      onFill: const ColorConverter().fromJson((json['onFill'] as num).toInt()),
      action: const ColorConverter().fromJson((json['action'] as num).toInt()),
      actionHover:
          const ColorConverter().fromJson((json['actionHover'] as num).toInt()),
      info: const ColorConverter().fromJson((json['info'] as num).toInt()),
      infoHover:
          const ColorConverter().fromJson((json['infoHover'] as num).toInt()),
      success:
          const ColorConverter().fromJson((json['success'] as num).toInt()),
      successHover: const ColorConverter()
          .fromJson((json['successHover'] as num).toInt()),
      warning:
          const ColorConverter().fromJson((json['warning'] as num).toInt()),
      warningHover: const ColorConverter()
          .fromJson((json['warningHover'] as num).toInt()),
      error: const ColorConverter().fromJson((json['error'] as num).toInt()),
      errorHover:
          const ColorConverter().fromJson((json['errorHover'] as num).toInt()),
      featured:
          const ColorConverter().fromJson((json['featured'] as num).toInt()),
      featuredHover: const ColorConverter()
          .fromJson((json['featuredHover'] as num).toInt()),
    );

Map<String, dynamic> _$$AppTextColorSchemeImplToJson(
        _$AppTextColorSchemeImpl instance) =>
    <String, dynamic>{
      'primary': const ColorConverter().toJson(instance.primary),
      'secondary': const ColorConverter().toJson(instance.secondary),
      'tertiary': const ColorConverter().toJson(instance.tertiary),
      'quaternary': const ColorConverter().toJson(instance.quaternary),
      'onFill': const ColorConverter().toJson(instance.onFill),
      'action': const ColorConverter().toJson(instance.action),
      'actionHover': const ColorConverter().toJson(instance.actionHover),
      'info': const ColorConverter().toJson(instance.info),
      'infoHover': const ColorConverter().toJson(instance.infoHover),
      'success': const ColorConverter().toJson(instance.success),
      'successHover': const ColorConverter().toJson(instance.successHover),
      'warning': const ColorConverter().toJson(instance.warning),
      'warningHover': const ColorConverter().toJson(instance.warningHover),
      'error': const ColorConverter().toJson(instance.error),
      'errorHover': const ColorConverter().toJson(instance.errorHover),
      'featured': const ColorConverter().toJson(instance.featured),
      'featuredHover': const ColorConverter().toJson(instance.featuredHover),
    };
