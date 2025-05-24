// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Solution _$SolutionFromJson(Map<String, dynamic> json) {
  return _Solution.fromJson(json);
}

/// @nodoc
mixin _$Solution {
  @JsonKey(name: SolutionKeys.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.date)
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.upvotes)
  int get upvotes => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.downvotes)
  int get downvotes => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.solutionDescription)
  String get solutionDescription => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.url)
  List<String> get url => throw _privateConstructorUsedError;
  @JsonKey(name: SolutionKeys.comments)
  List<Comment> get comments => throw _privateConstructorUsedError;

  /// Serializes this Solution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionCopyWith<Solution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionCopyWith<$Res> {
  factory $SolutionCopyWith(Solution value, $Res Function(Solution) then) =
      _$SolutionCopyWithImpl<$Res, Solution>;
  @useResult
  $Res call(
      {@JsonKey(name: SolutionKeys.id) String id,
      @JsonKey(name: SolutionKeys.date) String date,
      @JsonKey(name: SolutionKeys.upvotes) int upvotes,
      @JsonKey(name: SolutionKeys.downvotes) int downvotes,
      @JsonKey(name: SolutionKeys.solutionDescription)
      String solutionDescription,
      @JsonKey(name: SolutionKeys.url) List<String> url,
      @JsonKey(name: SolutionKeys.comments) List<Comment> comments});
}

/// @nodoc
class _$SolutionCopyWithImpl<$Res, $Val extends Solution>
    implements $SolutionCopyWith<$Res> {
  _$SolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? upvotes = null,
    Object? downvotes = null,
    Object? solutionDescription = null,
    Object? url = null,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      upvotes: null == upvotes
          ? _value.upvotes
          : upvotes // ignore: cast_nullable_to_non_nullable
              as int,
      downvotes: null == downvotes
          ? _value.downvotes
          : downvotes // ignore: cast_nullable_to_non_nullable
              as int,
      solutionDescription: null == solutionDescription
          ? _value.solutionDescription
          : solutionDescription // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolutionImplCopyWith<$Res>
    implements $SolutionCopyWith<$Res> {
  factory _$$SolutionImplCopyWith(
          _$SolutionImpl value, $Res Function(_$SolutionImpl) then) =
      __$$SolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: SolutionKeys.id) String id,
      @JsonKey(name: SolutionKeys.date) String date,
      @JsonKey(name: SolutionKeys.upvotes) int upvotes,
      @JsonKey(name: SolutionKeys.downvotes) int downvotes,
      @JsonKey(name: SolutionKeys.solutionDescription)
      String solutionDescription,
      @JsonKey(name: SolutionKeys.url) List<String> url,
      @JsonKey(name: SolutionKeys.comments) List<Comment> comments});
}

/// @nodoc
class __$$SolutionImplCopyWithImpl<$Res>
    extends _$SolutionCopyWithImpl<$Res, _$SolutionImpl>
    implements _$$SolutionImplCopyWith<$Res> {
  __$$SolutionImplCopyWithImpl(
      _$SolutionImpl _value, $Res Function(_$SolutionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? upvotes = null,
    Object? downvotes = null,
    Object? solutionDescription = null,
    Object? url = null,
    Object? comments = null,
  }) {
    return _then(_$SolutionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      upvotes: null == upvotes
          ? _value.upvotes
          : upvotes // ignore: cast_nullable_to_non_nullable
              as int,
      downvotes: null == downvotes
          ? _value.downvotes
          : downvotes // ignore: cast_nullable_to_non_nullable
              as int,
      solutionDescription: null == solutionDescription
          ? _value.solutionDescription
          : solutionDescription // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value._url
          : url // ignore: cast_nullable_to_non_nullable
              as List<String>,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionImpl implements _Solution {
  const _$SolutionImpl(
      {@JsonKey(name: SolutionKeys.id) required this.id,
      @JsonKey(name: SolutionKeys.date) required this.date,
      @JsonKey(name: SolutionKeys.upvotes) required this.upvotes,
      @JsonKey(name: SolutionKeys.downvotes) required this.downvotes,
      @JsonKey(name: SolutionKeys.solutionDescription)
      required this.solutionDescription,
      @JsonKey(name: SolutionKeys.url) required final List<String> url,
      @JsonKey(name: SolutionKeys.comments)
      required final List<Comment> comments})
      : _url = url,
        _comments = comments;

  factory _$SolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionImplFromJson(json);

  @override
  @JsonKey(name: SolutionKeys.id)
  final String id;
  @override
  @JsonKey(name: SolutionKeys.date)
  final String date;
  @override
  @JsonKey(name: SolutionKeys.upvotes)
  final int upvotes;
  @override
  @JsonKey(name: SolutionKeys.downvotes)
  final int downvotes;
  @override
  @JsonKey(name: SolutionKeys.solutionDescription)
  final String solutionDescription;
  final List<String> _url;
  @override
  @JsonKey(name: SolutionKeys.url)
  List<String> get url {
    if (_url is EqualUnmodifiableListView) return _url;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_url);
  }

  final List<Comment> _comments;
  @override
  @JsonKey(name: SolutionKeys.comments)
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'Solution(id: $id, date: $date, upvotes: $upvotes, downvotes: $downvotes, solutionDescription: $solutionDescription, url: $url, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.upvotes, upvotes) || other.upvotes == upvotes) &&
            (identical(other.downvotes, downvotes) ||
                other.downvotes == downvotes) &&
            (identical(other.solutionDescription, solutionDescription) ||
                other.solutionDescription == solutionDescription) &&
            const DeepCollectionEquality().equals(other._url, _url) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      date,
      upvotes,
      downvotes,
      solutionDescription,
      const DeepCollectionEquality().hash(_url),
      const DeepCollectionEquality().hash(_comments));

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionImplCopyWith<_$SolutionImpl> get copyWith =>
      __$$SolutionImplCopyWithImpl<_$SolutionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionImplToJson(
      this,
    );
  }
}

abstract class _Solution implements Solution {
  const factory _Solution(
      {@JsonKey(name: SolutionKeys.id) required final String id,
      @JsonKey(name: SolutionKeys.date) required final String date,
      @JsonKey(name: SolutionKeys.upvotes) required final int upvotes,
      @JsonKey(name: SolutionKeys.downvotes) required final int downvotes,
      @JsonKey(name: SolutionKeys.solutionDescription)
      required final String solutionDescription,
      @JsonKey(name: SolutionKeys.url) required final List<String> url,
      @JsonKey(name: SolutionKeys.comments)
      required final List<Comment> comments}) = _$SolutionImpl;

  factory _Solution.fromJson(Map<String, dynamic> json) =
      _$SolutionImpl.fromJson;

  @override
  @JsonKey(name: SolutionKeys.id)
  String get id;
  @override
  @JsonKey(name: SolutionKeys.date)
  String get date;
  @override
  @JsonKey(name: SolutionKeys.upvotes)
  int get upvotes;
  @override
  @JsonKey(name: SolutionKeys.downvotes)
  int get downvotes;
  @override
  @JsonKey(name: SolutionKeys.solutionDescription)
  String get solutionDescription;
  @override
  @JsonKey(name: SolutionKeys.url)
  List<String> get url;
  @override
  @JsonKey(name: SolutionKeys.comments)
  List<Comment> get comments;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionImplCopyWith<_$SolutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
