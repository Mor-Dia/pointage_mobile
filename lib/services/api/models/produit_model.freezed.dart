// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Produit _$ProduitFromJson(Map<String, dynamic> json) {
  return _Produit.fromJson(json);
}

/// @nodoc
mixin _$Produit {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  bool? get favoris => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get marqueId => throw _privateConstructorUsedError;
  String? get marqueDesignation => throw _privateConstructorUsedError;
  @JsonKey(name: "produit_tailles")
  List<Taille>? get produitTailles => throw _privateConstructorUsedError;
  @JsonKey(name: "prix_site_web_fr")
  String? get prixSiteWebFr => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  double? get prix => throw _privateConstructorUsedError;
  int? get familleProduitId => throw _privateConstructorUsedError;
  String? get familleProduitDesignation => throw _privateConstructorUsedError;

  /// Serializes this Produit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Produit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProduitCopyWith<Produit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProduitCopyWith<$Res> {
  factory $ProduitCopyWith(Produit value, $Res Function(Produit) then) =
      _$ProduitCopyWithImpl<$Res, Produit>;
  @useResult
  $Res call(
      {int? id,
      String? designation,
      bool? favoris,
      String? description,
      int? marqueId,
      String? marqueDesignation,
      @JsonKey(name: "produit_tailles") List<Taille>? produitTailles,
      @JsonKey(name: "prix_site_web_fr") String? prixSiteWebFr,
      String? image,
      double? prix,
      int? familleProduitId,
      String? familleProduitDesignation});
}

/// @nodoc
class _$ProduitCopyWithImpl<$Res, $Val extends Produit>
    implements $ProduitCopyWith<$Res> {
  _$ProduitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Produit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? favoris = freezed,
    Object? description = freezed,
    Object? marqueId = freezed,
    Object? marqueDesignation = freezed,
    Object? produitTailles = freezed,
    Object? prixSiteWebFr = freezed,
    Object? image = freezed,
    Object? prix = freezed,
    Object? familleProduitId = freezed,
    Object? familleProduitDesignation = freezed,
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
      favoris: freezed == favoris
          ? _value.favoris
          : favoris // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      marqueId: freezed == marqueId
          ? _value.marqueId
          : marqueId // ignore: cast_nullable_to_non_nullable
              as int?,
      marqueDesignation: freezed == marqueDesignation
          ? _value.marqueDesignation
          : marqueDesignation // ignore: cast_nullable_to_non_nullable
              as String?,
      produitTailles: freezed == produitTailles
          ? _value.produitTailles
          : produitTailles // ignore: cast_nullable_to_non_nullable
              as List<Taille>?,
      prixSiteWebFr: freezed == prixSiteWebFr
          ? _value.prixSiteWebFr
          : prixSiteWebFr // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
      familleProduitId: freezed == familleProduitId
          ? _value.familleProduitId
          : familleProduitId // ignore: cast_nullable_to_non_nullable
              as int?,
      familleProduitDesignation: freezed == familleProduitDesignation
          ? _value.familleProduitDesignation
          : familleProduitDesignation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProduitImplCopyWith<$Res> implements $ProduitCopyWith<$Res> {
  factory _$$ProduitImplCopyWith(
          _$ProduitImpl value, $Res Function(_$ProduitImpl) then) =
      __$$ProduitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? designation,
      bool? favoris,
      String? description,
      int? marqueId,
      String? marqueDesignation,
      @JsonKey(name: "produit_tailles") List<Taille>? produitTailles,
      @JsonKey(name: "prix_site_web_fr") String? prixSiteWebFr,
      String? image,
      double? prix,
      int? familleProduitId,
      String? familleProduitDesignation});
}

