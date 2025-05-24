import '../../domain/entities/comment.dart';
import '../../domain/entities/entity_keys.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.author,
    required super.text,
    required super.dateAdded,
    super.additionalInfo,
  });

  factory CommentModel.fromEntity(Comment entity) {
    return CommentModel(
      id: entity.id,
      author: entity.author,
      text: entity.text,
      dateAdded: entity.dateAdded,
      additionalInfo: entity.additionalInfo,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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

  Map<String, dynamic> toJson() => {
        EntityKeys.commentId: id,
        EntityKeys.commentAuthor: author,
        EntityKeys.commentText: text,
        EntityKeys.commentDateAdded: dateAdded.toIso8601String(),
        EntityKeys.commentAdditionalInfo: additionalInfo,
      };

  CommentModel copy() {
    return CommentModel(
      id: id,
      author: author,
      text: text,
      dateAdded: dateAdded,
      additionalInfo: additionalInfo,
    );
  }

  CommentModel copyWith({
    String? id,
    String? author,
    String? text,
    DateTime? dateAdded,
    Map<String, dynamic>? additionalInfo,
  }) {
    return CommentModel(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      dateAdded: dateAdded ?? this.dateAdded,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }

  Comment toEntity() {
    return Comment(
      id: id,
      author: author,
      text: text,
      dateAdded: dateAdded,
      additionalInfo: additionalInfo,
    );
  }

  @override
  List<Object?> get props => [id, author, text, dateAdded, additionalInfo];
}
