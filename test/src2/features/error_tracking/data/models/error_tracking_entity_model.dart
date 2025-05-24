import 'package:debug_app_web/src2/cores/enum/enum.dart';

import '../../domain/entities/comment.dart';
import '../../domain/entities/entity_keys.dart';
import '../../domain/entities/error_environment.dart';
import '../../domain/entities/error_tracking_entity.dart';
import '../../domain/entities/solution.dart';
import 'comment_model.dart';
import 'current_error_details_model.dart';
import 'error_environment_model.dart';
import 'error_tracking_dates_model.dart';
import 'solution_model.dart';

class ErrorTrackingEntityModel extends ErrorTrackingEntity {
  const ErrorTrackingEntityModel({
    required super.id,
    required super.details,
    required super.errorPriority,
    required super.environment,
    super.errorCategory,
    super.tags,
    super.dates,
    super.embeddingText,
    super.errorState,
    super.similarityScore,
    super.errorFrequency,
    super.timeToResolve,
    super.solutions,
    super.comments,
    super.relatedErrors,
    super.totalOccurrences,
  });

  factory ErrorTrackingEntityModel.fromJson(Map<String, dynamic> json) =>
      ErrorTrackingEntityModel(
        id: json[EntityKeys.errorId] as String? ?? '',
        details:
            ErrorDetailsModel.fromJson(json[EntityKeys.details] as Map<String, dynamic>),
        errorPriority: ErrorPriority.values[json[EntityKeys.errorPriority] as int],
        environment: ErrorEnvironmentModel.fromJson(
          json[EntityKeys.environment] as Map<String, dynamic>,
        ) as ErrorEnvironment,
        errorCategory: json[EntityKeys.errorCategory] != null
            ? DebugErrorCategory.values[json[EntityKeys.errorCategory] as int]
            : null,
        tags: (json[EntityKeys.tags] as List<dynamic>?)?.map((e) => e as String).toList(),
        dates: json[EntityKeys.dates] != null
            ? ErrorTrackingDatesModel.fromJson(
                json[EntityKeys.dates] as Map<String, dynamic>,
              )
            : null,
        embeddingText: json[EntityKeys.embeddingText] as String?,
        errorState: json[EntityKeys.errorState] != null
            ? ErrorStates.values[json[EntityKeys.errorState] as int]
            : null,
        similarityScore: json[EntityKeys.similarityScore] as int?,
        errorFrequency: json[EntityKeys.errorFrequency] as int?,
        timeToResolve: json[EntityKeys.timeToResolve] != null
            ? Duration(milliseconds: json[EntityKeys.timeToResolve] as int)
            : null,
        solutions: (json[EntityKeys.solutions] as List<dynamic>?)
            ?.map((e) => SolutionModel.fromJson(e as Map<String, dynamic>).toEntity())
            .toList(),
        comments: (json[EntityKeys.comments] as List<dynamic>?)
            ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        relatedErrors: (json[EntityKeys.relatedErrors] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        totalOccurrences: json[EntityKeys.totalOccurrences] as int?,
      );

  Map<String, dynamic> toJson() => {
        EntityKeys.errorId: id,
        EntityKeys.details: (details as ErrorDetailsModel).toJson(),
        EntityKeys.errorPriority: errorPriority.index,
        EntityKeys.environment: (environment! as ErrorEnvironmentModel).toJson(),
        if (errorCategory != null) EntityKeys.errorCategory: errorCategory!.index,
        if (tags != null) EntityKeys.tags: tags,
        if (dates != null) EntityKeys.dates: (dates! as ErrorTrackingDatesModel).toJson(),
        if (embeddingText != null) EntityKeys.embeddingText: embeddingText,
        if (errorState != null) EntityKeys.errorState: errorState!.index,
        if (similarityScore != null) EntityKeys.similarityScore: similarityScore,
        if (errorFrequency != null) EntityKeys.errorFrequency: errorFrequency,
        if (timeToResolve != null)
          EntityKeys.timeToResolve: timeToResolve!.inMilliseconds,
        if (solutions != null)
          EntityKeys.solutions:
              solutions!.map((e) => SolutionModel.fromEntity(e).toJson()).toList(),
        if (comments != null)
          EntityKeys.comments:
              comments!.map((e) => CommentModel.fromEntity(e).toJson()).toList(),
        if (relatedErrors != null) EntityKeys.relatedErrors: relatedErrors,
        if (totalOccurrences != null) EntityKeys.totalOccurrences: totalOccurrences,
      };

  ErrorTrackingEntityModel copyWith({
    String? id,
    ErrorDetailsModel? details,
    ErrorPriority? errorPriority,
    ErrorEnvironmentModel? environment,
    DebugErrorCategory? errorCategory,
    List<String>? tags,
    ErrorTrackingDatesModel? dates,
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
    return ErrorTrackingEntityModel(
      id: id ?? this.id,
      details: details ?? this.details as ErrorDetailsModel,
      errorPriority: errorPriority ?? this.errorPriority,
      environment: environment ?? this.environment! as ErrorEnvironmentModel,
      errorCategory: errorCategory ?? this.errorCategory,
      tags: tags ?? this.tags,
      dates: dates ?? this.dates! as ErrorTrackingDatesModel,
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

extension ListConverter on List<dynamic>? {
  List<T>? toListOf<T>(T Function(dynamic) converter) {
    return this?.map(converter).toList();
  }
}
