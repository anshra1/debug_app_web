import 'package:debug_app_web/core/constants/keys.dart';
import 'package:debug_app_web/features/home/domain/entity/error_environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_error.freezed.dart';
part 'current_error.g.dart';

@Freezed()
class CurrentError with _$CurrentError {
  const factory CurrentError({
    @JsonKey(name: CurrentErrorKeys.stackTrace) required String stackTrace,
    @JsonKey(name: CurrentErrorKeys.error) required String error,
    @JsonKey(name: CurrentErrorKeys.environment) required ErrorEnvironment environment,
    @JsonKey(name: CurrentErrorKeys.date) required DateTime date,
  }) = _CurrentError;

  factory CurrentError.fromJson(Map<String, Object> json) => _$CurrentErrorFromJson(json);
}
