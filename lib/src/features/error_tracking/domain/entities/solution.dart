import 'package:debug_app_web/src/features/error_tracking/domain/entities/comment.dart';
import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:equatable/equatable.dart';

class Solution extends Equatable {
  const Solution({
    required this.id,
    required this.codes,
    required this.humanDescription,
    required this.date,
    required this.upvotes,
    required this.downvotes,
    required this.isVerified,
    required this.environment,
    required this.url,
    required this.comments,
  });

  factory Solution.fromJson(Map<String, dynamic> json) => Solution(
        id: json[EntityKeys.solutionId] as String? ?? '',
        codes: json[EntityKeys.codes] as String? ?? '',
        humanDescription: json[EntityKeys.humanDescription] as String? ?? '',
        date: json[EntityKeys.created] as String? ?? '',
        upvotes: json[EntityKeys.upvotes] as int? ?? 0,
        downvotes: json[EntityKeys.downvotes] as int? ?? 0,
        isVerified: json[EntityKeys.isVerified] as bool? ?? false,
        environment: SolutionEnvironment.fromJson(
            json[EntityKeys.environment] as Map<String, dynamic>),
        url: json[EntityKeys.url] as String? ?? '',
        comments: (json[EntityKeys.comments] as List?)
                ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        EntityKeys.solutionId: id,
        EntityKeys.codes: codes,
        EntityKeys.humanDescription: humanDescription,
        EntityKeys.created: date,
        EntityKeys.upvotes: upvotes,
        EntityKeys.downvotes: downvotes,
        EntityKeys.isVerified: isVerified,
        EntityKeys.environment: environment?.toJson(),
        EntityKeys.url: url,
        EntityKeys.comments: comments?.map((c) => c.toJson()).toList(),
      };

  Solution copyWith({
    String? id,
    String? codes,
    String? humanDescription,
    String? date,
    int? upvotes,
    int? downvotes,
    bool? isVerified,
    SolutionEnvironment? environment,
    String? url,
    List<Comment>? comments,
  }) {
    return Solution(
      id: id ?? this.id,
      codes: codes ?? this.codes,
      humanDescription: humanDescription ?? this.humanDescription,
      date: date ?? this.date,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      isVerified: isVerified ?? this.isVerified,
      environment: environment ?? this.environment,
      url: url ?? this.url,
      comments: comments ?? this.comments,
    );
  }

  final String? id;
  final String? codes;
  final String? humanDescription;
  final String? date;
  final int? upvotes;
  final int? downvotes;
  final bool? isVerified;
  final SolutionEnvironment? environment;
  final String? url; // Changed to String for clickable URL
  final List<Comment>? comments;

  @override
  List<Object?> get props => [
        id,
        codes,
        humanDescription,
        date,
        upvotes,
        downvotes,
        isVerified,
        environment,
        url,
        comments,
      ];
}

class SolutionEnvironment extends Equatable {
  const SolutionEnvironment({
    required this.projectName,
    required this.flutterVersion,
    required this.dartVersion,
    required this.platform,
    this.osVersion,
    this.deviceModel,
    this.additionalInfo = const {},
  });

  factory SolutionEnvironment.fromJson(Map<String, dynamic> json) => SolutionEnvironment(
        projectName: json[EntityKeys.projectName] as String? ?? '',
        flutterVersion: json[EntityKeys.flutterVersion] as String? ?? '',
        dartVersion: json[EntityKeys.dartVersion] as String? ?? '',
        platform: json[EntityKeys.platform] as String? ?? '',
        osVersion: json[EntityKeys.osVersion] as String?,
        deviceModel: json[EntityKeys.deviceModel] as String?,
        additionalInfo: json[EntityKeys.additionalInfo] as Map<String, dynamic>? ?? const {},
      );

  Map<String, dynamic> toJson() => {
        EntityKeys.projectName: projectName,
        EntityKeys.flutterVersion: flutterVersion,
        EntityKeys.dartVersion: dartVersion,
        EntityKeys.platform: platform,
        if (osVersion != null) EntityKeys.osVersion: osVersion,
        if (deviceModel != null) EntityKeys.deviceModel: deviceModel,
        EntityKeys.additionalInfo: additionalInfo,
      };

  SolutionEnvironment copyWith({
    String? projectName,
    String? flutterVersion,
    String? dartVersion,
    String? platform,
    String? osVersion,
    String? deviceModel,
    Map<String, dynamic>? additionalInfo,
  }) {
    return SolutionEnvironment(
      projectName: projectName ?? this.projectName,
      flutterVersion: flutterVersion ?? this.flutterVersion,
      dartVersion: dartVersion ?? this.dartVersion,
      platform: platform ?? this.platform,
      osVersion: osVersion ?? this.osVersion,
      deviceModel: deviceModel ?? this.deviceModel,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  final String projectName;
  final String flutterVersion;
  final String dartVersion;
  final String platform;
  final String? osVersion;
  final String? deviceModel;
  final Map<String, dynamic> additionalInfo;

  @override
  List<Object?> get props => [
        projectName,
        flutterVersion,
        dartVersion,
        platform,
        osVersion,
        deviceModel,
        additionalInfo,
      ];
}
