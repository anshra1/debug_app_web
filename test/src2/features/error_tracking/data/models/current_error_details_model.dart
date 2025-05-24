import 'package:equatable/equatable.dart';

import '../../domain/entities/current_error_details.dart';
import '../../domain/entities/entity_keys.dart';

class ErrorDetailsModel extends CurrentErrorDetails with EquatableMixin {
  const ErrorDetailsModel({
    required super.id,
    required super.rootCauseName,
    required super.rootCauseLineNumber,
    required super.stackTrace,
    super.surroundingCode,
    super.humanDescription,
    super.additionalInfo,
  });

  factory ErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      ErrorDetailsModel(
        id: json[EntityKeys.errorId] as String? ?? '',
        rootCauseName: json[EntityKeys.rootCauseName] as String? ?? '',
        rootCauseLineNumber:
            json[EntityKeys.rootCauseLineNumber] as String? ?? '',
        stackTrace: json[EntityKeys.stackTrace] as String? ?? '',
        surroundingCode: json[EntityKeys.surroundingCode] as String?,
        humanDescription: json[EntityKeys.humanDescription] as String?,
        additionalInfo: json[EntityKeys.additionalInfo] != null
            ? Map<String, String>.from(json[EntityKeys.additionalInfo] as Map)
            : null,
      );

  Map<String, dynamic> toJson() => {
        EntityKeys.errorId: id,
        EntityKeys.rootCauseName: rootCauseName,
        EntityKeys.rootCauseLineNumber: rootCauseLineNumber,
        EntityKeys.stackTrace: stackTrace,
        if (surroundingCode != null)
          EntityKeys.surroundingCode: surroundingCode,
        if (humanDescription != null)
          EntityKeys.humanDescription: humanDescription,
        if (additionalInfo != null) EntityKeys.additionalInfo: additionalInfo,
      };

  ErrorDetailsModel copyWith({
    String? id,
    String? rootCauseName,
    String? rootCauseLineNumber,
    String? stackTrace,
    String? surroundingCode,
    String? humanDescription,
    Map<String, String>? additionalInfo,
  }) {
    return ErrorDetailsModel(
      id: id ?? this.id,
      rootCauseName: rootCauseName ?? this.rootCauseName,
      rootCauseLineNumber: rootCauseLineNumber ?? this.rootCauseLineNumber,
      stackTrace: stackTrace ?? this.stackTrace,
      surroundingCode: surroundingCode ?? this.surroundingCode,
      humanDescription: humanDescription ?? this.humanDescription,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  ErrorDetailsModel copy() {
    return ErrorDetailsModel(
      id: id,
      rootCauseName: rootCauseName,
      rootCauseLineNumber: rootCauseLineNumber,
      stackTrace: stackTrace,
      surroundingCode: surroundingCode,
      humanDescription: humanDescription,
      additionalInfo: additionalInfo,
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
