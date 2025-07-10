// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surface_container_color_scheme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSurfaceContainerColorScheme _$AppSurfaceContainerColorSchemeFromJson(
    Map<String, dynamic> json) {
  return _AppSurfaceContainerColorScheme.fromJson(json);
}

/// @nodoc
mixin _$AppSurfaceContainerColorScheme {
  @ColorConverter()
  Color get layer01 => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get layer02 => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get layer03 => throw _privateConstructorUsedError;

  /// Serializes this AppSurfaceContainerColorScheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSurfaceContainerColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSurfaceContainerColorSchemeCopyWith<AppSurfaceContainerColorScheme>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSurfaceContainerColorSchemeCopyWith<$Res> {
  factory $AppSurfaceContainerColorSchemeCopyWith(
          AppSurfaceContainerColorScheme value,
          $Res Function(AppSurfaceContainerColorScheme) then) =
      _$AppSurfaceContainerColorSchemeCopyWithImpl<$Res,
          AppSurfaceContainerColorScheme>;
  @useResult
  $Res call(
      {@ColorConverter() Color layer01,
      @ColorConverter() Color layer02,
      @ColorConverter() Color layer03});
}

/// @nodoc
class _$AppSurfaceContainerColorSchemeCopyWithImpl<$Res,
        $Val extends AppSurfaceContainerColorScheme>
    implements $AppSurfaceContainerColorSchemeCopyWith<$Res> {
  _$AppSurfaceContainerColorSchemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSurfaceContainerColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer01 = null,
    Object? layer02 = null,
    Object? layer03 = null,
  }) {
    return _then(_value.copyWith(
      layer01: null == layer01
          ? _value.layer01
          : layer01 // ignore: cast_nullable_to_non_nullable
              as Color,
      layer02: null == layer02
          ? _value.layer02
          : layer02 // ignore: cast_nullable_to_non_nullable
              as Color,
      layer03: null == layer03
          ? _value.layer03
          : layer03 // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSurfaceContainerColorSchemeImplCopyWith<$Res>
    implements $AppSurfaceContainerColorSchemeCopyWith<$Res> {
  factory _$$AppSurfaceContainerColorSchemeImplCopyWith(
          _$AppSurfaceContainerColorSchemeImpl value,
          $Res Function(_$AppSurfaceContainerColorSchemeImpl) then) =
      __$$AppSurfaceContainerColorSchemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ColorConverter() Color layer01,
      @ColorConverter() Color layer02,
      @ColorConverter() Color layer03});
}

/// @nodoc
class __$$AppSurfaceContainerColorSchemeImplCopyWithImpl<$Res>
    extends _$AppSurfaceContainerColorSchemeCopyWithImpl<$Res,
        _$AppSurfaceContainerColorSchemeImpl>
    implements _$$AppSurfaceContainerColorSchemeImplCopyWith<$Res> {
  __$$AppSurfaceContainerColorSchemeImplCopyWithImpl(
      _$AppSurfaceContainerColorSchemeImpl _value,
      $Res Function(_$AppSurfaceContainerColorSchemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSurfaceContainerColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer01 = null,
    Object? layer02 = null,
    Object? layer03 = null,
  }) {
    return _then(_$AppSurfaceContainerColorSchemeImpl(
      layer01: null == layer01
          ? _value.layer01
          : layer01 // ignore: cast_nullable_to_non_nullable
              as Color,
      layer02: null == layer02
          ? _value.layer02
          : layer02 // ignore: cast_nullable_to_non_nullable
              as Color,
      layer03: null == layer03
          ? _value.layer03
          : layer03 // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSurfaceContainerColorSchemeImpl
    implements _AppSurfaceContainerColorScheme {
  const _$AppSurfaceContainerColorSchemeImpl(
      {@ColorConverter() required this.layer01,
      @ColorConverter() required this.layer02,
      @ColorConverter() required this.layer03});

  factory _$AppSurfaceContainerColorSchemeImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AppSurfaceContainerColorSchemeImplFromJson(json);

  @override
  @ColorConverter()
  final Color layer01;
  @override
  @ColorConverter()
  final Color layer02;
  @override
  @ColorConverter()
  final Color layer03;

  @override
  String toString() {
    return 'AppSurfaceContainerColorScheme(layer01: $layer01, layer02: $layer02, layer03: $layer03)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSurfaceContainerColorSchemeImpl &&
            (identical(other.layer01, layer01) || other.layer01 == layer01) &&
            (identical(other.layer02, layer02) || other.layer02 == layer02) &&
            (identical(other.layer03, layer03) || other.layer03 == layer03));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, layer01, layer02, layer03);

  /// Create a copy of AppSurfaceContainerColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSurfaceContainerColorSchemeImplCopyWith<
          _$AppSurfaceContainerColorSchemeImpl>
      get copyWith => __$$AppSurfaceContainerColorSchemeImplCopyWithImpl<
          _$AppSurfaceContainerColorSchemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSurfaceContainerColorSchemeImplToJson(
      this,
    );
  }
}

abstract class _AppSurfaceContainerColorScheme
    implements AppSurfaceContainerColorScheme {
  const factory _AppSurfaceContainerColorScheme(
          {@ColorConverter() required final Color layer01,
          @ColorConverter() required final Color layer02,
          @ColorConverter() required final Color layer03}) =
      _$AppSurfaceContainerColorSchemeImpl;

  factory _AppSurfaceContainerColorScheme.fromJson(Map<String, dynamic> json) =
      _$AppSurfaceContainerColorSchemeImpl.fromJson;

  @override
  @ColorConverter()
  Color get layer01;
  @override
  @ColorConverter()
  Color get layer02;
  @override
  @ColorConverter()
  Color get layer03;

  /// Create a copy of AppSurfaceContainerColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSurfaceContainerColorSchemeImplCopyWith<
          _$AppSurfaceContainerColorSchemeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
