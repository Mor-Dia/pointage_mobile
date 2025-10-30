// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commande_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Commande _$CommandeFromJson(Map<String, dynamic> json) {
  return _Commande.fromJson(json);
}

/// @nodoc
mixin _$Commande {
  int? get id => throw _privateConstructorUsedError;
  dynamic? get total => throw _privateConstructorUsedError;
  String? get displaycoloretat => throw _privateConstructorUsedError;
  String? get displayetat => throw _privateConstructorUsedError;
  String? get etat_paiement => throw _privateConstructorUsedError;
  String? get color_etat_paiement => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr => throw _privateConstructorUsedError;
  @JsonKey(name: "vente_produits")
  List<VenteProduit>? get venteProduits => throw _privateConstructorUsedError;
  @JsonKey(name: "zone_livraison")
  ZoneLivraison? get zoneLivraison => throw _privateConstructorUsedError;

  /// Serializes this Commande to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommandeCopyWith<Commande> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommandeCopyWith<$Res> {
  factory $CommandeCopyWith(Commande value, $Res Function(Commande) then) =
      _$CommandeCopyWithImpl<$Res, Commande>;
  @useResult
  $Res call(
      {int? id,
      dynamic? total,
      String? displaycoloretat,
      String? displayetat,
      String? etat_paiement,
      String? color_etat_paiement,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      @JsonKey(name: "vente_produits") List<VenteProduit>? venteProduits,
      @JsonKey(name: "zone_livraison") ZoneLivraison? zoneLivraison});

  $ZoneLivraisonCopyWith<$Res>? get zoneLivraison;
}