/// @nodoc
class __$$ProduitImplCopyWithImpl<$Res>
    extends _$ProduitCopyWithImpl<$Res, _$ProduitImpl>
    implements _$$ProduitImplCopyWith<$Res> {
  __$$ProduitImplCopyWithImpl(
      _$ProduitImpl _value, $Res Function(_$ProduitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Produit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? favoris = freezed,
    Object? description = freezed,
    Object? marqueId = freezed,
    Object? marqueDesignation = freezed,
    Object? produitTailles = freezed,
    Object? prixSiteWebFr = freezed,
    Object? image = freezed,
    Object? prix = freezed,
    Object? familleProduitId = freezed,
    Object? familleProduitDesignation = freezed,
  }) {
    return _then(_$ProduitImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      favoris: freezed == favoris
          ? _value.favoris
          : favoris // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      marqueId: freezed == marqueId
          ? _value.marqueId
          : marqueId // ignore: cast_nullable_to_non_nullable
              as int?,
      marqueDesignation: freezed == marqueDesignation
          ? _value.marqueDesignation
          : marqueDesignation // ignore: cast_nullable_to_non_nullable
              as String?,
      produitTailles: freezed == produitTailles
          ? _value._produitTailles
          : produitTailles // ignore: cast_nullable_to_non_nullable
              as List<Taille>?,
      prixSiteWebFr: freezed == prixSiteWebFr
          ? _value.prixSiteWebFr
          : prixSiteWebFr // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      prix: freezed == prix
          ? _value.prix
          : prix // ignore: cast_nullable_to_non_nullable
              as double?,
      familleProduitId: freezed == familleProduitId
          ? _value.familleProduitId
          : familleProduitId // ignore: cast_nullable_to_non_nullable
              as int?,
      familleProduitDesignation: freezed == familleProduitDesignation
          ? _value.familleProduitDesignation
          : familleProduitDesignation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProduitImpl extends _Produit with DiagnosticableTreeMixin {
  const _$ProduitImpl(
      {this.id,
      this.designation,
      this.favoris,
      this.description,
      this.marqueId,
      this.marqueDesignation,
      @JsonKey(name: "produit_tailles") final List<Taille>? produitTailles,
      @JsonKey(name: "prix_site_web_fr") this.prixSiteWebFr,
      this.image,
      this.prix,
      this.familleProduitId,
      this.familleProduitDesignation})
      : _produitTailles = produitTailles,
        super._();

  factory _$ProduitImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProduitImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;
  @override
  final bool? favoris;
  @override
  final String? description;
  @override
  final int? marqueId;
  @override
  final String? marqueDesignation;
  final List<Taille>? _produitTailles;
  @override
  @JsonKey(name: "produit_tailles")
  List<Taille>? get produitTailles {
    final value = _produitTailles;
    if (value == null) return null;
    if (_produitTailles is EqualUnmodifiableListView) return _produitTailles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "prix_site_web_fr")
  final String? prixSiteWebFr;
  @override
  final String? image;
  @override
  final double? prix;
  @override
  final int? familleProduitId;
  @override
  final String? familleProduitDesignation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Produit(id: $id, designation: $designation, favoris: $favoris, description: $description, marqueId: $marqueId, marqueDesignation: $marqueDesignation, produitTailles: $produitTailles, prixSiteWebFr: $prixSiteWebFr, image: $image, prix: $prix, familleProduitId: $familleProduitId, familleProduitDesignation: $familleProduitDesignation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Produit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('favoris', favoris))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('marqueId', marqueId))
      ..add(DiagnosticsProperty('marqueDesignation', marqueDesignation))
      ..add(DiagnosticsProperty('produitTailles', produitTailles))
      ..add(DiagnosticsProperty('prixSiteWebFr', prixSiteWebFr))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('prix', prix))
      ..add(DiagnosticsProperty('familleProduitId', familleProduitId))
      ..add(DiagnosticsProperty(
          'familleProduitDesignation', familleProduitDesignation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProduitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.favoris, favoris) || other.favoris == favoris) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.marqueId, marqueId) ||
                other.marqueId == marqueId) &&
            (identical(other.marqueDesignation, marqueDesignation) ||
                other.marqueDesignation == marqueDesignation) &&
            const DeepCollectionEquality()
                .equals(other._produitTailles, _produitTailles) &&
            (identical(other.prixSiteWebFr, prixSiteWebFr) ||
                other.prixSiteWebFr == prixSiteWebFr) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.prix, prix) || other.prix == prix) &&
            (identical(other.familleProduitId, familleProduitId) ||
                other.familleProduitId == familleProduitId) &&
            (identical(other.familleProduitDesignation,
                    familleProduitDesignation) ||
                other.familleProduitDesignation == familleProduitDesignation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      designation,
      favoris,
      description,
      marqueId,
      marqueDesignation,
      const DeepCollectionEquality().hash(_produitTailles),
      prixSiteWebFr,
      image,
      prix,
      familleProduitId,
      familleProduitDesignation);

  /// Create a copy of Produit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProduitImplCopyWith<_$ProduitImpl> get copyWith =>
      __$$ProduitImplCopyWithImpl<_$ProduitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProduitImplToJson(
      this,
    );
  }
}

abstract class _Produit extends Produit {
  const factory _Produit(
      {final int? id,
      final String? designation,
      final bool? favoris,
      final String? description,
      final int? marqueId,
      final String? marqueDesignation,
      @JsonKey(name: "produit_tailles") final List<Taille>? produitTailles,
      @JsonKey(name: "prix_site_web_fr") final String? prixSiteWebFr,
      final String? image,
      final double? prix,
      final int? familleProduitId,
      final String? familleProduitDesignation}) = _$ProduitImpl;
  const _Produit._() : super._();

  factory _Produit.fromJson(Map<String, dynamic> json) = _$ProduitImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  bool? get favoris;
  @override
  String? get description;
  @override
  int? get marqueId;
  @override
  String? get marqueDesignation;
  @override
  @JsonKey(name: "produit_tailles")
  List<Taille>? get produitTailles;
  @override
  @JsonKey(name: "prix_site_web_fr")
  String? get prixSiteWebFr;
  @override
  String? get image;
  @override
  double? get prix;
  @override
  int? get familleProduitId;
  @override
  String? get familleProduitDesignation;

  /// Create a copy of Produit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProduitImplCopyWith<_$ProduitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
