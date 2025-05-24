class ErrorDetailModelKeys {
  static const String id = 'id';
  static const String rootCauseName = 'rootCauseName';
  static const String rootCauseLineNumber = 'rootCauseLineNumber';
  static const String stackTrace = 'stackTrace';
  static const String surroundingCode = 'surroundingCode';
  static const String humanDescription = 'humanDescription';
  static const String additionalInfo = 'additionalInfo';
}

class ErrorDetailsModel {
  const ErrorDetailsModel({
    required this.id,
    required this.rootCauseName,
    required this.rootCauseLineNumber,
    required this.stackTrace,
    this.surroundingCode,
    this.humanDescription,
    this.additionalInfo,
  });

  factory ErrorDetailsModel.fromJson(Map<String, dynamic> json) {
    return ErrorDetailsModel(
      id: json[ErrorDetailModelKeys.id] as String? ?? '',
      rootCauseName: json[ErrorDetailModelKeys.rootCauseName] as String? ?? '',
      rootCauseLineNumber: json[ErrorDetailModelKeys.rootCauseLineNumber] as String? ?? '',
      stackTrace: json[ErrorDetailModelKeys.stackTrace] as String? ?? '',
      surroundingCode: json[ErrorDetailModelKeys.surroundingCode] as String?,
      humanDescription: json[ErrorDetailModelKeys.humanDescription] as String?,
      additionalInfo: json[ErrorDetailModelKeys.additionalInfo] != null
          ? Map<String, String>.from(json[ErrorDetailModelKeys.additionalInfo] as Map)
          : null,
    );
  }

  final String id;
  final String rootCauseName;
  final String rootCauseLineNumber;
  final String stackTrace;
  final String? surroundingCode;
  final String? humanDescription;
  final Map<String, String>? additionalInfo;

  Map<String, dynamic> toJson() {
    return {
      ErrorDetailModelKeys.id: id,
      ErrorDetailModelKeys.rootCauseName: rootCauseName,
      ErrorDetailModelKeys.rootCauseLineNumber: rootCauseLineNumber,
      ErrorDetailModelKeys.stackTrace: stackTrace,
      ErrorDetailModelKeys.surroundingCode: surroundingCode,
      ErrorDetailModelKeys.humanDescription: humanDescription,
      ErrorDetailModelKeys.additionalInfo: additionalInfo,
    };
  }
}