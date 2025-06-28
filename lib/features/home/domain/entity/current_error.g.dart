// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentErrorImpl _$$CurrentErrorImplFromJson(Map<String, dynamic> json) =>
    _$CurrentErrorImpl(
      id: json['id'] as String,
      error: json['error'] as String,
      platform: json['platform'] as String,
      additionalInfo: (json['additionalInfo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      stackTrace: json['stackTrace'] as String?,
    );

Map<String, dynamic> _$$CurrentErrorImplToJson(_$CurrentErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error,
      'platform': instance.platform,
      'additionalInfo': instance.additionalInfo,
      'stackTrace': instance.stackTrace,
    };
