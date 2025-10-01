// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zone_livraison_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ZoneLivraison _$ZoneLivraisonFromJson(Map<String, dynamic> json) {
  return _ZoneLivraison.fromJson(json);
}

/// @nodoc
mixin _$ZoneLivraison {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  double? get prix => throw _privateConstructorUsedError;

  /// Serializes this ZoneLivraison to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ZoneLivraisonCopyWith<ZoneLivraison> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZoneLivraisonCopyWith<$Res> {
  factory $ZoneLivraisonCopyWith(
          ZoneLivraison value, $Res Function(ZoneLivraison) then) =
      _$ZoneLivraisonCopyWithImpl<$Res, ZoneLivraison>;
  @useResult
  $Res call({int? id, String? designation, double? prix});
}

/// @nodoc
class _$ZoneLivraisonCopyWithImpl<$Res, $Val extends ZoneLivraison>
    implements $ZoneLivraisonCopyWith<$Res> {
  _$ZoneLivraisonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? prix = freezed,
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
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ZoneLivraisonImplCopyWith<$Res>
    implements $ZoneLivraisonCopyWith<$Res> {
  factory _$$ZoneLivraisonImplCopyWith(
          _$ZoneLivraisonImpl value, $Res Function(_$ZoneLivraisonImpl) then) =
      __$$ZoneLivraisonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation, double? prix});
}

/// @nodoc
class __$$ZoneLivraisonImplCopyWithImpl<$Res>
    extends _$ZoneLivraisonCopyWithImpl<$Res, _$ZoneLivraisonImpl>
    implements _$$ZoneLivraisonImplCopyWith<$Res> {
  __$$ZoneLivraisonImplCopyWithImpl(
      _$ZoneLivraisonImpl _value, $Res Function(_$ZoneLivraisonImpl) _then)
      : super(_value, _then);

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? prix = freezed,
  }) {
    return _then(_$ZoneLivraisonImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ZoneLivraisonImpl extends _ZoneLivraison with DiagnosticableTreeMixin {
  const _$ZoneLivraisonImpl({this.id, this.designation, this.prix}) : super._();

  factory _$ZoneLivraisonImpl.fromJson(Map<String, dynamic> json) =>
      _$$ZoneLivraisonImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;
  @override
  final double? prix;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ZoneLivraison(id: $id, designation: $designation, prix: $prix)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ZoneLivraison'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('prix', prix));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ZoneLivraisonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.prix, prix) || other.prix == prix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation, prix);

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ZoneLivraisonImplCopyWith<_$ZoneLivraisonImpl> get copyWith =>
      __$$ZoneLivraisonImplCopyWithImpl<_$ZoneLivraisonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ZoneLivraisonImplToJson(
      this,
    );
  }
}

abstract class _ZoneLivraison extends ZoneLivraison {
  const factory _ZoneLivraison(
      {final int? id,
      final String? designation,
      final double? prix}) = _$ZoneLivraisonImpl;
  const _ZoneLivraison._() : super._();

  factory _ZoneLivraison.fromJson(Map<String, dynamic> json) =
      _$ZoneLivraisonImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  double? get prix;

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZoneLivraisonImplCopyWith<_$ZoneLivraisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
