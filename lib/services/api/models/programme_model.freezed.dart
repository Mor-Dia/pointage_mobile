// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Programme _$ProgrammeFromJson(Map<String, dynamic> json) {
  return _Programme.fromJson(json);
}

/// @nodoc
mixin _$Programme {
  int? get id => throw _privateConstructorUsedError;
  String? get displaycoloretat => throw _privateConstructorUsedError;
  String? get displayetat => throw _privateConstructorUsedError;
  @JsonKey(name: "date_fr")
  String? get dateFr => throw _privateConstructorUsedError;
  @JsonKey(name: "heure_debut")
  String? get heureDebut => throw _privateConstructorUsedError;
  @JsonKey(name: "heure_fin")
  String? get heureFin => throw _privateConstructorUsedError;
  @JsonKey(name: "professeur_pratique")
  ProfesseurPratique? get professeurPratique =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "salle_pratique")
  SallePratique? get sallePratique => throw _privateConstructorUsedError;

  /// Serializes this Programme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgrammeCopyWith<Programme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgrammeCopyWith<$Res> {
  factory $ProgrammeCopyWith(Programme value, $Res Function(Programme) then) =
      _$ProgrammeCopyWithImpl<$Res, Programme>;
  @useResult
  $Res call(
      {int? id,
      String? displaycoloretat,
      String? displayetat,
      @JsonKey(name: "date_fr") String? dateFr,
      @JsonKey(name: "heure_debut") String? heureDebut,
      @JsonKey(name: "heure_fin") String? heureFin,
      @JsonKey(name: "professeur_pratique")
      ProfesseurPratique? professeurPratique,
      @JsonKey(name: "salle_pratique") SallePratique? sallePratique});

  $ProfesseurPratiqueCopyWith<$Res>? get professeurPratique;
  $SallePratiqueCopyWith<$Res>? get sallePratique;
}

