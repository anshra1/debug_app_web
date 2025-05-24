import 'package:debug_app_web/core/constants/keys.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_environment.freezed.dart';
part 'error_environment.g.dart';

@Freezed()
class ErrorEnvironment with _$ErrorEnvironment {
  const factory ErrorEnvironment({
    
    @JsonKey(name: ErrorEnvironmentKeys.flutterVersion) required String flutterVersion,
    @JsonKey(name: ErrorEnvironmentKeys.dartVersion) required String dartVersion,
    @JsonKey(name: ErrorEnvironmentKeys.platform) required String platform,
    @JsonKey(name: ErrorEnvironmentKeys.osVersion) String? osVersion,
    @JsonKey(name: ErrorEnvironmentKeys.deviceModel) String? deviceModel,
   
    
  }) = _ErrorEnvironment;

  factory ErrorEnvironment.fromJson(Map<String, Object> json) =>
      _$ErrorEnvironmentFromJson(json);
}
