// import 'package:equatable/equatable.dart';

// import '../../domain/entities/comment.dart';
// import '../../domain/entities/entity_keys.dart';
// import '../../domain/entities/solution.dart';
// import 'comment_model.dart';

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

//   factory SolutionModel.fromEntity(Solution entity) {
//     return SolutionModel(
//       id: entity.id ?? '',
//       codes: entity.codes ?? '',
//       humanDescription: entity.humanDescription ?? '',
//       date: entity.date ?? '',
//       upvotes: entity.upvotes ?? 0,
//       downvotes: entity.downvotes ?? 0,
//       isVerified: entity.isVerified ?? false,
//       environment: SolutionEnvironmentModel.fromEntity(entity.environment!),
//       url: entity.url ?? '',
//       comments: entity.comments?.map(CommentModel.fromEntity).toList() ?? <Comment>[],
//     );
//   }
//   Solution toEntity() {
//     return Solution(
//       id: id,
//       codes: codes,
//       humanDescription: humanDescription,
//       date: date,
//       upvotes: upvotes,
//       downvotes: downvotes,
//       isVerified: isVerified,
//       environment: environment?.toEntity(), // Convert environment if applicable
//       url: url,
//       comments: comments,
//     );
//   }

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
//         EntityKeys.comments: comments?.map((c) => (c as CommentModel).toJson()).toList(),
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
//   final bool? isVerified; // remove this
//   final SolutionEnvironmentModel? environment;
//   final String? url; // remove this
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

//   factory SolutionEnvironmentModel.fromEntity(SolutionEnvironment entity) {
//     return SolutionEnvironmentModel(
//       projectName: entity.projectName,
//       flutterVersion: entity.flutterVersion,
//       dartVersion: entity.dartVersion,
//       platform: entity.platform,
//       osVersion: entity.osVersion,
//       deviceModel: entity.deviceModel,
//       additionalInfo: entity.additionalInfo,
//     );
//   }

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

//   SolutionEnvironment toEntity() {
//     return SolutionEnvironment(
//       projectName: projectName,
//       flutterVersion: flutterVersion,
//       dartVersion: dartVersion,
//       platform: platform,
//       osVersion: osVersion,
//       deviceModel: deviceModel,
//       additionalInfo: additionalInfo,
//     );
//   }

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
