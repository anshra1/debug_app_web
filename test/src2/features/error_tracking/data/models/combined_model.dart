// import 'package:debug_app_web/src/features/error_tracking/domain/entities/comment.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';

// class CommentModel extends Comment {
//   const CommentModel({
//     required super.id,
//     required super.author,
//     required super.text,
//     required super.dateAdded,
//     super.additionalInfo,
//   });

//   factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
//         id: json[EntityKeys.commentId] as String? ?? '',
//         author: json[EntityKeys.commentAuthor] as String? ?? '',
//         text: json[EntityKeys.commentText] as String? ?? '',
//         dateAdded: DateTime.tryParse(
//               json[EntityKeys.commentDateAdded] as String? ?? '',
//             ) ??
//             DateTime.now(),
//         additionalInfo:
//             json[EntityKeys.commentAdditionalInfo] as Map<String, dynamic>? ?? {},
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.commentId: id,
//         EntityKeys.commentAuthor: author,
//         EntityKeys.commentText: text,
//         EntityKeys.commentDateAdded: dateAdded.toIso8601String(),
//         EntityKeys.commentAdditionalInfo: additionalInfo,
//       };

//   CommentModel copy() {
//     return CommentModel(
//       id: id,
//       author: author,
//       text: text,
//       dateAdded: dateAdded,
//       additionalInfo: additionalInfo,
//     );
//   }

//   CommentModel copyWith({
//     String? id,
//     String? author,
//     String? text,
//     DateTime? dateAdded,
//     Map<String, dynamic>? additionalInfo,
//   }) {
//     return CommentModel(
//       id: id ?? this.id,
//       author: author ?? this.author,
//       text: text ?? this.text,
//       dateAdded: dateAdded ?? this.dateAdded,
//       additionalInfo: additionalInfo ?? this.additionalInfo,
//     );
//   }

//   @override
//   List<Object?> get props => [id, author, text, dateAdded, additionalInfo];
// }


// import 'package:debug_app_web/src/features/error_tracking/data/models/comment_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/comment.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:equatable/equatable.dart';

// class SolutionModel extends Equatable {
//   const SolutionModel({
//     required this.id,
//     required this.codes,
//     required this.humanDescription,
//     required this.date,
//     required this.upvotes,
//     required this.downvotes,
//     required this.isVerified,
//     required this.environment,
//     required this.url,
//     required this.comments,
//   });

//   factory SolutionModel.fromJson(Map<String, dynamic> json) => SolutionModel(
//         id: json[EntityKeys.solutionId] as String? ?? '',
//         codes: json[EntityKeys.codes] as String? ?? '',
//         humanDescription: json[EntityKeys.humanDescription] as String? ?? '',
//         date: json[EntityKeys.created] as String? ?? '',
//         upvotes: json[EntityKeys.upvotes] as int? ?? 0,
//         downvotes: json[EntityKeys.downvotes] as int? ?? 0,
//         isVerified: json[EntityKeys.isVerified] as bool? ?? false,
//         environment: SolutionEnvironmentModel.fromJson(
//           json[EntityKeys.environment] as Map<String, dynamic>,
//         ),
//         url: json[EntityKeys.url] as String? ?? '',
//         comments: (json[EntityKeys.comments] as List?)
//                 ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
//                 .toList() ??
//             [],
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.solutionId: id,
//         EntityKeys.codes: codes,
//         EntityKeys.humanDescription: humanDescription,
//         EntityKeys.created: date,
//         EntityKeys.upvotes: upvotes,
//         EntityKeys.downvotes: downvotes,
//         EntityKeys.isVerified: isVerified,
//         EntityKeys.environment: environment?.toJson(),
//         EntityKeys.url: url,
//         EntityKeys.comments:
//             (comments as List<CommentModel>?)?.map((c) => c.toJson()).toList(),
//       };

//   SolutionModel copyWith({
//     String? id,
//     String? codes,
//     String? humanDescription,
//     String? date,
//     int? upvotes,
//     int? downvotes,
//     bool? isVerified,
//     SolutionEnvironmentModel? environment,
//     String? url,
//     List<Comment>? comments,
//   }) {
//     return SolutionModel(
//       id: id ?? this.id,
//       codes: codes ?? this.codes,
//       humanDescription: humanDescription ?? this.humanDescription,
//       date: date ?? this.date,
//       upvotes: upvotes ?? this.upvotes,
//       downvotes: downvotes ?? this.downvotes,
//       isVerified: isVerified ?? this.isVerified,
//       environment: environment ?? this.environment,
//       url: url ?? this.url,
//       comments: comments ?? this.comments,
//     );
//   }

