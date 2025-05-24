import 'package:equatable/equatable.dart';

import 'comment.dart';

class Solution extends Equatable {
  const Solution({
    required this.id,
    required this.codes,
    required this.humanDescription,
    required this.date,
    required this.upvotes,
    required this.downvotes,
    required this.isVerified,
    required this.environments,
    required this.url,
    required this.comments,
  });

  final String? id;
  final String? codes;
  final String? humanDescription;
  final String? date;
  final int? upvotes;
  final int? downvotes;
  final bool? isVerified;
  final List<SolutionEnvironment>? environments;
  final String? url;
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
