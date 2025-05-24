import '../../domain/entities/entity_keys.dart';
import '../../domain/entities/error_environment.dart';

class ErrorEnvironmentModel extends ErrorEnvironment {
  const ErrorEnvironmentModel({
    required super.projectName,
    required super.flutterVersion,
    required super.dartVersion,
    required super.platform,
    super.osVersion,
    super.deviceModel,
    super.additionalInfo,
  });

  factory ErrorEnvironmentModel.fromJson(Map<String, dynamic> json) =>
      ErrorEnvironmentModel(
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

  ErrorEnvironment toEntity() {
    return ErrorEnvironment(
      projectName: projectName,
      flutterVersion: flutterVersion,
      dartVersion: dartVersion,
      platform: platform,
      osVersion: osVersion,
      deviceModel: deviceModel,
      additionalInfo: additionalInfo,
    );
  }

  Map<String, dynamic> toJson() => {
        EntityKeys.projectName: projectName,
        EntityKeys.flutterVersion: flutterVersion,
        EntityKeys.dartVersion: dartVersion,
        EntityKeys.platform: platform,
        EntityKeys.osVersion: osVersion,
        EntityKeys.deviceModel: deviceModel,
        EntityKeys.additionalInfo: additionalInfo,
      };

  ErrorEnvironmentModel copyWith({
    List<String>? projectName,
    List<String>? flutterVersion,
    List<String>? dartVersion,
    List<String>? platform,
    List<String>? osVersion,
    List<String>? deviceModel,
    Map<String, dynamic>? additionalInfo,
  }) {
    return ErrorEnvironmentModel(
      projectName: projectName ?? this.projectName,
      flutterVersion: flutterVersion ?? this.flutterVersion,
      dartVersion: dartVersion ?? this.dartVersion,
      platform: platform ?? this.platform,
      osVersion: osVersion ?? this.osVersion,
      deviceModel: deviceModel ?? this.deviceModel,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  ErrorEnvironmentModel copy() {
    return ErrorEnvironmentModel(
      projectName: projectName,
      flutterVersion: flutterVersion,
      dartVersion: dartVersion,
      platform: platform,
      osVersion: osVersion,
      deviceModel: deviceModel,
      additionalInfo: additionalInfo,
    );
  }

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
}