//   SolutionModel copy() {
//     return SolutionModel(
//       id: id,
//       codes: codes,
//       humanDescription: humanDescription,
//       date: date,
//       upvotes: upvotes,
//       downvotes: downvotes,
//       isVerified: isVerified,
//       environment: environment,
//       url: url,
//       comments: comments,
//     );
//   }

//   final String? id;
//   final String? codes;
//   final String? humanDescription;
//   final String? date;
//   final int? upvotes;
//   final int? downvotes;
//   final bool? isVerified;
//   final SolutionEnvironmentModel? environment;
//   final String? url;
//   final List<Comment>? comments;

//   @override
//   List<Object?> get props => [
//         id,
//         codes,
//         humanDescription,
//         date,
//         upvotes,
//         downvotes,
//         isVerified,
//         environment,
//         url,
//         comments,
//       ];
// }

// class SolutionEnvironmentModel extends Equatable {
//   const SolutionEnvironmentModel({
//     required this.projectName,
//     required this.flutterVersion,
//     required this.dartVersion,
//     required this.platform,
//     this.osVersion,
//     this.deviceModel,
//     this.additionalInfo = const {},
//   });

//   factory SolutionEnvironmentModel.fromJson(Map<String, dynamic> json) =>
//       SolutionEnvironmentModel(
//         projectName: json[EntityKeys.projectName] as String? ?? '',
//         flutterVersion: json[EntityKeys.flutterVersion] as String? ?? '',
//         dartVersion: json[EntityKeys.dartVersion] as String? ?? '',
//         platform: json[EntityKeys.platform] as String? ?? '',
//         osVersion: json[EntityKeys.osVersion] as String?,
//         deviceModel: json[EntityKeys.deviceModel] as String?,
//         additionalInfo:
//             json[EntityKeys.additionalInfo] as Map<String, dynamic>? ?? const {},
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.projectName: projectName,
//         EntityKeys.flutterVersion: flutterVersion,
//         EntityKeys.dartVersion: dartVersion,
//         EntityKeys.platform: platform,
//         if (osVersion != null) EntityKeys.osVersion: osVersion,
//         if (deviceModel != null) EntityKeys.deviceModel: deviceModel,
//         EntityKeys.additionalInfo: additionalInfo,
//       };

//   SolutionEnvironmentModel copyWith({
//     String? projectName,
//     String? flutterVersion,
//     String? dartVersion,
//     String? platform,
//     String? osVersion,
//     String? deviceModel,
//     Map<String, dynamic>? additionalInfo,
//   }) {
//     return SolutionEnvironmentModel(
//       projectName: projectName ?? this.projectName,
//       flutterVersion: flutterVersion ?? this.flutterVersion,
//       dartVersion: dartVersion ?? this.dartVersion,
//       platform: platform ?? this.platform,
//       osVersion: osVersion ?? this.osVersion,
//       deviceModel: deviceModel ?? this.deviceModel,
//       additionalInfo: additionalInfo ?? this.additionalInfo,
//     );
//   }

//   final String projectName;
//   final String flutterVersion;
//   final String dartVersion;
//   final String platform;
//   final String? osVersion;
//   final String? deviceModel;
//   final Map<String, dynamic> additionalInfo;

//   @override
//   List<Object?> get props => [
//         projectName,
//         flutterVersion,
//         dartVersion,
//         platform,
//         osVersion,
//         deviceModel,
//         additionalInfo,
//       ];
// }


// import 'package:debug_app_web/src/features/error_tracking/data/models/comment_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_details_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_environment_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_tracking_dates_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/solution_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/comment.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_environment.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_tracking_entity.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/solution.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/enum/enum.dart';

// class ErrorTrackingEntityModel extends ErrorTrackingEntity {
//   const ErrorTrackingEntityModel({
//     required super.id,
//     required super.details,
//     required super.errorPriority,
//     required super.environment,
//     super.errorCategory,
//     super.tags,
//     super.dates,
//     super.embeddingText,
//     super.errorState,
//     super.similarityScore,
//     super.errorFrequency,
//     super.timeToResolve,
//     super.solutions,
//     super.comments,
//     super.relatedErrors,
//     super.totalOccurrences,
//   });

