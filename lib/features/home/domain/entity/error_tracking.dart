import 'package:debug_app_web/core/constants/keys.dart';
import 'package:debug_app_web/core/enum/error_category.dart';
import 'package:debug_app_web/core/enum/error_color_category.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/solution.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_tracking.freezed.dart';
part 'error_tracking.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ErrorTracking with _$ErrorTracking {
  const factory ErrorTracking({
    @JsonKey(name: ErrorTrackingKeys.id) required String id,
    @JsonKey(name: ErrorTrackingKeys.currentError) required CurrentError currentError,
    @JsonKey(name: ErrorTrackingKeys.solutions) required List<Solution> solutions,
    @JsonKey(name: ErrorTrackingKeys.errorCategory) required ErrorCategory errorCategory,
    @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
    required ErrorColorCategory errorColorCategory,
    @JsonKey(name: ErrorTrackingKeys.errorTags) required List<String> errorTags,
    @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
    required String fingerPrintHashing,
    @JsonKey(name: ErrorTrackingKeys.dates) required List<DateTime> dates,
  }) = _ErrorTracking;

  factory ErrorTracking.fromJson(Map<String, dynamic> json) =>
      _$ErrorTrackingFromJson(json);
}
