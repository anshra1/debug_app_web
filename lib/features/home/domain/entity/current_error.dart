import 'package:debug_app_web/core/constants/keys.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_error.freezed.dart';
part 'current_error.g.dart';

@Freezed()
class CurrentError with _$CurrentError {
  const factory CurrentError({
    @JsonKey(name: CurrentErrorKeys.id) required String id,
    @JsonKey(name: CurrentErrorKeys.error) required String error,
    @JsonKey(name: CurrentErrorKeys.platform) required String platform,
    @JsonKey(name: CurrentErrorKeys.additionalInfo)
    required Map<String, String>? additionalInfo,
    @JsonKey(name: CurrentErrorKeys.stackTrace) String? stackTrace,
  }) = _CurrentError;

  factory CurrentError.fromJson(Map<String, dynamic> json) =>
      _$CurrentErrorFromJson(json);
}
