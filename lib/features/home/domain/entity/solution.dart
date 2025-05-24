import 'package:debug_app_web/core/constants/keys.dart';
import 'package:debug_app_web/features/home/domain/entity/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'solution.freezed.dart';
part 'solution.g.dart';

@freezed

class Solution with _$Solution {
  const factory Solution({
    @JsonKey(name: SolutionKeys.id) required String id,
    @JsonKey(name: SolutionKeys.date) required String date,
    @JsonKey(name: SolutionKeys.upvotes) required int upvotes,
    @JsonKey(name: SolutionKeys.downvotes) required int downvotes,
    @JsonKey(name: SolutionKeys.solutionDescription) required String solutionDescription,
    @JsonKey(name: SolutionKeys.url) required List<String> url,
    @JsonKey(name: SolutionKeys.comments) required List<Comment> comments,
  }) = _Solution;

  factory Solution.fromJson(Map<String, dynamic> json) => _$SolutionFromJson(json);
}
