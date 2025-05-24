// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorTrackingImpl _$$ErrorTrackingImplFromJson(Map<String, dynamic> json) =>
    _$ErrorTrackingImpl(
      id: json['id'] as String,
      currentError: CurrentError.fromJson(
          (json['currentError'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Object),
      )),
      solutions: (json['solutions'] as List<dynamic>)
          .map((e) => Solution.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorPriority: $enumDecode(_$ErrorPriorityEnumMap, json['errorPriority']),
      errorCategory: $enumDecode(_$ErrorCategoryEnumMap, json['errorCategory']),
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
      'errorPriority': _$ErrorPriorityEnumMap[instance.errorPriority]!,
      'errorCategory': _$ErrorCategoryEnumMap[instance.errorCategory]!,
      'errorTags': instance.errorTags,
      'fingerPrintHashing': instance.fingerPrintHashing,
      'dates': instance.dates.map((e) => e.toIso8601String()).toList(),
    };

const _$ErrorPriorityEnumMap = {
  ErrorPriority.low: 'low',
  ErrorPriority.medium: 'medium',
  ErrorPriority.high: 'high',
  ErrorPriority.critical: 'critical',
  ErrorPriority.crash: 'crash',
};

const _$ErrorCategoryEnumMap = {
  ErrorCategory.error: 'error',
  ErrorCategory.warning: 'warning',
  ErrorCategory.info: 'info',
  ErrorCategory.unknown: 'unknown',
};