/// @nodoc
class _$ProgrammeCopyWithImpl<$Res, $Val extends Programme>
    implements $ProgrammeCopyWith<$Res> {
  _$ProgrammeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displaycoloretat = freezed,
    Object? displayetat = freezed,
    Object? dateFr = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? professeurPratique = freezed,
    Object? sallePratique = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFr: freezed == dateFr
          ? _value.dateFr
          : dateFr // ignore: cast_nullable_to_non_nullable
              as String?,
      heureDebut: freezed == heureDebut
          ? _value.heureDebut
          : heureDebut // ignore: cast_nullable_to_non_nullable
              as String?,
      heureFin: freezed == heureFin
          ? _value.heureFin
          : heureFin // ignore: cast_nullable_to_non_nullable
              as String?,
      professeurPratique: freezed == professeurPratique
          ? _value.professeurPratique
          : professeurPratique // ignore: cast_nullable_to_non_nullable
              as ProfesseurPratique?,
      sallePratique: freezed == sallePratique
          ? _value.sallePratique
          : sallePratique // ignore: cast_nullable_to_non_nullable
              as SallePratique?,
    ) as $Val);
  }

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfesseurPratiqueCopyWith<$Res>? get professeurPratique {
    if (_value.professeurPratique == null) {
      return null;
    }

    return $ProfesseurPratiqueCopyWith<$Res>(_value.professeurPratique!,
        (value) {
      return _then(_value.copyWith(professeurPratique: value) as $Val);
    });
  }

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SallePratiqueCopyWith<$Res>? get sallePratique {
    if (_value.sallePratique == null) {
      return null;
    }

    return $SallePratiqueCopyWith<$Res>(_value.sallePratique!, (value) {
      return _then(_value.copyWith(sallePratique: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProgrammeImplCopyWith<$Res>
    implements $ProgrammeCopyWith<$Res> {
  factory _$$ProgrammeImplCopyWith(
          _$ProgrammeImpl value, $Res Function(_$ProgrammeImpl) then) =
      __$$ProgrammeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? displaycoloretat,
      String? displayetat,
      @JsonKey(name: "date_fr") String? dateFr,
      @JsonKey(name: "heure_debut") String? heureDebut,
      @JsonKey(name: "heure_fin") String? heureFin,
      @JsonKey(name: "professeur_pratique")
      ProfesseurPratique? professeurPratique,
      @JsonKey(name: "salle_pratique") SallePratique? sallePratique});

  @override
  $ProfesseurPratiqueCopyWith<$Res>? get professeurPratique;
  @override
  $SallePratiqueCopyWith<$Res>? get sallePratique;
}

/// @nodoc
class __$$ProgrammeImplCopyWithImpl<$Res>
    extends _$ProgrammeCopyWithImpl<$Res, _$ProgrammeImpl>
    implements _$$ProgrammeImplCopyWith<$Res> {
  __$$ProgrammeImplCopyWithImpl(
      _$ProgrammeImpl _value, $Res Function(_$ProgrammeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displaycoloretat = freezed,
    Object? displayetat = freezed,
    Object? dateFr = freezed,
    Object? heureDebut = freezed,
    Object? heureFin = freezed,
    Object? professeurPratique = freezed,
    Object? sallePratique = freezed,
  }) {
    return _then(_$ProgrammeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      dateFr: freezed == dateFr
          ? _value.dateFr
          : dateFr // ignore: cast_nullable_to_non_nullable
              as String?,
      heureDebut: freezed == heureDebut
          ? _value.heureDebut
          : heureDebut // ignore: cast_nullable_to_non_nullable
              as String?,
      heureFin: freezed == heureFin
          ? _value.heureFin
          : heureFin // ignore: cast_nullable_to_non_nullable
              as String?,
      professeurPratique: freezed == professeurPratique
          ? _value.professeurPratique
          : professeurPratique // ignore: cast_nullable_to_non_nullable
              as ProfesseurPratique?,
      sallePratique: freezed == sallePratique
          ? _value.sallePratique
          : sallePratique // ignore: cast_nullable_to_non_nullable
              as SallePratique?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgrammeImpl extends _Programme with DiagnosticableTreeMixin {
  const _$ProgrammeImpl(
      {this.id,
      this.displaycoloretat,
      this.displayetat,
      @JsonKey(name: "date_fr") this.dateFr,
      @JsonKey(name: "heure_debut") this.heureDebut,
      @JsonKey(name: "heure_fin") this.heureFin,
      @JsonKey(name: "professeur_pratique") this.professeurPratique,
      @JsonKey(name: "salle_pratique") this.sallePratique})
      : super._();

  factory _$ProgrammeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgrammeImplFromJson(json);

  @override
  final int? id;
  @override
  final String? displaycoloretat;
  @override
  final String? displayetat;
  @override
  @JsonKey(name: "date_fr")
  final String? dateFr;
  @override
  @JsonKey(name: "heure_debut")
  final String? heureDebut;
  @override
  @JsonKey(name: "heure_fin")
  final String? heureFin;
  @override
  @JsonKey(name: "professeur_pratique")
  final ProfesseurPratique? professeurPratique;
  @override
  @JsonKey(name: "salle_pratique")
  final SallePratique? sallePratique;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Programme(id: $id, displaycoloretat: $displaycoloretat, displayetat: $displayetat, dateFr: $dateFr, heureDebut: $heureDebut, heureFin: $heureFin, professeurPratique: $professeurPratique, sallePratique: $sallePratique)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Programme'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('displaycoloretat', displaycoloretat))
      ..add(DiagnosticsProperty('displayetat', displayetat))
      ..add(DiagnosticsProperty('dateFr', dateFr))
      ..add(DiagnosticsProperty('heureDebut', heureDebut))
      ..add(DiagnosticsProperty('heureFin', heureFin))
      ..add(DiagnosticsProperty('professeurPratique', professeurPratique))
      ..add(DiagnosticsProperty('sallePratique', sallePratique));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgrammeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displaycoloretat, displaycoloretat) ||
                other.displaycoloretat == displaycoloretat) &&
            (identical(other.displayetat, displayetat) ||
                other.displayetat == displayetat) &&
            (identical(other.dateFr, dateFr) || other.dateFr == dateFr) &&
            (identical(other.heureDebut, heureDebut) ||
                other.heureDebut == heureDebut) &&
            (identical(other.heureFin, heureFin) ||
                other.heureFin == heureFin) &&
            (identical(other.professeurPratique, professeurPratique) ||
                other.professeurPratique == professeurPratique) &&
            (identical(other.sallePratique, sallePratique) ||
                other.sallePratique == sallePratique));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displaycoloretat,
      displayetat,
      dateFr,
      heureDebut,
      heureFin,
      professeurPratique,
      sallePratique);

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgrammeImplCopyWith<_$ProgrammeImpl> get copyWith =>
      __$$ProgrammeImplCopyWithImpl<_$ProgrammeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgrammeImplToJson(
      this,
    );
  }
}

abstract class _Programme extends Programme {
  const factory _Programme(
      {final int? id,
      final String? displaycoloretat,
      final String? displayetat,
      @JsonKey(name: "date_fr") final String? dateFr,
      @JsonKey(name: "heure_debut") final String? heureDebut,
      @JsonKey(name: "heure_fin") final String? heureFin,
      @JsonKey(name: "professeur_pratique")
      final ProfesseurPratique? professeurPratique,
      @JsonKey(name: "salle_pratique")
      final SallePratique? sallePratique}) = _$ProgrammeImpl;
  const _Programme._() : super._();

  factory _Programme.fromJson(Map<String, dynamic> json) =
      _$ProgrammeImpl.fromJson;

  @override
  int? get id;
  @override
  String? get displaycoloretat;
  @override
  String? get displayetat;
  @override
  @JsonKey(name: "date_fr")
  String? get dateFr;
  @override
  @JsonKey(name: "heure_debut")
  String? get heureDebut;
  @override
  @JsonKey(name: "heure_fin")
  String? get heureFin;
  @override
  @JsonKey(name: "professeur_pratique")
  ProfesseurPratique? get professeurPratique;
  @override
  @JsonKey(name: "salle_pratique")
  SallePratique? get sallePratique;

  /// Create a copy of Programme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgrammeImplCopyWith<_$ProgrammeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
