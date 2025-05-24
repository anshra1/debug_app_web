import 'package:debug_app_web/core/constants/keys.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed

class Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: CommentKeys.id) required String id,
    @JsonKey(name: CommentKeys.author) required String author,
    @JsonKey(name: CommentKeys.text) required String text,
    @JsonKey(name: CommentKeys.dateAdded) required DateTime dateAdded,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
