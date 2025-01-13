// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panierProduit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PanierPProduit _$PanierPProduitFromJson(Map<String, dynamic> json) {
  return _PanierPProduit.fromJson(json);
}

/// @nodoc
mixin _$PanierPProduit {
  int? get id => throw _privateConstructorUsedError;
  int? get qte => throw _privateConstructorUsedError;
  double? get prix => throw _privateConstructorUsedError;
  double? get total => throw _privateConstructorUsedError;
  Produit? get produit => throw _privateConstructorUsedError;

  /// Serializes this PanierPProduit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanierPProduitCopyWith<PanierPProduit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierPProduitCopyWith<$Res> {
  factory $PanierPProduitCopyWith(
          PanierPProduit value, $Res Function(PanierPProduit) then) =
      _$PanierPProduitCopyWithImpl<$Res, PanierPProduit>;
  @useResult
  $Res call({int? id, int? qte, double? prix, double? total, Produit? produit});

  $ProduitCopyWith<$Res>? get produit;
}

/// @nodoc
class _$PanierPProduitCopyWithImpl<$Res, $Val extends PanierPProduit>
    implements $PanierPProduitCopyWith<$Res> {
  _$PanierPProduitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? qte = freezed,
    Object? prix = freezed,
    Object? total = freezed,
    Object? produit = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      qte: freezed == qte
          ? _value.qte
          : qte // ignore: cast_nullable_to_non_nullable
              as int?,
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double?,
      produit: freezed == produit
          ? _value.produit
          : produit // ignore: cast_nullable_to_non_nullable
              as Produit?,
    ) as $Val);
  }

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProduitCopyWith<$Res>? get produit {
    if (_value.produit == null) {
      return null;
    }

    return $ProduitCopyWith<$Res>(_value.produit!, (value) {
      return _then(_value.copyWith(produit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PanierPProduitImplCopyWith<$Res>
    implements $PanierPProduitCopyWith<$Res> {
  factory _$$PanierPProduitImplCopyWith(_$PanierPProduitImpl value,
          $Res Function(_$PanierPProduitImpl) then) =
      __$$PanierPProduitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? qte, double? prix, double? total, Produit? produit});

  @override
  $ProduitCopyWith<$Res>? get produit;
}

/// @nodoc
class __$$PanierPProduitImplCopyWithImpl<$Res>
    extends _$PanierPProduitCopyWithImpl<$Res, _$PanierPProduitImpl>
    implements _$$PanierPProduitImplCopyWith<$Res> {
  __$$PanierPProduitImplCopyWithImpl(
      _$PanierPProduitImpl _value, $Res Function(_$PanierPProduitImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? qte = freezed,
    Object? prix = freezed,
    Object? total = freezed,
    Object? produit = freezed,
  }) {
    return _then(_$PanierPProduitImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      qte: freezed == qte
          ? _value.qte
          : qte // ignore: cast_nullable_to_non_nullable
              as int?,
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double?,
      produit: freezed == produit
          ? _value.produit
          : produit // ignore: cast_nullable_to_non_nullable
              as Produit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PanierPProduitImpl implements _PanierPProduit {
  const _$PanierPProduitImpl(
      {this.id, this.qte, this.prix, this.total, this.produit});

  factory _$PanierPProduitImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanierPProduitImplFromJson(json);

  @override
  final int? id;
  @override
  final int? qte;
  @override
  final double? prix;
  @override
  final double? total;
  @override
  final Produit? produit;

  @override
  String toString() {
    return 'PanierPProduit(id: $id, qte: $qte, prix: $prix, total: $total, produit: $produit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanierPProduitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.qte, qte) || other.qte == qte) &&
            (identical(other.prix, prix) || other.prix == prix) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.produit, produit) || other.produit == produit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, qte, prix, total, produit);

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanierPProduitImplCopyWith<_$PanierPProduitImpl> get copyWith =>
      __$$PanierPProduitImplCopyWithImpl<_$PanierPProduitImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PanierPProduitImplToJson(
      this,
    );
  }
}

abstract class _PanierPProduit implements PanierPProduit {
  const factory _PanierPProduit(
      {final int? id,
      final int? qte,
      final double? prix,
      final double? total,
      final Produit? produit}) = _$PanierPProduitImpl;

  factory _PanierPProduit.fromJson(Map<String, dynamic> json) =
      _$PanierPProduitImpl.fromJson;

  @override
  int? get id;
  @override
  int? get qte;
  @override
  double? get prix;
  @override
  double? get total;
  @override
  Produit? get produit;

  /// Create a copy of PanierPProduit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanierPProduitImplCopyWith<_$PanierPProduitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
