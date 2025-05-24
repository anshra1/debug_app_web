import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.author,
    required this.text,
    required this.dateAdded,
    this.additionalInfo = const {},
  });

  final String id;
  final String author;
  final String text;
  final DateTime dateAdded;
  final Map<String, dynamic> additionalInfo;

  @override
  List<Object?> get props => [id, author, text, dateAdded, additionalInfo];
}
