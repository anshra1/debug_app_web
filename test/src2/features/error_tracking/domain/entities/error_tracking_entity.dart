import 'package:debug_app_web/src2/cores/enum/enum.dart';
import 'package:equatable/equatable.dart';

import 'comment.dart';
import 'current_error_details.dart';
import 'error_environment.dart';
import 'error_tracking_dates.dart';
import 'solution.dart';

class ErrorTrackingEntity extends Equatable {
  const ErrorTrackingEntity({
    required this.id,
    required this.details,
    this.errorPriority = ErrorPriority.low,
    this.errorCategory,
    this.tags,
    this.environment,
    this.dates,
    this.embeddingText,
    this.errorState,
    this.similarityScore,
    this.errorFrequency,
    this.timeToResolve,
    this.solutions,
    this.comments,
    this.relatedErrors,
    this.totalOccurrences,
  });

  final String id;
  final CurrentErrorDetails details;
  final ErrorPriority errorPriority;
  final List<ErrorEnvironment>? environments;
  final DebugErrorCategory? errorCategory;
  final List<String>? tags;
  final ErrorTrackingDates? dates;
  final String? embeddingText;
  final ErrorStates? errorState;
  final int? similarityScore;
  final int? errorFrequency;
  final Duration? timeToResolve;
  final List<Solution>? solutions;
  final List<Comment>? comments;
  final List<String>? relatedErrors;
  final int? totalOccurrences;

  @override
  List<Object?> get props =>
      [id, details, errorPriority, errorCategory, dates, embeddingText];
}
