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
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr => throw _privateConstructorUsedError;

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
      @JsonKey(name: "created_at_fr") String? createdAtFr});
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
    Object? createdAtFr = freezed,
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
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
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
      @JsonKey(name: "created_at_fr") String? createdAtFr});
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
    Object? createdAtFr = freezed,
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
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
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
      @JsonKey(name: "created_at_fr") this.createdAtFr})
      : super._();

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
  @JsonKey(name: "created_at_fr")
  final String? createdAtFr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Commande(id: $id, total: $total, displaycoloretat: $displaycoloretat, displayetat: $displayetat, createdAtFr: $createdAtFr)';
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
      ..add(DiagnosticsProperty('createdAtFr', createdAtFr));
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
            (identical(other.createdAtFr, createdAtFr) ||
                other.createdAtFr == createdAtFr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(total),
      displaycoloretat,
      displayetat,
      createdAtFr);

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
          @JsonKey(name: "created_at_fr") final String? createdAtFr}) =
      _$CommandeImpl;
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
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr;

  /// Create a copy of Commande
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommandeImplCopyWith<_$CommandeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