//   factory ErrorTrackingEntityModel.fromJson(Map<String, dynamic> json) =>
//       ErrorTrackingEntityModel(
//         id: json[EntityKeys.errorId] as String? ?? '',
//         details:
//             ErrorDetailsModel.fromJson(json[EntityKeys.details] as Map<String, dynamic>),
//         errorPriority: ErrorPriority.values[json[EntityKeys.errorPriority] as int],
//         environment: ErrorEnvironmentModel.fromJson(
//           json[EntityKeys.environment] as Map<String, dynamic>,
//         ) as ErrorEnvironment,
//         errorCategory: json[EntityKeys.errorCategory] != null
//             ? ErrorCategory.values[json[EntityKeys.errorCategory] as int]
//             : null,
//         tags: (json[EntityKeys.tags] as List<dynamic>?)?.map((e) => e as String).toList(),
//         dates: json[EntityKeys.dates] != null
//             ? ErrorTrackingDatesModel.fromJson(
//                 json[EntityKeys.dates] as Map<String, dynamic>,
//               )
//             : null,
//         embeddingText: json[EntityKeys.embeddingText] as String?,
//         errorState: json[EntityKeys.errorState] != null
//             ? ErrorStates.values[json[EntityKeys.errorState] as int]
//             : null,
//         similarityScore: json[EntityKeys.similarityScore] as int?,
//         errorFrequency: json[EntityKeys.errorFrequency] as int?,
//         timeToResolve: json[EntityKeys.timeToResolve] != null
//             ? Duration(milliseconds: json[EntityKeys.timeToResolve] as int)
//             : null,
//         solutions: (json[EntityKeys.solutions] as List<dynamic>?)
//             ?.map((e) => SolutionModel.fromJson(e as Map<String, dynamic>))
//             .cast<Solution>()
//             .toList(),
//         comments: (json[EntityKeys.comments] as List<dynamic>?)
//             ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         relatedErrors: (json[EntityKeys.relatedErrors] as List<dynamic>?)
//             ?.map((e) => e as String)
//             .toList(),
//         totalOccurrences: json[EntityKeys.totalOccurrences] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.errorId: id,
//         EntityKeys.details: (details as ErrorDetailsModel).toJson(),
//         EntityKeys.errorPriority: errorPriority.index,
//         EntityKeys.environment: (environment! as ErrorEnvironmentModel).toJson(),
//         if (errorCategory != null) EntityKeys.errorCategory: errorCategory!.index,
//         if (tags != null) EntityKeys.tags: tags,
//         if (dates != null) EntityKeys.dates: (dates! as ErrorTrackingDatesModel).toJson(),
//         if (embeddingText != null) EntityKeys.embeddingText: embeddingText,
//         if (errorState != null) EntityKeys.errorState: errorState!.index,
//         if (similarityScore != null) EntityKeys.similarityScore: similarityScore,
//         if (errorFrequency != null) EntityKeys.errorFrequency: errorFrequency,
//         if (timeToResolve != null)
//           EntityKeys.timeToResolve: timeToResolve!.inMilliseconds,
//         if (solutions != null)
//           EntityKeys.solutions:
//               solutions!.map((e) => (e as SolutionModel).toJson()).toList(),
//         if (comments != null)
//           EntityKeys.comments:
//               comments!.map((e) => (e as CommentModel).toJson()).toList(),
//         if (relatedErrors != null) EntityKeys.relatedErrors: relatedErrors,
//         if (totalOccurrences != null) EntityKeys.totalOccurrences: totalOccurrences,
//       };

