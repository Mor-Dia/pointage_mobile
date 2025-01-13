// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favoris_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Favoris _$FavorisFromJson(Map<String, dynamic> json) {
  return _Favoris.fromJson(json);
}

/// @nodoc
mixin _$Favoris {
  List<Produit>? get produits => throw _privateConstructorUsedError;

  /// Serializes this Favoris to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Favoris
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavorisCopyWith<Favoris> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavorisCopyWith<$Res> {
  factory $FavorisCopyWith(Favoris value, $Res Function(Favoris) then) =
      _$FavorisCopyWithImpl<$Res, Favoris>;
  @useResult
  $Res call({List<Produit>? produits});
}

/// @nodoc
class _$FavorisCopyWithImpl<$Res, $Val extends Favoris>
    implements $FavorisCopyWith<$Res> {
  _$FavorisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Favoris
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? produits = freezed,
  }) {
    return _then(_value.copyWith(
      produits: freezed == produits
          ? _value.produits
          : produits // ignore: cast_nullable_to_non_nullable
              as List<Produit>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavorisImplCopyWith<$Res> implements $FavorisCopyWith<$Res> {
  factory _$$FavorisImplCopyWith(
          _$FavorisImpl value, $Res Function(_$FavorisImpl) then) =
      __$$FavorisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Produit>? produits});
}

/// @nodoc
class __$$FavorisImplCopyWithImpl<$Res>
    extends _$FavorisCopyWithImpl<$Res, _$FavorisImpl>
    implements _$$FavorisImplCopyWith<$Res> {
  __$$FavorisImplCopyWithImpl(
      _$FavorisImpl _value, $Res Function(_$FavorisImpl) _then)
      : super(_value, _then);

  /// Create a copy of Favoris
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? produits = freezed,
  }) {
    return _then(_$FavorisImpl(
      produits: freezed == produits
          ? _value._produits
          : produits // ignore: cast_nullable_to_non_nullable
              as List<Produit>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavorisImpl extends _Favoris with DiagnosticableTreeMixin {
  const _$FavorisImpl({final List<Produit>? produits})
      : _produits = produits,
        super._();

  factory _$FavorisImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavorisImplFromJson(json);

  final List<Produit>? _produits;
  @override
  List<Produit>? get produits {
    final value = _produits;
    if (value == null) return null;
    if (_produits is EqualUnmodifiableListView) return _produits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Favoris(produits: $produits)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Favoris'))
      ..add(DiagnosticsProperty('produits', produits));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavorisImpl &&
            const DeepCollectionEquality().equals(other._produits, _produits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_produits));

  /// Create a copy of Favoris
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavorisImplCopyWith<_$FavorisImpl> get copyWith =>
      __$$FavorisImplCopyWithImpl<_$FavorisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavorisImplToJson(
      this,
    );
  }
}

abstract class _Favoris extends Favoris {
  const factory _Favoris({final List<Produit>? produits}) = _$FavorisImpl;
  const _Favoris._() : super._();

  factory _Favoris.fromJson(Map<String, dynamic> json) = _$FavorisImpl.fromJson;

  @override
  List<Produit>? get produits;

  /// Create a copy of Favoris
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavorisImplCopyWith<_$FavorisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
