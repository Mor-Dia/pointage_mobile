// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salle_pratique_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SallePratique _$SallePratiqueFromJson(Map<String, dynamic> json) {
  return _SallePratique.fromJson(json);
}

/// @nodoc
mixin _$SallePratique {
  int? get id => throw _privateConstructorUsedError;
  Salle? get salle => throw _privateConstructorUsedError;
  Pratique? get pratique => throw _privateConstructorUsedError;

  /// Serializes this SallePratique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SallePratiqueCopyWith<SallePratique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SallePratiqueCopyWith<$Res> {
  factory $SallePratiqueCopyWith(
          SallePratique value, $Res Function(SallePratique) then) =
      _$SallePratiqueCopyWithImpl<$Res, SallePratique>;
  @useResult
  $Res call({int? id, Salle? salle, Pratique? pratique});

  $SalleCopyWith<$Res>? get salle;
  $PratiqueCopyWith<$Res>? get pratique;
}

/// @nodoc
class _$SallePratiqueCopyWithImpl<$Res, $Val extends SallePratique>
    implements $SallePratiqueCopyWith<$Res> {
  _$SallePratiqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? salle = freezed,
    Object? pratique = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      salle: freezed == salle
          ? _value.salle
          : salle // ignore: cast_nullable_to_non_nullable
              as Salle?,
      pratique: freezed == pratique
          ? _value.pratique
          : pratique // ignore: cast_nullable_to_non_nullable
              as Pratique?,
    ) as $Val);
  }

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalleCopyWith<$Res>? get salle {
    if (_value.salle == null) {
      return null;
    }

    return $SalleCopyWith<$Res>(_value.salle!, (value) {
      return _then(_value.copyWith(salle: value) as $Val);
    });
  }

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PratiqueCopyWith<$Res>? get pratique {
    if (_value.pratique == null) {
      return null;
    }

    return $PratiqueCopyWith<$Res>(_value.pratique!, (value) {
      return _then(_value.copyWith(pratique: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SallePratiqueImplCopyWith<$Res>
    implements $SallePratiqueCopyWith<$Res> {
  factory _$$SallePratiqueImplCopyWith(
          _$SallePratiqueImpl value, $Res Function(_$SallePratiqueImpl) then) =
      __$$SallePratiqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, Salle? salle, Pratique? pratique});

  @override
  $SalleCopyWith<$Res>? get salle;
  @override
  $PratiqueCopyWith<$Res>? get pratique;
}

/// @nodoc
class __$$SallePratiqueImplCopyWithImpl<$Res>
    extends _$SallePratiqueCopyWithImpl<$Res, _$SallePratiqueImpl>
    implements _$$SallePratiqueImplCopyWith<$Res> {
  __$$SallePratiqueImplCopyWithImpl(
      _$SallePratiqueImpl _value, $Res Function(_$SallePratiqueImpl) _then)
      : super(_value, _then);

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? salle = freezed,
    Object? pratique = freezed,
  }) {
    return _then(_$SallePratiqueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      salle: freezed == salle
          ? _value.salle
          : salle // ignore: cast_nullable_to_non_nullable
              as Salle?,
      pratique: freezed == pratique
          ? _value.pratique
          : pratique // ignore: cast_nullable_to_non_nullable
              as Pratique?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SallePratiqueImpl extends _SallePratique with DiagnosticableTreeMixin {
  const _$SallePratiqueImpl({this.id, this.salle, this.pratique}) : super._();

  factory _$SallePratiqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$SallePratiqueImplFromJson(json);

  @override
  final int? id;
  @override
  final Salle? salle;
  @override
  final Pratique? pratique;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SallePratique(id: $id, salle: $salle, pratique: $pratique)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SallePratique'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('salle', salle))
      ..add(DiagnosticsProperty('pratique', pratique));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SallePratiqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.salle, salle) || other.salle == salle) &&
            (identical(other.pratique, pratique) ||
                other.pratique == pratique));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, salle, pratique);

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SallePratiqueImplCopyWith<_$SallePratiqueImpl> get copyWith =>
      __$$SallePratiqueImplCopyWithImpl<_$SallePratiqueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SallePratiqueImplToJson(
      this,
    );
  }
}

abstract class _SallePratique extends SallePratique {
  const factory _SallePratique(
      {final int? id,
      final Salle? salle,
      final Pratique? pratique}) = _$SallePratiqueImpl;
  const _SallePratique._() : super._();

  factory _SallePratique.fromJson(Map<String, dynamic> json) =
      _$SallePratiqueImpl.fromJson;

  @override
  int? get id;
  @override
  Salle? get salle;
  @override
  Pratique? get pratique;

  /// Create a copy of SallePratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SallePratiqueImplCopyWith<_$SallePratiqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
