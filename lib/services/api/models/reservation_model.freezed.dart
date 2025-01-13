// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  int? get id => throw _privateConstructorUsedError;
  String? get displayetat => throw _privateConstructorUsedError;
  String? get displaycoloretat => throw _privateConstructorUsedError;
  @JsonKey(name: "en_attente")
  String? get enAttente => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr => throw _privateConstructorUsedError;
  Programme? get programme => throw _privateConstructorUsedError;
  Souscription? get souscription => throw _privateConstructorUsedError;
  dynamic get ca_souscription => throw _privateConstructorUsedError;

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {int? id,
      String? displayetat,
      String? displaycoloretat,
      @JsonKey(name: "en_attente") String? enAttente,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      Programme? programme,
      Souscription? souscription,
      dynamic ca_souscription});

  $ProgrammeCopyWith<$Res>? get programme;
  $SouscriptionCopyWith<$Res>? get souscription;
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayetat = freezed,
    Object? displaycoloretat = freezed,
    Object? enAttente = freezed,
    Object? createdAtFr = freezed,
    Object? programme = freezed,
    Object? souscription = freezed,
    Object? ca_souscription = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      enAttente: freezed == enAttente
          ? _value.enAttente
          : enAttente // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      programme: freezed == programme
          ? _value.programme
          : programme // ignore: cast_nullable_to_non_nullable
              as Programme?,
      souscription: freezed == souscription
          ? _value.souscription
          : souscription // ignore: cast_nullable_to_non_nullable
              as Souscription?,
      ca_souscription: freezed == ca_souscription
          ? _value.ca_souscription
          : ca_souscription // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgrammeCopyWith<$Res>? get programme {
    if (_value.programme == null) {
      return null;
    }

    return $ProgrammeCopyWith<$Res>(_value.programme!, (value) {
      return _then(_value.copyWith(programme: value) as $Val);
    });
  }

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SouscriptionCopyWith<$Res>? get souscription {
    if (_value.souscription == null) {
      return null;
    }

    return $SouscriptionCopyWith<$Res>(_value.souscription!, (value) {
      return _then(_value.copyWith(souscription: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? displayetat,
      String? displaycoloretat,
      @JsonKey(name: "en_attente") String? enAttente,
      @JsonKey(name: "created_at_fr") String? createdAtFr,
      Programme? programme,
      Souscription? souscription,
      dynamic ca_souscription});

  @override
  $ProgrammeCopyWith<$Res>? get programme;
  @override
  $SouscriptionCopyWith<$Res>? get souscription;
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayetat = freezed,
    Object? displaycoloretat = freezed,
    Object? enAttente = freezed,
    Object? createdAtFr = freezed,
    Object? programme = freezed,
    Object? souscription = freezed,
    Object? ca_souscription = freezed,
  }) {
    return _then(_$ReservationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      displayetat: freezed == displayetat
          ? _value.displayetat
          : displayetat // ignore: cast_nullable_to_non_nullable
              as String?,
      displaycoloretat: freezed == displaycoloretat
          ? _value.displaycoloretat
          : displaycoloretat // ignore: cast_nullable_to_non_nullable
              as String?,
      enAttente: freezed == enAttente
          ? _value.enAttente
          : enAttente // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAtFr: freezed == createdAtFr
          ? _value.createdAtFr
          : createdAtFr // ignore: cast_nullable_to_non_nullable
              as String?,
      programme: freezed == programme
          ? _value.programme
          : programme // ignore: cast_nullable_to_non_nullable
              as Programme?,
      souscription: freezed == souscription
          ? _value.souscription
          : souscription // ignore: cast_nullable_to_non_nullable
              as Souscription?,
      ca_souscription: freezed == ca_souscription
          ? _value.ca_souscription
          : ca_souscription // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationImpl extends _Reservation with DiagnosticableTreeMixin {
  const _$ReservationImpl(
      {this.id,
      this.displayetat,
      this.displaycoloretat,
      @JsonKey(name: "en_attente") this.enAttente,
      @JsonKey(name: "created_at_fr") this.createdAtFr,
      this.programme,
      this.souscription,
      this.ca_souscription})
      : super._();

  factory _$ReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationImplFromJson(json);

  @override
  final int? id;
  @override
  final String? displayetat;
  @override
  final String? displaycoloretat;
  @override
  @JsonKey(name: "en_attente")
  final String? enAttente;
  @override
  @JsonKey(name: "created_at_fr")
  final String? createdAtFr;
  @override
  final Programme? programme;
  @override
  final Souscription? souscription;
  @override
  final dynamic ca_souscription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Reservation(id: $id, displayetat: $displayetat, displaycoloretat: $displaycoloretat, enAttente: $enAttente, createdAtFr: $createdAtFr, programme: $programme, souscription: $souscription, ca_souscription: $ca_souscription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Reservation'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('displayetat', displayetat))
      ..add(DiagnosticsProperty('displaycoloretat', displaycoloretat))
      ..add(DiagnosticsProperty('enAttente', enAttente))
      ..add(DiagnosticsProperty('createdAtFr', createdAtFr))
      ..add(DiagnosticsProperty('programme', programme))
      ..add(DiagnosticsProperty('souscription', souscription))
      ..add(DiagnosticsProperty('ca_souscription', ca_souscription));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayetat, displayetat) ||
                other.displayetat == displayetat) &&
            (identical(other.displaycoloretat, displaycoloretat) ||
                other.displaycoloretat == displaycoloretat) &&
            (identical(other.enAttente, enAttente) ||
                other.enAttente == enAttente) &&
            (identical(other.createdAtFr, createdAtFr) ||
                other.createdAtFr == createdAtFr) &&
            (identical(other.programme, programme) ||
                other.programme == programme) &&
            (identical(other.souscription, souscription) ||
                other.souscription == souscription) &&
            const DeepCollectionEquality()
                .equals(other.ca_souscription, ca_souscription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayetat,
      displaycoloretat,
      enAttente,
      createdAtFr,
      programme,
      souscription,
      const DeepCollectionEquality().hash(ca_souscription));

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationImplToJson(
      this,
    );
  }
}

abstract class _Reservation extends Reservation {
  const factory _Reservation(
      {final int? id,
      final String? displayetat,
      final String? displaycoloretat,
      @JsonKey(name: "en_attente") final String? enAttente,
      @JsonKey(name: "created_at_fr") final String? createdAtFr,
      final Programme? programme,
      final Souscription? souscription,
      final dynamic ca_souscription}) = _$ReservationImpl;
  const _Reservation._() : super._();

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$ReservationImpl.fromJson;

  @override
  int? get id;
  @override
  String? get displayetat;
  @override
  String? get displaycoloretat;
  @override
  @JsonKey(name: "en_attente")
  String? get enAttente;
  @override
  @JsonKey(name: "created_at_fr")
  String? get createdAtFr;
  @override
  Programme? get programme;
  @override
  Souscription? get souscription;
  @override
  dynamic get ca_souscription;

  /// Create a copy of Reservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
