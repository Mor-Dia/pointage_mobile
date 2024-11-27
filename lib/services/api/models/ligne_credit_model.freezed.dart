// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ligne_credit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LigneCredit _$LigneCreditFromJson(Map<String, dynamic> json) {
  return _LigneCredit.fromJson(json);
}

/// @nodoc
mixin _$LigneCredit {
  int? get id => throw _privateConstructorUsedError;
  dynamic? get solde => throw _privateConstructorUsedError;
  dynamic? get montant => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr => throw _privateConstructorUsedError;
  @JsonKey(name: "type_paiement")
  TypePaiement? get typePaiement => throw _privateConstructorUsedError;
  @JsonKey(name: "type_ligne_credit")
  TypeLigneCredit? get typeLigneCredit => throw _privateConstructorUsedError;
  @JsonKey(name: "date_fr")
  String? get dateFr => throw _privateConstructorUsedError;

  /// Serializes this LigneCredit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LigneCreditCopyWith<LigneCredit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LigneCreditCopyWith<$Res> {
  factory $LigneCreditCopyWith(
          LigneCredit value, $Res Function(LigneCredit) then) =
      _$LigneCreditCopyWithImpl<$Res, LigneCredit>;
  @useResult
  $Res call(
      {int? id,
      dynamic? solde,
      dynamic? montant,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      @JsonKey(name: "type_paiement") TypePaiement? typePaiement,
      @JsonKey(name: "type_ligne_credit") TypeLigneCredit? typeLigneCredit,
      @JsonKey(name: "date_fr") String? dateFr});

  $TypePaiementCopyWith<$Res>? get typePaiement;
  $TypeLigneCreditCopyWith<$Res>? get typeLigneCredit;
}

