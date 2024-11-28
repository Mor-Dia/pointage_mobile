// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panier_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Panier _$PanierPFromJson(Map<String, dynamic> json) {
  return _PanierP.fromJson(json);
}

/// @nodoc
mixin _$Panier {
  int? get id =>
      throw _privateConstructorUsedError; // Identifiant unique pour la commande ou le panier
  int? get total =>
      throw _privateConstructorUsedError; // Montant total de la commande
  @JsonKey(name: 'panier_produit')
  List<PanierPProduit>? get panierProduit => throw _privateConstructorUsedError;

  /// Serializes this Panier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Panier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PanierPCopyWith<Panier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierPCopyWith<$Res> {
  factory $PanierPCopyWith(Panier value, $Res Function(Panier) then) =
      _$PanierPCopyWithImpl<$Res, Panier>;
  @useResult
  $Res call(
      {int? id,
      int? total,
      @JsonKey(name: 'panier_produit') List<PanierPProduit>? panierProduit});
}

/// @nodoc
class _$PanierPCopyWithImpl<$Res, $Val extends Panier>
    implements $PanierPCopyWith<$Res> {
  _$PanierPCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Panier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? panierProduit = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      panierProduit: freezed == panierProduit
          ? _value.panierProduit
          : panierProduit // ignore: cast_nullable_to_non_nullable
              as List<PanierPProduit>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PanierPImplCopyWith<$Res> implements $PanierPCopyWith<$Res> {
  factory _$$PanierPImplCopyWith(
          _$PanierPImpl value, $Res Function(_$PanierPImpl) then) =
      __$$PanierPImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? total,
      @JsonKey(name: 'panier_produit') List<PanierPProduit>? panierProduit});
}

/// @nodoc
class __$$PanierPImplCopyWithImpl<$Res>
    extends _$PanierPCopyWithImpl<$Res, _$PanierPImpl>
    implements _$$PanierPImplCopyWith<$Res> {
  __$$PanierPImplCopyWithImpl(
      _$PanierPImpl _value, $Res Function(_$PanierPImpl) _then)
      : super(_value, _then);

  /// Create a copy of Panier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? total = freezed,
    Object? panierProduit = freezed,
  }) {
    return _then(_$PanierPImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      panierProduit: freezed == panierProduit
          ? _value._panierProduit
          : panierProduit // ignore: cast_nullable_to_non_nullable
              as List<PanierPProduit>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PanierPImpl extends _PanierP with DiagnosticableTreeMixin {
  const _$PanierPImpl(
      {this.id,
      this.total,
      @JsonKey(name: 'panier_produit')
      final List<PanierPProduit>? panierProduit})
      : _panierProduit = panierProduit,
        super._();

  factory _$PanierPImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanierPImplFromJson(json);

  @override
  final int? id;
// Identifiant unique pour la commande ou le panier
  @override
  final int? total;
// Montant total de la commande
  final List<PanierPProduit>? _panierProduit;
// Montant total de la commande
  @override
  @JsonKey(name: 'panier_produit')
  List<PanierPProduit>? get panierProduit {
    final value = _panierProduit;
    if (value == null) return null;
    if (_panierProduit is EqualUnmodifiableListView) return _panierProduit;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Panier(id: $id, total: $total, panierProduit: $panierProduit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Panier'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('panierProduit', panierProduit));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanierPImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality()
                .equals(other._panierProduit, _panierProduit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, total,
      const DeepCollectionEquality().hash(_panierProduit));

  /// Create a copy of Panier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanierPImplCopyWith<_$PanierPImpl> get copyWith =>
      __$$PanierPImplCopyWithImpl<_$PanierPImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PanierPImplToJson(
      this,
    );
  }
}

abstract class _PanierP extends Panier {
  const factory _PanierP(
      {final int? id,
      final int? total,
      @JsonKey(name: 'panier_produit')
      final List<PanierPProduit>? panierProduit}) = _$PanierPImpl;
  const _PanierP._() : super._();

  factory _PanierP.fromJson(Map<String, dynamic> json) = _$PanierPImpl.fromJson;

  @override
  int? get id; // Identifiant unique pour la commande ou le panier
  @override
  int? get total; // Montant total de la commande
  @override
  @JsonKey(name: 'panier_produit')
  List<PanierPProduit>? get panierProduit;

  /// Create a copy of Panier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanierPImplCopyWith<_$PanierPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
