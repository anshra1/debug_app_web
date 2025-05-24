// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolutionImpl _$$SolutionImplFromJson(Map<String, dynamic> json) =>
    _$SolutionImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      upvotes: (json['upvotes'] as num).toInt(),
      downvotes: (json['downvotes'] as num).toInt(),
      solutionDescription: json['solutionDescription'] as String,
      url: (json['url'] as List<dynamic>).map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SolutionImplToJson(_$SolutionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'solutionDescription': instance.solutionDescription,
      'url': instance.url,
      'comments': instance.comments,
    };
