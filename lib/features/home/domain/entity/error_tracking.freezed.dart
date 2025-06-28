// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ErrorTracking _$ErrorTrackingFromJson(Map<String, dynamic> json) {
  return _ErrorTracking.fromJson(json);
}

/// @nodoc
mixin _$ErrorTracking {
  @JsonKey(name: ErrorTrackingKeys.id)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.currentError)
  CurrentError get currentError => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.solutions)
  List<Solution> get solutions => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.errorCategory)
  ErrorCategory get errorCategory => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
  ErrorColorCategory get errorColorCategory =>
      throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.errorTags)
  List<String> get errorTags => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
  String get fingerPrintHashing => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorTrackingKeys.dates)
  List<DateTime> get dates => throw _privateConstructorUsedError;

  /// Serializes this ErrorTracking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorTrackingCopyWith<ErrorTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorTrackingCopyWith<$Res> {
  factory $ErrorTrackingCopyWith(
          ErrorTracking value, $Res Function(ErrorTracking) then) =
      _$ErrorTrackingCopyWithImpl<$Res, ErrorTracking>;
  @useResult
  $Res call(
      {@JsonKey(name: ErrorTrackingKeys.id) String id,
      @JsonKey(name: ErrorTrackingKeys.currentError) CurrentError currentError,
      @JsonKey(name: ErrorTrackingKeys.solutions) List<Solution> solutions,
      @JsonKey(name: ErrorTrackingKeys.errorCategory)
      ErrorCategory errorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
      ErrorColorCategory errorColorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorTags) List<String> errorTags,
      @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
      String fingerPrintHashing,
      @JsonKey(name: ErrorTrackingKeys.dates) List<DateTime> dates});

  $CurrentErrorCopyWith<$Res> get currentError;
}

