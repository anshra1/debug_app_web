// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      author: json['author'] as String,
      text: json['text'] as String,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'text': instance.text,
      'dateAdded': instance.dateAdded.toIso8601String(),
    };