/// @nodoc
class _$LigneCreditCopyWithImpl<$Res, $Val extends LigneCredit>
    implements $LigneCreditCopyWith<$Res> {
  _$LigneCreditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? solde = freezed,
    Object? montant = freezed,
    Object? createdAtFr = freezed,
    Object? typePaiement = freezed,
    Object? typeLigneCredit = freezed,
    Object? dateFr = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      solde: freezed == solde
          ? _value.solde
          : solde // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      montant: freezed == montant
          ? _value.montant
          : montant // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      typePaiement: freezed == typePaiement
          ? _value.typePaiement
          : typePaiement // ignore: cast_nullable_to_non_nullable
              as TypePaiement?,
      typeLigneCredit: freezed == typeLigneCredit
          ? _value.typeLigneCredit
          : typeLigneCredit // ignore: cast_nullable_to_non_nullable
              as TypeLigneCredit?,
      dateFr: freezed == dateFr
          ? _value.dateFr
          : dateFr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypePaiementCopyWith<$Res>? get typePaiement {
    if (_value.typePaiement == null) {
      return null;
    }

    return $TypePaiementCopyWith<$Res>(_value.typePaiement!, (value) {
      return _then(_value.copyWith(typePaiement: value) as $Val);
    });
  }

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeLigneCreditCopyWith<$Res>? get typeLigneCredit {
    if (_value.typeLigneCredit == null) {
      return null;
    }

    return $TypeLigneCreditCopyWith<$Res>(_value.typeLigneCredit!, (value) {
      return _then(_value.copyWith(typeLigneCredit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LigneCreditImplCopyWith<$Res>
    implements $LigneCreditCopyWith<$Res> {
  factory _$$LigneCreditImplCopyWith(
          _$LigneCreditImpl value, $Res Function(_$LigneCreditImpl) then) =
      __$$LigneCreditImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      dynamic? solde,
      dynamic? montant,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      @JsonKey(name: "type_paiement") TypePaiement? typePaiement,
      @JsonKey(name: "type_ligne_credit") TypeLigneCredit? typeLigneCredit,
      @JsonKey(name: "date_fr") String? dateFr});

  @override
  $TypePaiementCopyWith<$Res>? get typePaiement;
  @override
  $TypeLigneCreditCopyWith<$Res>? get typeLigneCredit;
}

/// @nodoc
class __$$LigneCreditImplCopyWithImpl<$Res>
    extends _$LigneCreditCopyWithImpl<$Res, _$LigneCreditImpl>
    implements _$$LigneCreditImplCopyWith<$Res> {
  __$$LigneCreditImplCopyWithImpl(
      _$LigneCreditImpl _value, $Res Function(_$LigneCreditImpl) _then)
      : super(_value, _then);

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? solde = freezed,
    Object? montant = freezed,
    Object? createdAtFr = freezed,
    Object? typePaiement = freezed,
    Object? typeLigneCredit = freezed,
    Object? dateFr = freezed,
  }) {
    return _then(_$LigneCreditImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      solde: freezed == solde
          ? _value.solde
          : solde // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      montant: freezed == montant
          ? _value.montant
          : montant // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      typePaiement: freezed == typePaiement
          ? _value.typePaiement
          : typePaiement // ignore: cast_nullable_to_non_nullable
              as TypePaiement?,
      typeLigneCredit: freezed == typeLigneCredit
          ? _value.typeLigneCredit
          : typeLigneCredit // ignore: cast_nullable_to_non_nullable
              as TypeLigneCredit?,
      dateFr: freezed == dateFr
          ? _value.dateFr
          : dateFr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LigneCreditImpl extends _LigneCredit with DiagnosticableTreeMixin {
  const _$LigneCreditImpl(
      {this.id,
      this.solde,
      this.montant,
      @JsonKey(name: "created_at_fr") this.createdAtFr,
      @JsonKey(name: "type_paiement") this.typePaiement,
      @JsonKey(name: "type_ligne_credit") this.typeLigneCredit,
      @JsonKey(name: "date_fr") this.dateFr})
      : super._();

  factory _$LigneCreditImpl.fromJson(Map<String, dynamic> json) =>
      _$$LigneCreditImplFromJson(json);

  @override
  final int? id;
  @override
  final dynamic? solde;
  @override
  final dynamic? montant;
  @override
  @JsonKey(name: "created_at_fr")
  final String? createdAtFr;
  @override
  @JsonKey(name: "type_paiement")
  final TypePaiement? typePaiement;
  @override
  @JsonKey(name: "type_ligne_credit")
  final TypeLigneCredit? typeLigneCredit;
  @override
  @JsonKey(name: "date_fr")
  final String? dateFr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LigneCredit(id: $id, solde: $solde, montant: $montant, createdAtFr: $createdAtFr, typePaiement: $typePaiement, typeLigneCredit: $typeLigneCredit, dateFr: $dateFr)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LigneCredit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('solde', solde))
      ..add(DiagnosticsProperty('montant', montant))
      ..add(DiagnosticsProperty('createdAtFr', createdAtFr))
      ..add(DiagnosticsProperty('typePaiement', typePaiement))
      ..add(DiagnosticsProperty('typeLigneCredit', typeLigneCredit))
      ..add(DiagnosticsProperty('dateFr', dateFr));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LigneCreditImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.solde, solde) &&
            const DeepCollectionEquality().equals(other.montant, montant) &&
            (identical(other.createdAtFr, createdAtFr) ||
                other.createdAtFr == createdAtFr) &&
            (identical(other.typePaiement, typePaiement) ||
                other.typePaiement == typePaiement) &&
            (identical(other.typeLigneCredit, typeLigneCredit) ||
                other.typeLigneCredit == typeLigneCredit) &&
            (identical(other.dateFr, dateFr) || other.dateFr == dateFr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(solde),
      const DeepCollectionEquality().hash(montant),
      createdAtFr,
      typePaiement,
      typeLigneCredit,
      dateFr);

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LigneCreditImplCopyWith<_$LigneCreditImpl> get copyWith =>
      __$$LigneCreditImplCopyWithImpl<_$LigneCreditImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LigneCreditImplToJson(
      this,
    );
  }
}

abstract class _LigneCredit extends LigneCredit {
  const factory _LigneCredit(
      {final int? id,
      final dynamic? solde,
      final dynamic? montant,
      @JsonKey(name: "created_at_fr") final String? createdAtFr,
      @JsonKey(name: "type_paiement") final TypePaiement? typePaiement,
      @JsonKey(name: "type_ligne_credit")
      final TypeLigneCredit? typeLigneCredit,
      @JsonKey(name: "date_fr") final String? dateFr}) = _$LigneCreditImpl;
  const _LigneCredit._() : super._();

  factory _LigneCredit.fromJson(Map<String, dynamic> json) =
      _$LigneCreditImpl.fromJson;

  @override
  int? get id;
  @override
  dynamic? get solde;
  @override
  dynamic? get montant;
  @override
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr;
  @override
  @JsonKey(name: "type_paiement")
  TypePaiement? get typePaiement;
  @override
  @JsonKey(name: "type_ligne_credit")
  TypeLigneCredit? get typeLigneCredit;
  @override
  @JsonKey(name: "date_fr")
  String? get dateFr;

  /// Create a copy of LigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LigneCreditImplCopyWith<_$LigneCreditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
