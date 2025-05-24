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
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  String get stackTrace => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.error)
  String get error => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.environment)
  ErrorEnvironment get environment => throw _privateConstructorUsedError;
  @JsonKey(name: CurrentErrorKeys.date)
  DateTime get date => throw _privateConstructorUsedError;

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
      {@JsonKey(name: CurrentErrorKeys.stackTrace) String stackTrace,
      @JsonKey(name: CurrentErrorKeys.error) String error,
      @JsonKey(name: CurrentErrorKeys.environment) ErrorEnvironment environment,
      @JsonKey(name: CurrentErrorKeys.date) DateTime date});

  $ErrorEnvironmentCopyWith<$Res> get environment;
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
    Object? stackTrace = null,
    Object? error = null,
    Object? environment = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as ErrorEnvironment,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorEnvironmentCopyWith<$Res> get environment {
    return $ErrorEnvironmentCopyWith<$Res>(_value.environment, (value) {
      return _then(_value.copyWith(environment: value) as $Val);
    });
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
      {@JsonKey(name: CurrentErrorKeys.stackTrace) String stackTrace,
      @JsonKey(name: CurrentErrorKeys.error) String error,
      @JsonKey(name: CurrentErrorKeys.environment) ErrorEnvironment environment,
      @JsonKey(name: CurrentErrorKeys.date) DateTime date});

  @override
  $ErrorEnvironmentCopyWith<$Res> get environment;
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
    Object? stackTrace = null,
    Object? error = null,
    Object? environment = null,
    Object? date = null,
  }) {
    return _then(_$CurrentErrorImpl(
      stackTrace: null == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as ErrorEnvironment,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentErrorImpl implements _CurrentError {
  const _$CurrentErrorImpl(
      {@JsonKey(name: CurrentErrorKeys.stackTrace) required this.stackTrace,
      @JsonKey(name: CurrentErrorKeys.error) required this.error,
      @JsonKey(name: CurrentErrorKeys.environment) required this.environment,
      @JsonKey(name: CurrentErrorKeys.date) required this.date});

  factory _$CurrentErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentErrorImplFromJson(json);

  @override
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  final String stackTrace;
  @override
  @JsonKey(name: CurrentErrorKeys.error)
  final String error;
  @override
  @JsonKey(name: CurrentErrorKeys.environment)
  final ErrorEnvironment environment;
  @override
  @JsonKey(name: CurrentErrorKeys.date)
  final DateTime date;

  @override
  String toString() {
    return 'CurrentError(stackTrace: $stackTrace, error: $error, environment: $environment, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentErrorImpl &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.environment, environment) ||
                other.environment == environment) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stackTrace, error, environment, date);

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
          {@JsonKey(name: CurrentErrorKeys.stackTrace)
          required final String stackTrace,
          @JsonKey(name: CurrentErrorKeys.error) required final String error,
          @JsonKey(name: CurrentErrorKeys.environment)
          required final ErrorEnvironment environment,
          @JsonKey(name: CurrentErrorKeys.date) required final DateTime date}) =
      _$CurrentErrorImpl;

  factory _CurrentError.fromJson(Map<String, dynamic> json) =
      _$CurrentErrorImpl.fromJson;

  @override
  @JsonKey(name: CurrentErrorKeys.stackTrace)
  String get stackTrace;
  @override
  @JsonKey(name: CurrentErrorKeys.error)
  String get error;
  @override
  @JsonKey(name: CurrentErrorKeys.environment)
  ErrorEnvironment get environment;
  @override
  @JsonKey(name: CurrentErrorKeys.date)
  DateTime get date;

  /// Create a copy of CurrentError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentErrorImplCopyWith<_$CurrentErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
