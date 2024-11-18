// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professeur_pratique_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfesseurPratique _$ProfesseurPratiqueFromJson(Map<String, dynamic> json) {
  return _ProfesseurPratique.fromJson(json);
}

/// @nodoc
mixin _$ProfesseurPratique {
  int? get id => throw _privateConstructorUsedError;
  Professeur? get professeur => throw _privateConstructorUsedError;
  Pratique? get pratique => throw _privateConstructorUsedError;

  /// Serializes this ProfesseurPratique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfesseurPratiqueCopyWith<ProfesseurPratique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfesseurPratiqueCopyWith<$Res> {
  factory $ProfesseurPratiqueCopyWith(
          ProfesseurPratique value, $Res Function(ProfesseurPratique) then) =
      _$ProfesseurPratiqueCopyWithImpl<$Res, ProfesseurPratique>;
  @useResult
  $Res call({int? id, Professeur? professeur, Pratique? pratique});

  $ProfesseurCopyWith<$Res>? get professeur;
  $PratiqueCopyWith<$Res>? get pratique;
}

/// @nodoc
class _$ProfesseurPratiqueCopyWithImpl<$Res, $Val extends ProfesseurPratique>
    implements $ProfesseurPratiqueCopyWith<$Res> {
  _$ProfesseurPratiqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? professeur = freezed,
    Object? pratique = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      professeur: freezed == professeur
          ? _value.professeur
          : professeur // ignore: cast_nullable_to_non_nullable
              as Professeur?,
      pratique: freezed == pratique
          ? _value.pratique
          : pratique // ignore: cast_nullable_to_non_nullable
              as Pratique?,
    ) as $Val);
  }

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfesseurCopyWith<$Res>? get professeur {
    if (_value.professeur == null) {
      return null;
    }

    return $ProfesseurCopyWith<$Res>(_value.professeur!, (value) {
      return _then(_value.copyWith(professeur: value) as $Val);
    });
  }

  /// Create a copy of ProfesseurPratique
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
abstract class _$$ProfesseurPratiqueImplCopyWith<$Res>
    implements $ProfesseurPratiqueCopyWith<$Res> {
  factory _$$ProfesseurPratiqueImplCopyWith(_$ProfesseurPratiqueImpl value,
          $Res Function(_$ProfesseurPratiqueImpl) then) =
      __$$ProfesseurPratiqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, Professeur? professeur, Pratique? pratique});

  @override
  $ProfesseurCopyWith<$Res>? get professeur;
  @override
  $PratiqueCopyWith<$Res>? get pratique;
}

/// @nodoc
class __$$ProfesseurPratiqueImplCopyWithImpl<$Res>
    extends _$ProfesseurPratiqueCopyWithImpl<$Res, _$ProfesseurPratiqueImpl>
    implements _$$ProfesseurPratiqueImplCopyWith<$Res> {
  __$$ProfesseurPratiqueImplCopyWithImpl(_$ProfesseurPratiqueImpl _value,
      $Res Function(_$ProfesseurPratiqueImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? professeur = freezed,
    Object? pratique = freezed,
  }) {
    return _then(_$ProfesseurPratiqueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      professeur: freezed == professeur
          ? _value.professeur
          : professeur // ignore: cast_nullable_to_non_nullable
              as Professeur?,
      pratique: freezed == pratique
          ? _value.pratique
          : pratique // ignore: cast_nullable_to_non_nullable
              as Pratique?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfesseurPratiqueImpl extends _ProfesseurPratique
    with DiagnosticableTreeMixin {
  const _$ProfesseurPratiqueImpl({this.id, this.professeur, this.pratique})
      : super._();

  factory _$ProfesseurPratiqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfesseurPratiqueImplFromJson(json);

  @override
  final int? id;
  @override
  final Professeur? professeur;
  @override
  final Pratique? pratique;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfesseurPratique(id: $id, professeur: $professeur, pratique: $pratique)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfesseurPratique'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('professeur', professeur))
      ..add(DiagnosticsProperty('pratique', pratique));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfesseurPratiqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.professeur, professeur) ||
                other.professeur == professeur) &&
            (identical(other.pratique, pratique) ||
                other.pratique == pratique));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, professeur, pratique);

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfesseurPratiqueImplCopyWith<_$ProfesseurPratiqueImpl> get copyWith =>
      __$$ProfesseurPratiqueImplCopyWithImpl<_$ProfesseurPratiqueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfesseurPratiqueImplToJson(
      this,
    );
  }
}

abstract class _ProfesseurPratique extends ProfesseurPratique {
  const factory _ProfesseurPratique(
      {final int? id,
      final Professeur? professeur,
      final Pratique? pratique}) = _$ProfesseurPratiqueImpl;
  const _ProfesseurPratique._() : super._();

  factory _ProfesseurPratique.fromJson(Map<String, dynamic> json) =
      _$ProfesseurPratiqueImpl.fromJson;

  @override
  int? get id;
  @override
  Professeur? get professeur;
  @override
  Pratique? get pratique;

  /// Create a copy of ProfesseurPratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfesseurPratiqueImplCopyWith<_$ProfesseurPratiqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