/// @nodoc
class _$ErrorTrackingCopyWithImpl<$Res, $Val extends ErrorTracking>
    implements $ErrorTrackingCopyWith<$Res> {
  _$ErrorTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentError = null,
    Object? solutions = null,
    Object? errorCategory = null,
    Object? errorColorCategory = null,
    Object? errorTags = null,
    Object? fingerPrintHashing = null,
    Object? dates = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentError: null == currentError
          ? _value.currentError
          : currentError // ignore: cast_nullable_to_non_nullable
              as CurrentError,
      solutions: null == solutions
          ? _value.solutions
          : solutions // ignore: cast_nullable_to_non_nullable
              as List<Solution>,
      errorCategory: null == errorCategory
          ? _value.errorCategory
          : errorCategory // ignore: cast_nullable_to_non_nullable
              as ErrorCategory,
      errorColorCategory: null == errorColorCategory
          ? _value.errorColorCategory
          : errorColorCategory // ignore: cast_nullable_to_non_nullable
              as ErrorColorCategory,
      errorTags: null == errorTags
          ? _value.errorTags
          : errorTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fingerPrintHashing: null == fingerPrintHashing
          ? _value.fingerPrintHashing
          : fingerPrintHashing // ignore: cast_nullable_to_non_nullable
              as String,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrentErrorCopyWith<$Res> get currentError {
    return $CurrentErrorCopyWith<$Res>(_value.currentError, (value) {
      return _then(_value.copyWith(currentError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ErrorTrackingImplCopyWith<$Res>
    implements $ErrorTrackingCopyWith<$Res> {
  factory _$$ErrorTrackingImplCopyWith(
          _$ErrorTrackingImpl value, $Res Function(_$ErrorTrackingImpl) then) =
      __$$ErrorTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: ErrorTrackingKeys.id) String id,
      @JsonKey(name: ErrorTrackingKeys.currentError) CurrentError currentError,
      @JsonKey(name: ErrorTrackingKeys.solutions) List<Solution> solutions,
      @JsonKey(name: ErrorTrackingKeys.errorCategory)
      ErrorCategory errorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
      ErrorColorCategory errorColorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorTags) List<String> errorTags,
      @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
      String fingerPrintHashing,
      @JsonKey(name: ErrorTrackingKeys.dates) List<DateTime> dates});

  @override
  $CurrentErrorCopyWith<$Res> get currentError;
}

/// @nodoc
class __$$ErrorTrackingImplCopyWithImpl<$Res>
    extends _$ErrorTrackingCopyWithImpl<$Res, _$ErrorTrackingImpl>
    implements _$$ErrorTrackingImplCopyWith<$Res> {
  __$$ErrorTrackingImplCopyWithImpl(
      _$ErrorTrackingImpl _value, $Res Function(_$ErrorTrackingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentError = null,
    Object? solutions = null,
    Object? errorCategory = null,
    Object? errorColorCategory = null,
    Object? errorTags = null,
    Object? fingerPrintHashing = null,
    Object? dates = null,
  }) {
    return _then(_$ErrorTrackingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      currentError: null == currentError
          ? _value.currentError
          : currentError // ignore: cast_nullable_to_non_nullable
              as CurrentError,
      solutions: null == solutions
          ? _value.solutions
          : solutions // ignore: cast_nullable_to_non_nullable
              as List<Solution>,
      errorCategory: null == errorCategory
          ? _value.errorCategory
          : errorCategory // ignore: cast_nullable_to_non_nullable
              as ErrorCategory,
      errorColorCategory: null == errorColorCategory
          ? _value.errorColorCategory
          : errorColorCategory // ignore: cast_nullable_to_non_nullable
              as ErrorColorCategory,
      errorTags: null == errorTags
          ? _value.errorTags
          : errorTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fingerPrintHashing: null == fingerPrintHashing
          ? _value.fingerPrintHashing
          : fingerPrintHashing // ignore: cast_nullable_to_non_nullable
              as String,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorTrackingImpl implements _ErrorTracking {
  const _$ErrorTrackingImpl(
      {@JsonKey(name: ErrorTrackingKeys.id) required this.id,
      @JsonKey(name: ErrorTrackingKeys.currentError) required this.currentError,
      @JsonKey(name: ErrorTrackingKeys.solutions) required this.solutions,
      @JsonKey(name: ErrorTrackingKeys.errorCategory)
      required this.errorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
      required this.errorColorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorTags) required this.errorTags,
      @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
      required this.fingerPrintHashing,
      @JsonKey(name: ErrorTrackingKeys.dates) required this.dates});

  factory _$ErrorTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorTrackingImplFromJson(json);

  @override
  @JsonKey(name: ErrorTrackingKeys.id)
  final String id;
  @override
  @JsonKey(name: ErrorTrackingKeys.currentError)
  final CurrentError currentError;
  @override
  @JsonKey(name: ErrorTrackingKeys.solutions)
  final List<Solution> solutions;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorCategory)
  final ErrorCategory errorCategory;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
  final ErrorColorCategory errorColorCategory;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorTags)
  final List<String> errorTags;
  @override
  @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
  final String fingerPrintHashing;
  @override
  @JsonKey(name: ErrorTrackingKeys.dates)
  final List<DateTime> dates;

  @override
  String toString() {
    return 'ErrorTracking(id: $id, currentError: $currentError, solutions: $solutions, errorCategory: $errorCategory, errorColorCategory: $errorColorCategory, errorTags: $errorTags, fingerPrintHashing: $fingerPrintHashing, dates: $dates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorTrackingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentError, currentError) ||
                other.currentError == currentError) &&
            const DeepCollectionEquality().equals(other.solutions, solutions) &&
            (identical(other.errorCategory, errorCategory) ||
                other.errorCategory == errorCategory) &&
            (identical(other.errorColorCategory, errorColorCategory) ||
                other.errorColorCategory == errorColorCategory) &&
            const DeepCollectionEquality().equals(other.errorTags, errorTags) &&
            (identical(other.fingerPrintHashing, fingerPrintHashing) ||
                other.fingerPrintHashing == fingerPrintHashing) &&
            const DeepCollectionEquality().equals(other.dates, dates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      currentError,
      const DeepCollectionEquality().hash(solutions),
      errorCategory,
      errorColorCategory,
      const DeepCollectionEquality().hash(errorTags),
      fingerPrintHashing,
      const DeepCollectionEquality().hash(dates));

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorTrackingImplCopyWith<_$ErrorTrackingImpl> get copyWith =>
      __$$ErrorTrackingImplCopyWithImpl<_$ErrorTrackingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorTrackingImplToJson(
      this,
    );
  }
}

abstract class _ErrorTracking implements ErrorTracking {
  const factory _ErrorTracking(
      {@JsonKey(name: ErrorTrackingKeys.id) required final String id,
      @JsonKey(name: ErrorTrackingKeys.currentError)
      required final CurrentError currentError,
      @JsonKey(name: ErrorTrackingKeys.solutions)
      required final List<Solution> solutions,
      @JsonKey(name: ErrorTrackingKeys.errorCategory)
      required final ErrorCategory errorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
      required final ErrorColorCategory errorColorCategory,
      @JsonKey(name: ErrorTrackingKeys.errorTags)
      required final List<String> errorTags,
      @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
      required final String fingerPrintHashing,
      @JsonKey(name: ErrorTrackingKeys.dates)
      required final List<DateTime> dates}) = _$ErrorTrackingImpl;

  factory _ErrorTracking.fromJson(Map<String, dynamic> json) =
      _$ErrorTrackingImpl.fromJson;

  @override
  @JsonKey(name: ErrorTrackingKeys.id)
  String get id;
  @override
  @JsonKey(name: ErrorTrackingKeys.currentError)
  CurrentError get currentError;
  @override
  @JsonKey(name: ErrorTrackingKeys.solutions)
  List<Solution> get solutions;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorCategory)
  ErrorCategory get errorCategory;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorColorCategory)
  ErrorColorCategory get errorColorCategory;
  @override
  @JsonKey(name: ErrorTrackingKeys.errorTags)
  List<String> get errorTags;
  @override
  @JsonKey(name: ErrorTrackingKeys.fingerPrintHashing)
  String get fingerPrintHashing;
  @override
  @JsonKey(name: ErrorTrackingKeys.dates)
  List<DateTime> get dates;

  /// Create a copy of ErrorTracking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorTrackingImplCopyWith<_$ErrorTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
