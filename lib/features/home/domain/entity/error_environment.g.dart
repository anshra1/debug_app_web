// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorEnvironmentImpl _$$ErrorEnvironmentImplFromJson(
        Map<String, dynamic> json) =>
    _$ErrorEnvironmentImpl(
      flutterVersion: json['flutterVersion'] as String,
      dartVersion: json['dartVersion'] as String,
      platform: json['platform'] as String,
      osVersion: json['osVersion'] as String?,
      deviceModel: json['deviceModel'] as String?,
    );

Map<String, dynamic> _$$ErrorEnvironmentImplToJson(
        _$ErrorEnvironmentImpl instance) =>
    <String, dynamic>{
      'flutterVersion': instance.flutterVersion,
      'dartVersion': instance.dartVersion,
      'platform': instance.platform,
      'osVersion': instance.osVersion,
      'deviceModel': instance.deviceModel,
    };