/// @nodoc
class _$CommandeCopyWithImpl<$Res, $Val extends Commande>
    implements $CommandeCopyWith<$Res> {
  _$CommandeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? displaycoloretat = freezed,
    Object? displayetat = freezed,
    Object? etat_paiement = freezed,
    Object? color_etat_paiement = freezed,
    Object? createdAtFr = freezed,
    Object? venteProduits = freezed,
    Object? zoneLivraison = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      etat_paiement: freezed == etat_paiement
          ? _value.etat_paiement
          : etat_paiement // ignore: cast_nullable_to_non_nullable
              as String?,
      color_etat_paiement: freezed == color_etat_paiement
          ? _value.color_etat_paiement
          : color_etat_paiement // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      venteProduits: freezed == venteProduits
          ? _value.venteProduits
          : venteProduits // ignore: cast_nullable_to_non_nullable
              as List<VenteProduit>?,
      zoneLivraison: freezed == zoneLivraison
          ? _value.zoneLivraison
          : zoneLivraison // ignore: cast_nullable_to_non_nullable
              as ZoneLivraison?,
    ) as $Val);
  }

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ZoneLivraisonCopyWith<$Res>? get zoneLivraison {
    if (_value.zoneLivraison == null) {
      return null;
    }

    return $ZoneLivraisonCopyWith<$Res>(_value.zoneLivraison!, (value) {
      return _then(_value.copyWith(zoneLivraison: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommandeImplCopyWith<$Res>
    implements $CommandeCopyWith<$Res> {
  factory _$$CommandeImplCopyWith(
          _$CommandeImpl value, $Res Function(_$CommandeImpl) then) =
      __$$CommandeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      dynamic? total,
      String? displaycoloretat,
      String? displayetat,
      String? etat_paiement,
      String? color_etat_paiement,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      @JsonKey(name: "vente_produits") List<VenteProduit>? venteProduits,
      @JsonKey(name: "zone_livraison") ZoneLivraison? zoneLivraison});

  @override
  $ZoneLivraisonCopyWith<$Res>? get zoneLivraison;
}

/// @nodoc
class __$$CommandeImplCopyWithImpl<$Res>
    extends _$CommandeCopyWithImpl<$Res, _$CommandeImpl>
    implements _$$CommandeImplCopyWith<$Res> {
  __$$CommandeImplCopyWithImpl(
      _$CommandeImpl _value, $Res Function(_$CommandeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? displaycoloretat = freezed,
    Object? displayetat = freezed,
    Object? etat_paiement = freezed,
    Object? color_etat_paiement = freezed,
    Object? createdAtFr = freezed,
    Object? venteProduits = freezed,
    Object? zoneLivraison = freezed,
  }) {
    return _then(_$CommandeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      etat_paiement: freezed == etat_paiement
          ? _value.etat_paiement
          : etat_paiement // ignore: cast_nullable_to_non_nullable
              as String?,
      color_etat_paiement: freezed == color_etat_paiement
          ? _value.color_etat_paiement
          : color_etat_paiement // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      venteProduits: freezed == venteProduits
          ? _value._venteProduits
          : venteProduits // ignore: cast_nullable_to_non_nullable
              as List<VenteProduit>?,
      zoneLivraison: freezed == zoneLivraison
          ? _value.zoneLivraison
          : zoneLivraison // ignore: cast_nullable_to_non_nullable
              as ZoneLivraison?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommandeImpl extends _Commande with DiagnosticableTreeMixin {
  const _$CommandeImpl(
      {this.id,
      this.total,
      this.displaycoloretat,
      this.displayetat,
      this.etat_paiement,
      this.color_etat_paiement,
      @JsonKey(name: "created_at_fr") this.createdAtFr,
      @JsonKey(name: "vente_produits") final List<VenteProduit>? venteProduits,
      @JsonKey(name: "zone_livraison") this.zoneLivraison})
      : _venteProduits = venteProduits,
        super._();

  factory _$CommandeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommandeImplFromJson(json);

  @override
  final int? id;
  @override
  final dynamic? total;
  @override
  final String? displaycoloretat;
  @override
  final String? displayetat;
  @override
  final String? etat_paiement;
  @override
  final String? color_etat_paiement;
  @override
  @JsonKey(name: "created_at_fr")
  final String? createdAtFr;
  final List<VenteProduit>? _venteProduits;
  @override
  @JsonKey(name: "vente_produits")
  List<VenteProduit>? get venteProduits {
    final value = _venteProduits;
    if (value == null) return null;
    if (_venteProduits is EqualUnmodifiableListView) return _venteProduits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "zone_livraison")
  final ZoneLivraison? zoneLivraison;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Commande(id: $id, total: $total, displaycoloretat: $displaycoloretat, displayetat: $displayetat, etat_paiement: $etat_paiement, color_etat_paiement: $color_etat_paiement, createdAtFr: $createdAtFr, venteProduits: $venteProduits, zoneLivraison: $zoneLivraison)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Commande'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('displaycoloretat', displaycoloretat))
      ..add(DiagnosticsProperty('displayetat', displayetat))
      ..add(DiagnosticsProperty('etat_paiement', etat_paiement))
      ..add(DiagnosticsProperty('color_etat_paiement', color_etat_paiement))
      ..add(DiagnosticsProperty('createdAtFr', createdAtFr))
      ..add(DiagnosticsProperty('venteProduits', venteProduits))
      ..add(DiagnosticsProperty('zoneLivraison', zoneLivraison));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommandeImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            (identical(other.displaycoloretat, displaycoloretat) ||
                other.displaycoloretat == displaycoloretat) &&
            (identical(other.displayetat, displayetat) ||
                other.displayetat == displayetat) &&
            (identical(other.etat_paiement, etat_paiement) ||
                other.etat_paiement == etat_paiement) &&
            (identical(other.color_etat_paiement, color_etat_paiement) ||
                other.color_etat_paiement == color_etat_paiement) &&
            (identical(other.createdAtFr, createdAtFr) ||
                other.createdAtFr == createdAtFr) &&
            const DeepCollectionEquality()
                .equals(other._venteProduits, _venteProduits) &&
            (identical(other.zoneLivraison, zoneLivraison) ||
                other.zoneLivraison == zoneLivraison));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(total),
      displaycoloretat,
      displayetat,
      etat_paiement,
      color_etat_paiement,
      createdAtFr,
      const DeepCollectionEquality().hash(_venteProduits),
      zoneLivraison);

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommandeImplCopyWith<_$CommandeImpl> get copyWith =>
      __$$CommandeImplCopyWithImpl<_$CommandeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommandeImplToJson(
      this,
    );
  }
}

abstract class _Commande extends Commande {
  const factory _Commande(
      {final int? id,
      final dynamic? total,
      final String? displaycoloretat,
      final String? displayetat,
      final String? etat_paiement,
      final String? color_etat_paiement,
      @JsonKey(name: "created_at_fr") final String? createdAtFr,
      @JsonKey(name: "vente_produits") final List<VenteProduit>? venteProduits,
      @JsonKey(name: "zone_livraison")
      final ZoneLivraison? zoneLivraison}) = _$CommandeImpl;
  const _Commande._() : super._();

  factory _Commande.fromJson(Map<String, dynamic> json) =
      _$CommandeImpl.fromJson;

  @override
  int? get id;
  @override
  dynamic? get total;
  @override
  String? get displaycoloretat;
  @override
  String? get displayetat;
  @override
  String? get etat_paiement;
  @override
  String? get color_etat_paiement;
  @override
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr;
  @override
  @JsonKey(name: "vente_produits")
  List<VenteProduit>? get venteProduits;
  @override
  @JsonKey(name: "zone_livraison")
  ZoneLivraison? get zoneLivraison;

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommandeImplCopyWith<_$CommandeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VenteProduit _$VenteProduitFromJson(Map<String, dynamic> json) {
  return _VenteProduit.fromJson(json);
}

/// @nodoc
mixin _$VenteProduit {
  int? get id => throw _privateConstructorUsedError;
  int? get quantite => throw _privateConstructorUsedError;
  dynamic? get total => throw _privateConstructorUsedError;
  Produit? get produit => throw _privateConstructorUsedError;

  /// Serializes this VenteProduit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VenteProduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VenteProduitCopyWith<VenteProduit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenteProduitCopyWith<$Res> {
  factory $VenteProduitCopyWith(
          VenteProduit value, $Res Function(VenteProduit) then) =
      _$VenteProduitCopyWithImpl<$Res, VenteProduit>;
  @useResult
  $Res call({int? id, int? quantite, dynamic? total, Produit? produit});

  $ProduitCopyWith<$Res>? get produit;
}

/// @nodoc
class _$VenteProduitCopyWithImpl<$Res, $Val extends VenteProduit>
    implements $VenteProduitCopyWith<$Res> {
  _$VenteProduitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VenteProduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quantite = freezed,
    Object? total = freezed,
    Object? produit = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      quantite: freezed == quantite
          ? _value.quantite
          : quantite // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      produit: freezed == produit
          ? _value.produit
          : produit // ignore: cast_nullable_to_non_nullable
              as Produit?,
    ) as $Val);
  }

  /// Create a copy of VenteProduit
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
abstract class _$$VenteProduitImplCopyWith<$Res>
    implements $VenteProduitCopyWith<$Res> {
  factory _$$VenteProduitImplCopyWith(
          _$VenteProduitImpl value, $Res Function(_$VenteProduitImpl) then) =
      __$$VenteProduitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? quantite, dynamic? total, Produit? produit});

  @override
  $ProduitCopyWith<$Res>? get produit;
}