//   ErrorTrackingEntityModel copyWith({
//     String? id,
//     ErrorDetailsModel? details,
//     ErrorPriority? errorPriority,
//     ErrorEnvironmentModel? environment,
//     ErrorCategory? errorCategory,
//     List<String>? tags,
//     ErrorTrackingDatesModel? dates,
//     String? embeddingText,
//     ErrorStates? errorState,
//     int? similarityScore,
//     int? errorFrequency,
//     Duration? timeToResolve,
//     List<Solution>? solutions,
//     List<Comment>? comments,
//     List<String>? relatedErrors,
//     int? totalOccurrences,
//   }) {
//     return ErrorTrackingEntityModel(
//       id: id ?? this.id,
//       details: details ?? this.details as ErrorDetailsModel,
//       errorPriority: errorPriority ?? this.errorPriority,
//       environment: environment ?? this.environment! as ErrorEnvironmentModel,
//       errorCategory: errorCategory ?? this.errorCategory,
//       tags: tags ?? this.tags,
//       dates: dates ?? this.dates! as ErrorTrackingDatesModel,
//       embeddingText: embeddingText ?? this.embeddingText,
//       errorState: errorState ?? this.errorState,
//       similarityScore: similarityScore ?? this.similarityScore,
//       errorFrequency: errorFrequency ?? this.errorFrequency,
//       timeToResolve: timeToResolve ?? this.timeToResolve,
//       solutions: solutions ?? this.solutions,
//       comments: comments ?? this.comments,
//       relatedErrors: relatedErrors ?? this.relatedErrors,
//       totalOccurrences: totalOccurrences ?? this.totalOccurrences,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         details,
//         errorPriority,
//         errorCategory,
//         tags,
//         environment,
//         dates,
//         embeddingText,
//         errorState,
//         similarityScore,
//         errorFrequency,
//         timeToResolve,
//         solutions,
//         comments,
//         relatedErrors,
//         totalOccurrences,
//       ];
// }


// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_tracking_dates.dart';

// class ErrorTrackingDatesModel extends ErrorTrackingDates {
//   const ErrorTrackingDatesModel({
//     required super.created,
//     required super.modified,
//     required super.lastOccurrence,
//   });

//   factory ErrorTrackingDatesModel.fromJson(Map<String, dynamic> json) =>
//       ErrorTrackingDatesModel(
//         created: DateTime.parse(
//           json[EntityKeys.created] as String? ?? DateTime.now().toIso8601String(),
//         ),
//         modified: json[EntityKeys.modified] != null
//             ? DateTime.parse(json[EntityKeys.modified] as String)
//             : null,
//         lastOccurrence: DateTime.parse(
//           json[EntityKeys.lastOccurrence] as String? ?? DateTime.now().toIso8601String(),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.created: created?.toIso8601String(),
//         if (modified != null) EntityKeys.modified: modified?.toIso8601String(),
//         EntityKeys.lastOccurrence: lastOccurrence.toIso8601String(),
//       };

//   ErrorTrackingDatesModel copyWith({
//     DateTime? created,
//     DateTime? modified,
//     DateTime? lastOccurrence,
//   }) {
//     return ErrorTrackingDatesModel(
//       created: created ?? this.created,
//       modified: modified ?? this.modified,
//       lastOccurrence: lastOccurrence ?? this.lastOccurrence,
//     );
//   }

//   ErrorTrackingDatesModel copy() {
//     return ErrorTrackingDatesModel(
//       created: created,
//       modified: modified,
//       lastOccurrence: lastOccurrence,
//     );
//   }

//   @override
//   List<Object?> get props => [created, modified, lastOccurrence];
// }


// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_environment.dart';

// class ErrorEnvironmentModel extends ErrorEnvironment {
//   const ErrorEnvironmentModel({
//     required super.projectName,
//     required super.flutterVersion,
//     required super.dartVersion,
//     required super.platform,
//     super.osVersion,
//     super.deviceModel,
//     super.additionalInfo,
//   });

//   factory ErrorEnvironmentModel.fromJson(Map<String, dynamic> json) =>
//       ErrorEnvironmentModel(
//         projectName: (json[EntityKeys.projectName] as List<dynamic>?)
//                 ?.map((e) => e as String)
//                 .toList() ??
//             [],
//         flutterVersion: (json[EntityKeys.flutterVersion] as List<dynamic>?)
//                 ?.map((e) => e as String)
//                 .toList() ??
//             [],
//         dartVersion: (json[EntityKeys.dartVersion] as List<dynamic>?)
//                 ?.map((e) => e as String)
//                 .toList() ??
//             [],
//         platform: (json[EntityKeys.platform] as List<dynamic>?)
//                 ?.map((e) => e as String)
//                 .toList() ??
//             [],
//         osVersion: (json[EntityKeys.osVersion] as List<dynamic>?)
//             ?.map((e) => e as String)
//             .toList(),
//         deviceModel: (json[EntityKeys.deviceModel] as List<dynamic>?)
//             ?.map((e) => e as String)
//             .toList(),
//         additionalInfo: json[EntityKeys.additionalInfo] as Map<String, dynamic>? ?? {},
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.projectName: projectName,
//         EntityKeys.flutterVersion: flutterVersion,
//         EntityKeys.dartVersion: dartVersion,
//         EntityKeys.platform: platform,
//         EntityKeys.osVersion: osVersion,
//         EntityKeys.deviceModel: deviceModel,
//         EntityKeys.additionalInfo: additionalInfo,
//       };

