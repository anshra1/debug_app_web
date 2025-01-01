import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:equatable/equatable.dart';

class ErrorDetails extends Equatable {
  const ErrorDetails({
    required this.id,
    required this.rootCauseName,
    required this.rootCauseLineNumber,
    required this.stackTrace,
    this.surroundingCode,
    this.humanDescription,
    this.additionalInfo,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) => ErrorDetails(
        id: json[EntityKeys.errorId] as String? ?? '',
        rootCauseName: json[EntityKeys.rootCauseName] as String? ?? '',
        rootCauseLineNumber: json[EntityKeys.rootCauseLineNumber] as String? ?? '',
        stackTrace: json[EntityKeys.stackTrace] as String? ?? '',
        surroundingCode: json[EntityKeys.surroundingCode] as String?,
        humanDescription: json[EntityKeys.humanDescription] as String?,
        additionalInfo: json[EntityKeys.additionalInfo] != null
            ? Map<String, String>.from(json[EntityKeys.additionalInfo] as Map)
            : null,
      );

  final String id;
  final String rootCauseName;
  final String rootCauseLineNumber;
  final String stackTrace;
  final String? surroundingCode;
  final String? humanDescription;
  final Map<String, String>? additionalInfo;

  Map<String, dynamic> toJson() => {
        EntityKeys.errorId: id,
        EntityKeys.rootCauseName: rootCauseName,
        EntityKeys.rootCauseLineNumber: rootCauseLineNumber,
        EntityKeys.stackTrace: stackTrace,
        if (surroundingCode != null) EntityKeys.surroundingCode: surroundingCode,
        if (humanDescription != null) EntityKeys.humanDescription: humanDescription,
        if (additionalInfo != null) EntityKeys.additionalInfo: additionalInfo,
      };

  ErrorDetails copyWith({
    String? id,
    String? rootCauseName,
    String? rootCauseLineNumber,
    String? stackTrace,
    String? surroundingCode,
    String? humanDescription,
    Map<String, String>? additionalInfo,
  }) {
    return ErrorDetails(
      id: id ?? this.id,
      rootCauseName: rootCauseName ?? this.rootCauseName,
      rootCauseLineNumber: rootCauseLineNumber ?? this.rootCauseLineNumber,
      stackTrace: stackTrace ?? this.stackTrace,
      surroundingCode: surroundingCode ?? this.surroundingCode,
      humanDescription: humanDescription ?? this.humanDescription,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        rootCauseName,
        rootCauseLineNumber,
        stackTrace,
        surroundingCode,
        humanDescription,
        additionalInfo,
      ];
}
