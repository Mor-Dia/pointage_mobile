// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banniere_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Banniere _$BanniereFromJson(Map<String, dynamic> json) {
  return _Banniere.fromJson(json);
}

/// @nodoc
mixin _$Banniere {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this Banniere to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Banniere
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BanniereCopyWith<Banniere> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BanniereCopyWith<$Res> {
  factory $BanniereCopyWith(Banniere value, $Res Function(Banniere) then) =
      _$BanniereCopyWithImpl<$Res, Banniere>;
  @useResult
  $Res call({int? id, String? designation, String? image});
}

/// @nodoc
class _$BanniereCopyWithImpl<$Res, $Val extends Banniere>
    implements $BanniereCopyWith<$Res> {
  _$BanniereCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Banniere
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BanniereImplCopyWith<$Res>
    implements $BanniereCopyWith<$Res> {
  factory _$$BanniereImplCopyWith(
          _$BanniereImpl value, $Res Function(_$BanniereImpl) then) =
      __$$BanniereImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation, String? image});
}

/// @nodoc
class __$$BanniereImplCopyWithImpl<$Res>
    extends _$BanniereCopyWithImpl<$Res, _$BanniereImpl>
    implements _$$BanniereImplCopyWith<$Res> {
  __$$BanniereImplCopyWithImpl(
      _$BanniereImpl _value, $Res Function(_$BanniereImpl) _then)
      : super(_value, _then);

  /// Create a copy of Banniere
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? image = freezed,
  }) {
    return _then(_$BanniereImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BanniereImpl extends _Banniere with DiagnosticableTreeMixin {
  const _$BanniereImpl({this.id, this.designation, this.image}) : super._();

  factory _$BanniereImpl.fromJson(Map<String, dynamic> json) =>
      _$$BanniereImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;
  @override
  final String? image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Banniere(id: $id, designation: $designation, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Banniere'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BanniereImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation, image);

  /// Create a copy of Banniere
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BanniereImplCopyWith<_$BanniereImpl> get copyWith =>
      __$$BanniereImplCopyWithImpl<_$BanniereImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BanniereImplToJson(
      this,
    );
  }
}

abstract class _Banniere extends Banniere {
  const factory _Banniere(
      {final int? id,
      final String? designation,
      final String? image}) = _$BanniereImpl;
  const _Banniere._() : super._();

  factory _Banniere.fromJson(Map<String, dynamic> json) =
      _$BanniereImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  String? get image;

  /// Create a copy of Banniere
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BanniereImplCopyWith<_$BanniereImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
