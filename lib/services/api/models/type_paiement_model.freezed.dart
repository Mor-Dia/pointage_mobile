// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_paiement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TypePaiement _$TypePaiementFromJson(Map<String, dynamic> json) {
  return _TypePaiement.fromJson(json);
}

/// @nodoc
mixin _$TypePaiement {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  @JsonKey(name: "solde_disponible")
  double? get soldeDisponible => throw _privateConstructorUsedError;
  @JsonKey(name: "is_ligne_credit")
  bool? get isLigneCredit => throw _privateConstructorUsedError;

  /// Serializes this TypePaiement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypePaiement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypePaiementCopyWith<TypePaiement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypePaiementCopyWith<$Res> {
  factory $TypePaiementCopyWith(
          TypePaiement value, $Res Function(TypePaiement) then) =
      _$TypePaiementCopyWithImpl<$Res, TypePaiement>;
  @useResult
  $Res call(
      {int? id,
      String? designation,
      @JsonKey(name: "solde_disponible") double? soldeDisponible,
      @JsonKey(name: "is_ligne_credit") bool? isLigneCredit});
}

/// @nodoc
class _$TypePaiementCopyWithImpl<$Res, $Val extends TypePaiement>
    implements $TypePaiementCopyWith<$Res> {
  _$TypePaiementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypePaiement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? soldeDisponible = freezed,
    Object? isLigneCredit = freezed,
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
      soldeDisponible: freezed == soldeDisponible
          ? _value.soldeDisponible
          : soldeDisponible // ignore: cast_nullable_to_non_nullable
              as double?,
      isLigneCredit: freezed == isLigneCredit
          ? _value.isLigneCredit
          : isLigneCredit // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypePaiementImplCopyWith<$Res>
    implements $TypePaiementCopyWith<$Res> {
  factory _$$TypePaiementImplCopyWith(
          _$TypePaiementImpl value, $Res Function(_$TypePaiementImpl) then) =
      __$$TypePaiementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? designation,
      @JsonKey(name: "solde_disponible") double? soldeDisponible,
      @JsonKey(name: "is_ligne_credit") bool? isLigneCredit});
}

/// @nodoc
class __$$TypePaiementImplCopyWithImpl<$Res>
    extends _$TypePaiementCopyWithImpl<$Res, _$TypePaiementImpl>
    implements _$$TypePaiementImplCopyWith<$Res> {
  __$$TypePaiementImplCopyWithImpl(
      _$TypePaiementImpl _value, $Res Function(_$TypePaiementImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypePaiement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? soldeDisponible = freezed,
    Object? isLigneCredit = freezed,
  }) {
    return _then(_$TypePaiementImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      soldeDisponible: freezed == soldeDisponible
          ? _value.soldeDisponible
          : soldeDisponible // ignore: cast_nullable_to_non_nullable
              as double?,
      isLigneCredit: freezed == isLigneCredit
          ? _value.isLigneCredit
          : isLigneCredit // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypePaiementImpl extends _TypePaiement with DiagnosticableTreeMixin {
  const _$TypePaiementImpl(
      {this.id,
      this.designation,
      @JsonKey(name: "solde_disponible") this.soldeDisponible,
      @JsonKey(name: "is_ligne_credit") this.isLigneCredit})
      : super._();

  factory _$TypePaiementImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypePaiementImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;
  @override
  @JsonKey(name: "solde_disponible")
  final double? soldeDisponible;
  @override
  @JsonKey(name: "is_ligne_credit")
  final bool? isLigneCredit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TypePaiement(id: $id, designation: $designation, soldeDisponible: $soldeDisponible, isLigneCredit: $isLigneCredit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TypePaiement'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('soldeDisponible', soldeDisponible))
      ..add(DiagnosticsProperty('isLigneCredit', isLigneCredit));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypePaiementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.soldeDisponible, soldeDisponible) ||
                other.soldeDisponible == soldeDisponible) &&
            (identical(other.isLigneCredit, isLigneCredit) ||
                other.isLigneCredit == isLigneCredit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, designation, soldeDisponible, isLigneCredit);

  /// Create a copy of TypePaiement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypePaiementImplCopyWith<_$TypePaiementImpl> get copyWith =>
      __$$TypePaiementImplCopyWithImpl<_$TypePaiementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypePaiementImplToJson(
      this,
    );
  }
}

abstract class _TypePaiement extends TypePaiement {
  const factory _TypePaiement(
          {final int? id,
          final String? designation,
          @JsonKey(name: "solde_disponible") final double? soldeDisponible,
          @JsonKey(name: "is_ligne_credit") final bool? isLigneCredit}) =
      _$TypePaiementImpl;
  const _TypePaiement._() : super._();

  factory _TypePaiement.fromJson(Map<String, dynamic> json) =
      _$TypePaiementImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  @JsonKey(name: "solde_disponible")
  double? get soldeDisponible;
  @override
  @JsonKey(name: "is_ligne_credit")
  bool? get isLigneCredit;

  /// Create a copy of TypePaiement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypePaiementImplCopyWith<_$TypePaiementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
