// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_environment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ErrorEnvironment _$ErrorEnvironmentFromJson(Map<String, dynamic> json) {
  return _ErrorEnvironment.fromJson(json);
}

/// @nodoc
mixin _$ErrorEnvironment {
  @JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
  String get flutterVersion => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorEnvironmentKeys.dartVersion)
  String get dartVersion => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorEnvironmentKeys.platform)
  String get platform => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorEnvironmentKeys.osVersion)
  String? get osVersion => throw _privateConstructorUsedError;
  @JsonKey(name: ErrorEnvironmentKeys.deviceModel)
  String? get deviceModel => throw _privateConstructorUsedError;

  /// Serializes this ErrorEnvironment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorEnvironment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorEnvironmentCopyWith<ErrorEnvironment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorEnvironmentCopyWith<$Res> {
  factory $ErrorEnvironmentCopyWith(
          ErrorEnvironment value, $Res Function(ErrorEnvironment) then) =
      _$ErrorEnvironmentCopyWithImpl<$Res, ErrorEnvironment>;
  @useResult
  $Res call(
      {@JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
      String flutterVersion,
      @JsonKey(name: ErrorEnvironmentKeys.dartVersion) String dartVersion,
      @JsonKey(name: ErrorEnvironmentKeys.platform) String platform,
      @JsonKey(name: ErrorEnvironmentKeys.osVersion) String? osVersion,
      @JsonKey(name: ErrorEnvironmentKeys.deviceModel) String? deviceModel});
}

/// @nodoc
class _$ErrorEnvironmentCopyWithImpl<$Res, $Val extends ErrorEnvironment>
    implements $ErrorEnvironmentCopyWith<$Res> {
  _$ErrorEnvironmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorEnvironment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flutterVersion = null,
    Object? dartVersion = null,
    Object? platform = null,
    Object? osVersion = freezed,
    Object? deviceModel = freezed,
  }) {
    return _then(_value.copyWith(
      flutterVersion: null == flutterVersion
          ? _value.flutterVersion
          : flutterVersion // ignore: cast_nullable_to_non_nullable
              as String,
      dartVersion: null == dartVersion
          ? _value.dartVersion
          : dartVersion // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorEnvironmentImplCopyWith<$Res>
    implements $ErrorEnvironmentCopyWith<$Res> {
  factory _$$ErrorEnvironmentImplCopyWith(_$ErrorEnvironmentImpl value,
          $Res Function(_$ErrorEnvironmentImpl) then) =
      __$$ErrorEnvironmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
      String flutterVersion,
      @JsonKey(name: ErrorEnvironmentKeys.dartVersion) String dartVersion,
      @JsonKey(name: ErrorEnvironmentKeys.platform) String platform,
      @JsonKey(name: ErrorEnvironmentKeys.osVersion) String? osVersion,
      @JsonKey(name: ErrorEnvironmentKeys.deviceModel) String? deviceModel});
}

/// @nodoc
class __$$ErrorEnvironmentImplCopyWithImpl<$Res>
    extends _$ErrorEnvironmentCopyWithImpl<$Res, _$ErrorEnvironmentImpl>
    implements _$$ErrorEnvironmentImplCopyWith<$Res> {
  __$$ErrorEnvironmentImplCopyWithImpl(_$ErrorEnvironmentImpl _value,
      $Res Function(_$ErrorEnvironmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorEnvironment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flutterVersion = null,
    Object? dartVersion = null,
    Object? platform = null,
    Object? osVersion = freezed,
    Object? deviceModel = freezed,
  }) {
    return _then(_$ErrorEnvironmentImpl(
      flutterVersion: null == flutterVersion
          ? _value.flutterVersion
          : flutterVersion // ignore: cast_nullable_to_non_nullable
              as String,
      dartVersion: null == dartVersion
          ? _value.dartVersion
          : dartVersion // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorEnvironmentImpl implements _ErrorEnvironment {
  const _$ErrorEnvironmentImpl(
      {@JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
      required this.flutterVersion,
      @JsonKey(name: ErrorEnvironmentKeys.dartVersion)
      required this.dartVersion,
      @JsonKey(name: ErrorEnvironmentKeys.platform) required this.platform,
      @JsonKey(name: ErrorEnvironmentKeys.osVersion) this.osVersion,
      @JsonKey(name: ErrorEnvironmentKeys.deviceModel) this.deviceModel});

  factory _$ErrorEnvironmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorEnvironmentImplFromJson(json);

  @override
  @JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
  final String flutterVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.dartVersion)
  final String dartVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.platform)
  final String platform;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.osVersion)
  final String? osVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.deviceModel)
  final String? deviceModel;

  @override
  String toString() {
    return 'ErrorEnvironment(flutterVersion: $flutterVersion, dartVersion: $dartVersion, platform: $platform, osVersion: $osVersion, deviceModel: $deviceModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorEnvironmentImpl &&
            (identical(other.flutterVersion, flutterVersion) ||
                other.flutterVersion == flutterVersion) &&
            (identical(other.dartVersion, dartVersion) ||
                other.dartVersion == dartVersion) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, flutterVersion, dartVersion,
      platform, osVersion, deviceModel);

  /// Create a copy of ErrorEnvironment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorEnvironmentImplCopyWith<_$ErrorEnvironmentImpl> get copyWith =>
      __$$ErrorEnvironmentImplCopyWithImpl<_$ErrorEnvironmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorEnvironmentImplToJson(
      this,
    );
  }
}

abstract class _ErrorEnvironment implements ErrorEnvironment {
  const factory _ErrorEnvironment(
      {@JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
      required final String flutterVersion,
      @JsonKey(name: ErrorEnvironmentKeys.dartVersion)
      required final String dartVersion,
      @JsonKey(name: ErrorEnvironmentKeys.platform)
      required final String platform,
      @JsonKey(name: ErrorEnvironmentKeys.osVersion) final String? osVersion,
      @JsonKey(name: ErrorEnvironmentKeys.deviceModel)
      final String? deviceModel}) = _$ErrorEnvironmentImpl;

  factory _ErrorEnvironment.fromJson(Map<String, dynamic> json) =
      _$ErrorEnvironmentImpl.fromJson;

  @override
  @JsonKey(name: ErrorEnvironmentKeys.flutterVersion)
  String get flutterVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.dartVersion)
  String get dartVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.platform)
  String get platform;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.osVersion)
  String? get osVersion;
  @override
  @JsonKey(name: ErrorEnvironmentKeys.deviceModel)
  String? get deviceModel;

  /// Create a copy of ErrorEnvironment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorEnvironmentImplCopyWith<_$ErrorEnvironmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