//   ErrorEnvironmentModel copyWith({
//     List<String>? projectName,
//     List<String>? flutterVersion,
//     List<String>? dartVersion,
//     List<String>? platform,
//     List<String>? osVersion,
//     List<String>? deviceModel,
//     Map<String, dynamic>? additionalInfo,
//   }) {
//     return ErrorEnvironmentModel(
//       projectName: projectName ?? this.projectName,
//       flutterVersion: flutterVersion ?? this.flutterVersion,
//       dartVersion: dartVersion ?? this.dartVersion,
//       platform: platform ?? this.platform,
//       osVersion: osVersion ?? this.osVersion,
//       deviceModel: deviceModel ?? this.deviceModel,
//       additionalInfo: additionalInfo ?? this.additionalInfo,
//     );
//   }

//   ErrorEnvironmentModel copy() {
//     return ErrorEnvironmentModel(
//       projectName: projectName,
//       flutterVersion: flutterVersion,
//       dartVersion: dartVersion,
//       platform: platform,
//       osVersion: osVersion,
//       deviceModel: deviceModel,
//       additionalInfo: additionalInfo,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         projectName,
//         flutterVersion,
//         dartVersion,
//         platform,
//         osVersion,
//         deviceModel,
//         additionalInfo,
//       ];
// }


// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_details.dart';
// import 'package:equatable/equatable.dart';

// class ErrorDetailsModel extends ErrorDetails with EquatableMixin {
//   const ErrorDetailsModel({
//     required super.id,
//     required super.rootCauseName,
//     required super.rootCauseLineNumber,
//     required super.stackTrace,
//     super.surroundingCode,
//     super.humanDescription,
//     super.additionalInfo,
//   });

//   factory ErrorDetailsModel.fromJson(Map<String, dynamic> json) => ErrorDetailsModel(
//         id: json[EntityKeys.errorId] as String? ?? '',
//         rootCauseName: json[EntityKeys.rootCauseName] as String? ?? '',
//         rootCauseLineNumber: json[EntityKeys.rootCauseLineNumber] as String? ?? '',
//         stackTrace: json[EntityKeys.stackTrace] as String? ?? '',
//         surroundingCode: json[EntityKeys.surroundingCode] as String?,
//         humanDescription: json[EntityKeys.humanDescription] as String?,
//         additionalInfo: json[EntityKeys.additionalInfo] != null
//             ? Map<String, String>.from(json[EntityKeys.additionalInfo] as Map)
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         EntityKeys.errorId: id,
//         EntityKeys.rootCauseName: rootCauseName,
//         EntityKeys.rootCauseLineNumber: rootCauseLineNumber,
//         EntityKeys.stackTrace: stackTrace,
//         if (surroundingCode != null) EntityKeys.surroundingCode: surroundingCode,
//         if (humanDescription != null) EntityKeys.humanDescription: humanDescription,
//         if (additionalInfo != null) EntityKeys.additionalInfo: additionalInfo,
//       };

//   ErrorDetailsModel copyWith({
//     String? id,
//     String? rootCauseName,
//     String? rootCauseLineNumber,
//     String? stackTrace,
//     String? surroundingCode,
//     String? humanDescription,
//     Map<String, String>? additionalInfo,
//   }) {
//     return ErrorDetailsModel(
//       id: id ?? this.id,
//       rootCauseName: rootCauseName ?? this.rootCauseName,
//       rootCauseLineNumber: rootCauseLineNumber ?? this.rootCauseLineNumber,
//       stackTrace: stackTrace ?? this.stackTrace,
//       surroundingCode: surroundingCode ?? this.surroundingCode,
//       humanDescription: humanDescription ?? this.humanDescription,
//       additionalInfo: additionalInfo ?? this.additionalInfo,
//     );
//   }

//   ErrorDetailsModel copy() {
//     return ErrorDetailsModel(
//       id: id,
//       rootCauseName: rootCauseName,
//       rootCauseLineNumber: rootCauseLineNumber,
//       stackTrace: stackTrace,
//       surroundingCode: surroundingCode,
//       humanDescription: humanDescription,
//       additionalInfo: additionalInfo,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         rootCauseName,
//         rootCauseLineNumber,
//         stackTrace,
//         surroundingCode,
//         humanDescription,
//         additionalInfo,
//       ];
// }


