// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorTrackingImpl _$$ErrorTrackingImplFromJson(Map<String, dynamic> json) =>
    _$ErrorTrackingImpl(
      id: json['id'] as String,
      currentError:
          CurrentError.fromJson(json['currentError'] as Map<String, dynamic>),
      solutions: (json['solutions'] as List<dynamic>)
          .map((e) => Solution.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCategory: $enumDecode(_$ErrorCategoryEnumMap, json['errorCategory']),
      errorColorCategory:
          $enumDecode(_$ErrorColorCategoryEnumMap, json['errorColorCategory']),
      errorTags:
          (json['errorTags'] as List<dynamic>).map((e) => e as String).toList(),
      fingerPrintHashing: json['fingerPrintHashing'] as String,
      dates: (json['dates'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$ErrorTrackingImplToJson(_$ErrorTrackingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentError': instance.currentError,
      'solutions': instance.solutions,
      'errorCategory': _$ErrorCategoryEnumMap[instance.errorCategory]!,
      'errorColorCategory':
          _$ErrorColorCategoryEnumMap[instance.errorColorCategory]!,
      'errorTags': instance.errorTags,
      'fingerPrintHashing': instance.fingerPrintHashing,
      'dates': instance.dates.map((e) => e.toIso8601String()).toList(),
    };

const _$ErrorCategoryEnumMap = {
  ErrorCategory.error: 'error',
  ErrorCategory.warning: 'warning',
  ErrorCategory.info: 'info',
  ErrorCategory.unknown: 'unknown',
};

const _$ErrorColorCategoryEnumMap = {
  ErrorColorCategory.ui: 'ui',
  ErrorColorCategory.logic: 'logic',
  ErrorColorCategory.network: 'network',
  ErrorColorCategory.database: 'database',
  ErrorColorCategory.other: 'other',
  ErrorColorCategory.package: 'package',
  ErrorColorCategory.unknown: 'unknown',
};