/// @nodoc
class __$$VenteProduitImplCopyWithImpl<$Res>
    extends _$VenteProduitCopyWithImpl<$Res, _$VenteProduitImpl>
    implements _$$VenteProduitImplCopyWith<$Res> {
  __$$VenteProduitImplCopyWithImpl(
      _$VenteProduitImpl _value, $Res Function(_$VenteProduitImpl) _then)
      : super(_value, _then);

  /// Create a copy of VenteProduit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quantite = freezed,
    Object? total = freezed,
    Object? produit = freezed,
  }) {
    return _then(_$VenteProduitImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      quantite: freezed == quantite
          ? _value.quantite
          : quantite // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      produit: freezed == produit
          ? _value.produit
          : produit // ignore: cast_nullable_to_non_nullable
              as Produit?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VenteProduitImpl extends _VenteProduit with DiagnosticableTreeMixin {
  const _$VenteProduitImpl({this.id, this.quantite, this.total, this.produit})
      : super._();

  factory _$VenteProduitImpl.fromJson(Map<String, dynamic> json) =>
      _$$VenteProduitImplFromJson(json);

  @override
  final int? id;
  @override
  final int? quantite;
  @override
  final dynamic? total;
  @override
  final Produit? produit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VenteProduit(id: $id, quantite: $quantite, total: $total, produit: $produit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VenteProduit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('quantite', quantite))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('produit', produit));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VenteProduitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quantite, quantite) ||
                other.quantite == quantite) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            (identical(other.produit, produit) || other.produit == produit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, quantite,
      const DeepCollectionEquality().hash(total), produit);

  /// Create a copy of VenteProduit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VenteProduitImplCopyWith<_$VenteProduitImpl> get copyWith =>
      __$$VenteProduitImplCopyWithImpl<_$VenteProduitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VenteProduitImplToJson(
      this,
    );
  }
}

abstract class _VenteProduit extends VenteProduit {
  const factory _VenteProduit(
      {final int? id,
      final int? quantite,
      final dynamic? total,
      final Produit? produit}) = _$VenteProduitImpl;
  const _VenteProduit._() : super._();

  factory _VenteProduit.fromJson(Map<String, dynamic> json) =
      _$VenteProduitImpl.fromJson;

  @override
  int? get id;
  @override
  int? get quantite;
  @override
  dynamic? get total;
  @override
  Produit? get produit;

  /// Create a copy of VenteProduit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VenteProduitImplCopyWith<_$VenteProduitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ZoneLivraison _$ZoneLivraisonFromJson(Map<String, dynamic> json) {
  return _ZoneLivraison.fromJson(json);
}

/// @nodoc
mixin _$ZoneLivraison {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  dynamic? get prix => throw _privateConstructorUsedError;

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
  $Res call({int? id, String? designation, dynamic? prix});
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
              as dynamic?,
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
  $Res call({int? id, String? designation, dynamic? prix});
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
              as dynamic?,
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
  final dynamic? prix;

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
            const DeepCollectionEquality().equals(other.prix, prix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, designation, const DeepCollectionEquality().hash(prix));

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
      final dynamic? prix}) = _$ZoneLivraisonImpl;
  const _ZoneLivraison._() : super._();

  factory _ZoneLivraison.fromJson(Map<String, dynamic> json) =
      _$ZoneLivraisonImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  dynamic? get prix;

  /// Create a copy of ZoneLivraison
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ZoneLivraisonImplCopyWith<_$ZoneLivraisonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
