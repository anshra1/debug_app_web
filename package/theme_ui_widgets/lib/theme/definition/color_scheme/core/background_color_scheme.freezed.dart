// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background_color_scheme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppBackgroundColorScheme _$AppBackgroundColorSchemeFromJson(
    Map<String, dynamic> json) {
  return _AppBackgroundColorScheme.fromJson(json);
}

/// @nodoc
mixin _$AppBackgroundColorScheme {
  @ColorConverter()
  Color get primary => throw _privateConstructorUsedError;

  /// Serializes this AppBackgroundColorScheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppBackgroundColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppBackgroundColorSchemeCopyWith<AppBackgroundColorScheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBackgroundColorSchemeCopyWith<$Res> {
  factory $AppBackgroundColorSchemeCopyWith(AppBackgroundColorScheme value,
          $Res Function(AppBackgroundColorScheme) then) =
      _$AppBackgroundColorSchemeCopyWithImpl<$Res, AppBackgroundColorScheme>;
  @useResult
  $Res call({@ColorConverter() Color primary});
}

/// @nodoc
class _$AppBackgroundColorSchemeCopyWithImpl<$Res,
        $Val extends AppBackgroundColorScheme>
    implements $AppBackgroundColorSchemeCopyWith<$Res> {
  _$AppBackgroundColorSchemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppBackgroundColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
  }) {
    return _then(_value.copyWith(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppBackgroundColorSchemeImplCopyWith<$Res>
    implements $AppBackgroundColorSchemeCopyWith<$Res> {
  factory _$$AppBackgroundColorSchemeImplCopyWith(
          _$AppBackgroundColorSchemeImpl value,
          $Res Function(_$AppBackgroundColorSchemeImpl) then) =
      __$$AppBackgroundColorSchemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@ColorConverter() Color primary});
}

/// @nodoc
class __$$AppBackgroundColorSchemeImplCopyWithImpl<$Res>
    extends _$AppBackgroundColorSchemeCopyWithImpl<$Res,
        _$AppBackgroundColorSchemeImpl>
    implements _$$AppBackgroundColorSchemeImplCopyWith<$Res> {
  __$$AppBackgroundColorSchemeImplCopyWithImpl(
      _$AppBackgroundColorSchemeImpl _value,
      $Res Function(_$AppBackgroundColorSchemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppBackgroundColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
  }) {
    return _then(_$AppBackgroundColorSchemeImpl(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBackgroundColorSchemeImpl implements _AppBackgroundColorScheme {
  const _$AppBackgroundColorSchemeImpl(
      {@ColorConverter() required this.primary});

  factory _$AppBackgroundColorSchemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBackgroundColorSchemeImplFromJson(json);

  @override
  @ColorConverter()
  final Color primary;

  @override
  String toString() {
    return 'AppBackgroundColorScheme(primary: $primary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBackgroundColorSchemeImpl &&
            (identical(other.primary, primary) || other.primary == primary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, primary);

  /// Create a copy of AppBackgroundColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBackgroundColorSchemeImplCopyWith<_$AppBackgroundColorSchemeImpl>
      get copyWith => __$$AppBackgroundColorSchemeImplCopyWithImpl<
          _$AppBackgroundColorSchemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBackgroundColorSchemeImplToJson(
      this,
    );
  }
}

abstract class _AppBackgroundColorScheme implements AppBackgroundColorScheme {
  const factory _AppBackgroundColorScheme(
          {@ColorConverter() required final Color primary}) =
      _$AppBackgroundColorSchemeImpl;

  factory _AppBackgroundColorScheme.fromJson(Map<String, dynamic> json) =
      _$AppBackgroundColorSchemeImpl.fromJson;

  @override
  @ColorConverter()
  Color get primary;

  /// Create a copy of AppBackgroundColorScheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppBackgroundColorSchemeImplCopyWith<_$AppBackgroundColorSchemeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
