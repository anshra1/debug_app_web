import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.dateAdded,
    this.additionalInfo = const {},
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json[EntityKeys.commentId] as String? ?? '',
        author: json[EntityKeys.commentAuthor] as String? ?? '',
        text: json[EntityKeys.commentText] as String? ?? '',
        dateAdded: DateTime.tryParse(
              json[EntityKeys.commentDateAdded] as String? ?? '',
            ) ??
            DateTime.now(),
        additionalInfo:
            json[EntityKeys.commentAdditionalInfo] as Map<String, dynamic>? ?? {},
      );

  final String id;
  final String author;
  final String text;

  Comment copyWith({
    String? id,
    String? author,
    String? text,
    DateTime? dateAdded,
    Map<String, dynamic>? additionalInfo,
  }) {
    return Comment(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      dateAdded: dateAdded ?? this.dateAdded,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  final DateTime dateAdded;
  final Map<String, dynamic> additionalInfo;

  Map<String, dynamic> toJson() => {
        EntityKeys.commentId: id,
        EntityKeys.commentAuthor: author,
        EntityKeys.commentText: text,
        EntityKeys.commentDateAdded: dateAdded.toIso8601String(),
        EntityKeys.commentAdditionalInfo: additionalInfo,
      };

  @override
  List<Object?> get props => [id, author, text, dateAdded, additionalInfo];
}
