// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shadow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppShadow _$AppShadowFromJson(Map<String, dynamic> json) {
  return _AppShadow.fromJson(json);
}

/// @nodoc
mixin _$AppShadow {
  List<AppBoxShadow> get small => throw _privateConstructorUsedError;
  List<AppBoxShadow> get medium => throw _privateConstructorUsedError;

  /// Serializes this AppShadow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppShadow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppShadowCopyWith<AppShadow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppShadowCopyWith<$Res> {
  factory $AppShadowCopyWith(AppShadow value, $Res Function(AppShadow) then) =
      _$AppShadowCopyWithImpl<$Res, AppShadow>;
  @useResult
  $Res call({List<AppBoxShadow> small, List<AppBoxShadow> medium});
}

/// @nodoc
class _$AppShadowCopyWithImpl<$Res, $Val extends AppShadow>
    implements $AppShadowCopyWith<$Res> {
  _$AppShadowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppShadow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = null,
    Object? medium = null,
  }) {
    return _then(_value.copyWith(
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as List<AppBoxShadow>,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as List<AppBoxShadow>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppShadowImplCopyWith<$Res>
    implements $AppShadowCopyWith<$Res> {
  factory _$$AppShadowImplCopyWith(
          _$AppShadowImpl value, $Res Function(_$AppShadowImpl) then) =
      __$$AppShadowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AppBoxShadow> small, List<AppBoxShadow> medium});
}

/// @nodoc
class __$$AppShadowImplCopyWithImpl<$Res>
    extends _$AppShadowCopyWithImpl<$Res, _$AppShadowImpl>
    implements _$$AppShadowImplCopyWith<$Res> {
  __$$AppShadowImplCopyWithImpl(
      _$AppShadowImpl _value, $Res Function(_$AppShadowImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppShadow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = null,
    Object? medium = null,
  }) {
    return _then(_$AppShadowImpl(
      small: null == small
          ? _value._small
          : small // ignore: cast_nullable_to_non_nullable
              as List<AppBoxShadow>,
      medium: null == medium
          ? _value._medium
          : medium // ignore: cast_nullable_to_non_nullable
              as List<AppBoxShadow>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppShadowImpl implements _AppShadow {
  const _$AppShadowImpl(
      {required final List<AppBoxShadow> small,
      required final List<AppBoxShadow> medium})
      : _small = small,
        _medium = medium;

  factory _$AppShadowImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppShadowImplFromJson(json);

  final List<AppBoxShadow> _small;
  @override
  List<AppBoxShadow> get small {
    if (_small is EqualUnmodifiableListView) return _small;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_small);
  }

  final List<AppBoxShadow> _medium;
  @override
  List<AppBoxShadow> get medium {
    if (_medium is EqualUnmodifiableListView) return _medium;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medium);
  }

  @override
  String toString() {
    return 'AppShadow(small: $small, medium: $medium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppShadowImpl &&
            const DeepCollectionEquality().equals(other._small, _small) &&
            const DeepCollectionEquality().equals(other._medium, _medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_small),
      const DeepCollectionEquality().hash(_medium));

  /// Create a copy of AppShadow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppShadowImplCopyWith<_$AppShadowImpl> get copyWith =>
      __$$AppShadowImplCopyWithImpl<_$AppShadowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppShadowImplToJson(
      this,
    );
  }
}

abstract class _AppShadow implements AppShadow {
  const factory _AppShadow(
      {required final List<AppBoxShadow> small,
      required final List<AppBoxShadow> medium}) = _$AppShadowImpl;

  factory _AppShadow.fromJson(Map<String, dynamic> json) =
      _$AppShadowImpl.fromJson;

  @override
  List<AppBoxShadow> get small;
  @override
  List<AppBoxShadow> get medium;

  /// Create a copy of AppShadow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppShadowImplCopyWith<_$AppShadowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppBoxShadow _$AppBoxShadowFromJson(Map<String, dynamic> json) {
  return _AppBoxShadow.fromJson(json);
}

/// @nodoc
mixin _$AppBoxShadow {
  double get offsetX => throw _privateConstructorUsedError;
  double get offsetY => throw _privateConstructorUsedError;
  double get blurRadius => throw _privateConstructorUsedError;
  double get spreadRadius => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  /// Serializes this AppBoxShadow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppBoxShadow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppBoxShadowCopyWith<AppBoxShadow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBoxShadowCopyWith<$Res> {
  factory $AppBoxShadowCopyWith(
          AppBoxShadow value, $Res Function(AppBoxShadow) then) =
      _$AppBoxShadowCopyWithImpl<$Res, AppBoxShadow>;
  @useResult
  $Res call(
      {double offsetX,
      double offsetY,
      double blurRadius,
      double spreadRadius,
      String color});
}

/// @nodoc
class _$AppBoxShadowCopyWithImpl<$Res, $Val extends AppBoxShadow>
    implements $AppBoxShadowCopyWith<$Res> {
  _$AppBoxShadowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppBoxShadow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offsetX = null,
    Object? offsetY = null,
    Object? blurRadius = null,
    Object? spreadRadius = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      offsetX: null == offsetX
          ? _value.offsetX
          : offsetX // ignore: cast_nullable_to_non_nullable
              as double,
      offsetY: null == offsetY
          ? _value.offsetY
          : offsetY // ignore: cast_nullable_to_non_nullable
              as double,
      blurRadius: null == blurRadius
          ? _value.blurRadius
          : blurRadius // ignore: cast_nullable_to_non_nullable
              as double,
      spreadRadius: null == spreadRadius
          ? _value.spreadRadius
          : spreadRadius // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppBoxShadowImplCopyWith<$Res>
    implements $AppBoxShadowCopyWith<$Res> {
  factory _$$AppBoxShadowImplCopyWith(
          _$AppBoxShadowImpl value, $Res Function(_$AppBoxShadowImpl) then) =
      __$$AppBoxShadowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double offsetX,
      double offsetY,
      double blurRadius,
      double spreadRadius,
      String color});
}

/// @nodoc
class __$$AppBoxShadowImplCopyWithImpl<$Res>
    extends _$AppBoxShadowCopyWithImpl<$Res, _$AppBoxShadowImpl>
    implements _$$AppBoxShadowImplCopyWith<$Res> {
  __$$AppBoxShadowImplCopyWithImpl(
      _$AppBoxShadowImpl _value, $Res Function(_$AppBoxShadowImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppBoxShadow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offsetX = null,
    Object? offsetY = null,
    Object? blurRadius = null,
    Object? spreadRadius = null,
    Object? color = null,
  }) {
    return _then(_$AppBoxShadowImpl(
      offsetX: null == offsetX
          ? _value.offsetX
          : offsetX // ignore: cast_nullable_to_non_nullable
              as double,
      offsetY: null == offsetY
          ? _value.offsetY
          : offsetY // ignore: cast_nullable_to_non_nullable
              as double,
      blurRadius: null == blurRadius
          ? _value.blurRadius
          : blurRadius // ignore: cast_nullable_to_non_nullable
              as double,
      spreadRadius: null == spreadRadius
          ? _value.spreadRadius
          : spreadRadius // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBoxShadowImpl implements _AppBoxShadow {
  const _$AppBoxShadowImpl(
      {required this.offsetX,
      required this.offsetY,
      required this.blurRadius,
      required this.spreadRadius,
      required this.color});

  factory _$AppBoxShadowImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBoxShadowImplFromJson(json);

  @override
  final double offsetX;
  @override
  final double offsetY;
  @override
  final double blurRadius;
  @override
  final double spreadRadius;
  @override
  final String color;

  @override
  String toString() {
    return 'AppBoxShadow(offsetX: $offsetX, offsetY: $offsetY, blurRadius: $blurRadius, spreadRadius: $spreadRadius, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBoxShadowImpl &&
            (identical(other.offsetX, offsetX) || other.offsetX == offsetX) &&
            (identical(other.offsetY, offsetY) || other.offsetY == offsetY) &&
            (identical(other.blurRadius, blurRadius) ||
                other.blurRadius == blurRadius) &&
            (identical(other.spreadRadius, spreadRadius) ||
                other.spreadRadius == spreadRadius) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, offsetX, offsetY, blurRadius, spreadRadius, color);

  /// Create a copy of AppBoxShadow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBoxShadowImplCopyWith<_$AppBoxShadowImpl> get copyWith =>
      __$$AppBoxShadowImplCopyWithImpl<_$AppBoxShadowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBoxShadowImplToJson(
      this,
    );
  }
}

abstract class _AppBoxShadow implements AppBoxShadow {
  const factory _AppBoxShadow(
      {required final double offsetX,
      required final double offsetY,
      required final double blurRadius,
      required final double spreadRadius,
      required final String color}) = _$AppBoxShadowImpl;

  factory _AppBoxShadow.fromJson(Map<String, dynamic> json) =
      _$AppBoxShadowImpl.fromJson;

  @override
  double get offsetX;
  @override
  double get offsetY;
  @override
  double get blurRadius;
  @override
  double get spreadRadius;
  @override
  String get color;

  /// Create a copy of AppBoxShadow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppBoxShadowImplCopyWith<_$AppBoxShadowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
