// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CurrentError _$CurrentErrorFromJson(Map<String, dynamic> json) {
  return _CurrentError.fromJson(json);
}

/// @nodoc
mixin _$CurrentError {
  @JsonKey(name: CurrentErrorKeys.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.error)
  String get error => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.platform)
  String get platform => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.additionalInfo)
  Map<String, String>? get additionalInfo => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  String? get stackTrace => throw _privateConstructorUsedError;

  /// Serializes this CurrentError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentErrorCopyWith<CurrentError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentErrorCopyWith<$Res> {
  factory $CurrentErrorCopyWith(
          CurrentError value, $Res Function(CurrentError) then) =
      _$CurrentErrorCopyWithImpl<$Res, CurrentError>;
  @useResult
  $Res call(
      {@JsonKey(name: CurrentErrorKeys.id) String id,
      @JsonKey(name: CurrentErrorKeys.error) String error,
      @JsonKey(name: CurrentErrorKeys.platform) String platform,
      @JsonKey(name: CurrentErrorKeys.additionalInfo)
      Map<String, String>? additionalInfo,
      @JsonKey(name: CurrentErrorKeys.stackTrace) String? stackTrace});
}

/// @nodoc
class _$CurrentErrorCopyWithImpl<$Res, $Val extends CurrentError>
    implements $CurrentErrorCopyWith<$Res> {
  _$CurrentErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? error = null,
    Object? platform = null,
    Object? additionalInfo = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      additionalInfo: freezed == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentErrorImplCopyWith<$Res>
    implements $CurrentErrorCopyWith<$Res> {
  factory _$$CurrentErrorImplCopyWith(
          _$CurrentErrorImpl value, $Res Function(_$CurrentErrorImpl) then) =
      __$$CurrentErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: CurrentErrorKeys.id) String id,
      @JsonKey(name: CurrentErrorKeys.error) String error,
      @JsonKey(name: CurrentErrorKeys.platform) String platform,
      @JsonKey(name: CurrentErrorKeys.additionalInfo)
      Map<String, String>? additionalInfo,
      @JsonKey(name: CurrentErrorKeys.stackTrace) String? stackTrace});
}

/// @nodoc
class __$$CurrentErrorImplCopyWithImpl<$Res>
    extends _$CurrentErrorCopyWithImpl<$Res, _$CurrentErrorImpl>
    implements _$$CurrentErrorImplCopyWith<$Res> {
  __$$CurrentErrorImplCopyWithImpl(
      _$CurrentErrorImpl _value, $Res Function(_$CurrentErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? error = null,
    Object? platform = null,
    Object? additionalInfo = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$CurrentErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      additionalInfo: freezed == additionalInfo
          ? _value._additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentErrorImpl implements _CurrentError {
  const _$CurrentErrorImpl(
      {@JsonKey(name: CurrentErrorKeys.id) required this.id,
      @JsonKey(name: CurrentErrorKeys.error) required this.error,
      @JsonKey(name: CurrentErrorKeys.platform) required this.platform,
      @JsonKey(name: CurrentErrorKeys.additionalInfo)
      required final Map<String, String>? additionalInfo,
      @JsonKey(name: CurrentErrorKeys.stackTrace) this.stackTrace})
      : _additionalInfo = additionalInfo;

  factory _$CurrentErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentErrorImplFromJson(json);

  @override
  @JsonKey(name: CurrentErrorKeys.id)
  final String id;
  @override
  @JsonKey(name: CurrentErrorKeys.error)
  final String error;
  @override
  @JsonKey(name: CurrentErrorKeys.platform)
  final String platform;
  final Map<String, String>? _additionalInfo;
  @override
  @JsonKey(name: CurrentErrorKeys.additionalInfo)
  Map<String, String>? get additionalInfo {
    final value = _additionalInfo;
    if (value == null) return null;
    if (_additionalInfo is EqualUnmodifiableMapView) return _additionalInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  final String? stackTrace;

  @override
  String toString() {
    return 'CurrentError(id: $id, error: $error, platform: $platform, additionalInfo: $additionalInfo, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            const DeepCollectionEquality()
                .equals(other._additionalInfo, _additionalInfo) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error, platform,
      const DeepCollectionEquality().hash(_additionalInfo), stackTrace);

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentErrorImplCopyWith<_$CurrentErrorImpl> get copyWith =>
      __$$CurrentErrorImplCopyWithImpl<_$CurrentErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentErrorImplToJson(
      this,
    );
  }
}

abstract class _CurrentError implements CurrentError {
  const factory _CurrentError(
      {@JsonKey(name: CurrentErrorKeys.id) required final String id,
      @JsonKey(name: CurrentErrorKeys.error) required final String error,
      @JsonKey(name: CurrentErrorKeys.platform) required final String platform,
      @JsonKey(name: CurrentErrorKeys.additionalInfo)
      required final Map<String, String>? additionalInfo,
      @JsonKey(name: CurrentErrorKeys.stackTrace)
      final String? stackTrace}) = _$CurrentErrorImpl;

  factory _CurrentError.fromJson(Map<String, dynamic> json) =
      _$CurrentErrorImpl.fromJson;

  @override
  @JsonKey(name: CurrentErrorKeys.id)
  String get id;
  @override
  @JsonKey(name: CurrentErrorKeys.error)
  String get error;
  @override
  @JsonKey(name: CurrentErrorKeys.platform)
  String get platform;
  @override
  @JsonKey(name: CurrentErrorKeys.additionalInfo)
  Map<String, String>? get additionalInfo;
  @override
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  String? get stackTrace;

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentErrorImplCopyWith<_$CurrentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
