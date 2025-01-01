import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:equatable/equatable.dart';

class ErrorEnvironment extends Equatable {
  const ErrorEnvironment({
    required this.projectName,
    required this.flutterVersion,
    required this.dartVersion,
    required this.platform,
    this.osVersion,
    this.deviceModel,
    this.additionalInfo = const {},
  });

  factory ErrorEnvironment.fromJson(Map<String, dynamic> json) => ErrorEnvironment(
        projectName: (json[EntityKeys.projectName] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        flutterVersion: (json[EntityKeys.flutterVersion] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        dartVersion: (json[EntityKeys.dartVersion] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        platform: (json[EntityKeys.platform] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [],
        osVersion: (json[EntityKeys.osVersion] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        deviceModel: (json[EntityKeys.deviceModel] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        additionalInfo: json[EntityKeys.additionalInfo] as Map<String, dynamic>? ?? {},
      );

  final List<String>? projectName;
  final List<String>? flutterVersion;
  final List<String>? dartVersion;
  final List<String>? platform;
  final List<String>? osVersion;
  final List<String>? deviceModel;
  final Map<String, dynamic> additionalInfo;

  Map<String, dynamic> toJson() => {
        EntityKeys.projectName: projectName,
        EntityKeys.flutterVersion: flutterVersion,
        EntityKeys.dartVersion: dartVersion,
        EntityKeys.platform: platform,
        EntityKeys.osVersion: osVersion,
        EntityKeys.deviceModel: deviceModel,
        EntityKeys.additionalInfo: additionalInfo,
      };

  @override
  List<Object?> get props => [
        projectName,
        flutterVersion,
        dartVersion,
        platform,
        osVersion,
        deviceModel,
        additionalInfo,
      ];

  ErrorEnvironment copyWith({
    List<String>? projectName,
    List<String>? flutterVersion,
    List<String>? dartVersion,
    List<String>? platform,
    List<String>? osVersion,
    List<String>? deviceModel,
    Map<String, dynamic>? additionalInfo,
  }) {
    return ErrorEnvironment(
      projectName: projectName ?? this.projectName,
      flutterVersion: flutterVersion ?? this.flutterVersion,
      dartVersion: dartVersion ?? this.dartVersion,
      platform: platform ?? this.platform,
      osVersion: osVersion ?? this.osVersion,
      deviceModel: deviceModel ?? this.deviceModel,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  ErrorEnvironment copy() {
    return ErrorEnvironment(
      projectName: List<String>.from(projectName ?? []),
      flutterVersion: List<String>.from(flutterVersion ?? []),
      dartVersion: List<String>.from(dartVersion ?? []),
      platform: List<String>.from(platform ?? []),
      osVersion: List<String>.from(osVersion ?? []),
      deviceModel: List<String>.from(deviceModel ?? []),
      additionalInfo: Map<String, dynamic>.from(additionalInfo),
    );
  }
}
