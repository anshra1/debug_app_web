// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentErrorImpl _$$CurrentErrorImplFromJson(Map<String, dynamic> json) =>
    _$CurrentErrorImpl(
      stackTrace: json['stackTrace'] as String,
      error: json['error'] as String,
      environment: ErrorEnvironment.fromJson(
          (json['environment'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Object),
      )),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$CurrentErrorImplToJson(_$CurrentErrorImpl instance) =>
    <String, dynamic>{
      'stackTrace': instance.stackTrace,
      'error': instance.error,
      'environment': instance.environment,
      'date': instance.date.toIso8601String(),
    };
