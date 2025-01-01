import 'package:debug_app_web/src/features/error_tracking/domain/entities/comment.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_details.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_environment.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_tracking_dates.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/solution.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/enum/enum.dart';
import 'package:equatable/equatable.dart';

class ErrorTrackingEntity extends Equatable {
  const ErrorTrackingEntity({
    required this.id,
    required this.details,
    required this.errorPriority,
    required this.errorCategory,
    required this.tags,
    required this.environment,
    required this.dates,
    required this.embeddingText,
    required this.errorState,
    required this.similarityScore,
    required this.errorFrequency,
    required this.timeToResolve,
    required this.solutions,
    required this.comments,
    required this.relatedErrors,
    required this.totalOccurrences,
  });

  factory ErrorTrackingEntity.fromJson(Map<String, dynamic> json) => ErrorTrackingEntity(
        id: json[EntityKeys.trackingId] as String,
        details: ErrorDetails.fromJson(json[EntityKeys.details] as Map<String, dynamic>),
        errorPriority: ErrorPriority.values.firstWhere(
          (e) => e.toString() == json[EntityKeys.errorPriority] as String,
        ),
        errorCategory: json[EntityKeys.errorCategory] != null
            ? ErrorCategory.values.firstWhere(
                (e) => e.toString() == json[EntityKeys.errorCategory] as String,
              )
            : null,
        tags: (json[EntityKeys.tags] as List?)?.cast<String>(),
        environment: ErrorEnvironment.fromJson(
          json[EntityKeys.environment] as Map<String, dynamic>,
        ),
        dates: json[EntityKeys.dates] != null
            ? ErrorTrackingDates.fromJson(json[EntityKeys.dates] as Map<String, dynamic>)
            : null,
        embeddingText: json[EntityKeys.embeddingText] as String?,
        errorState: json[EntityKeys.errorState] != null
            ? ErrorStates.values.firstWhere(
                (e) => e.toString() == json[EntityKeys.errorState] as String,
              )
            : null,
        similarityScore: json[EntityKeys.similarityScore] as int?,
        errorFrequency: json[EntityKeys.errorFrequency] as int?,
        timeToResolve: json[EntityKeys.timeToResolve] != null
            ? Duration(seconds: json[EntityKeys.timeToResolve] as int)
            : null,
        solutions: (json[EntityKeys.solutions] as List?)
            ?.map((e) => Solution.fromJson(e as Map<String, dynamic>))
            .toList(),
        comments: (json[EntityKeys.comments] as List?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList(),
        relatedErrors: (json[EntityKeys.relatedErrors] as List?)?.cast<String>(),
        totalOccurrences: json[EntityKeys.totalOccurrences] as int?,
      );

  final String id;
  final ErrorDetails details;
  final ErrorPriority errorPriority;
  final ErrorEnvironment environment;
  final ErrorCategory? errorCategory;
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

  Map<String, dynamic> toJson() => {
        EntityKeys.trackingId: id,
        EntityKeys.details: details.toJson(),
        EntityKeys.errorPriority: errorPriority.toString(),
        if (errorCategory != null) EntityKeys.errorCategory: errorCategory.toString(),
        if (tags != null) EntityKeys.tags: tags,
        EntityKeys.environment: environment.toJson(),
        if (dates != null) EntityKeys.dates: dates?.toJson(),
        if (embeddingText != null) EntityKeys.embeddingText: embeddingText,
        if (errorState != null) EntityKeys.errorState: errorState.toString(),
        if (similarityScore != null) EntityKeys.similarityScore: similarityScore,
        if (errorFrequency != null) EntityKeys.errorFrequency: errorFrequency,
        if (timeToResolve != null) EntityKeys.timeToResolve: timeToResolve?.inSeconds,
        if (solutions != null)
          EntityKeys.solutions: solutions?.map((e) => e.toJson()).toList(),
        if (comments != null)
          EntityKeys.comments: comments?.map((e) => e.toJson()).toList(),
        if (relatedErrors != null) EntityKeys.relatedErrors: relatedErrors,
        if (totalOccurrences != null) EntityKeys.totalOccurrences: totalOccurrences,
      };

  ErrorTrackingEntity copyWith({
    String? id,
    ErrorDetails? details,
    ErrorPriority? errorPriority,
    ErrorEnvironment? environment,
    ErrorCategory? errorCategory,
    List<String>? tags,
    ErrorTrackingDates? dates,
    String? embeddingText,
    ErrorStates? errorState,
    int? similarityScore,
    int? errorFrequency,
    Duration? timeToResolve,
    List<Solution>? solutions,
    List<Comment>? comments,
    List<String>? relatedErrors,
    int? totalOccurrences,
  }) {
    return ErrorTrackingEntity(
      id: id ?? this.id,
      details: details ?? this.details,
      errorPriority: errorPriority ?? this.errorPriority,
      environment: environment ?? this.environment,
      errorCategory: errorCategory ?? this.errorCategory,
      tags: tags ?? this.tags,
      dates: dates ?? this.dates,
      embeddingText: embeddingText ?? this.embeddingText,
      errorState: errorState ?? this.errorState,
      similarityScore: similarityScore ?? this.similarityScore,
      errorFrequency: errorFrequency ?? this.errorFrequency,
      timeToResolve: timeToResolve ?? this.timeToResolve,
      solutions: solutions ?? this.solutions,
      comments: comments ?? this.comments,
      relatedErrors: relatedErrors ?? this.relatedErrors,
      totalOccurrences: totalOccurrences ?? this.totalOccurrences,
    );
  }

  @override
  List<Object?> get props => [
        id,
        details,
        errorPriority,
        errorCategory,
        tags,
        environment,
        dates,
        embeddingText,
        errorState,
        similarityScore,
        errorFrequency,
        timeToResolve,
        solutions,
        comments,
        relatedErrors,
        totalOccurrences,
      ];
}
