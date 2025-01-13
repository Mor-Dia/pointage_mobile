// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pratique_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pratique _$PratiqueFromJson(Map<String, dynamic> json) {
  return _Pratique.fromJson(json);
}

/// @nodoc
mixin _$Pratique {
  int? get id => throw _privateConstructorUsedError;
  bool? get favoris => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "description_en")
  String? get descriptionEn => throw _privateConstructorUsedError;
  @JsonKey(name: "type_pratique")
  TypePratique? get typePratique => throw _privateConstructorUsedError;
  dynamic get ca_souscription => throw _privateConstructorUsedError;

  /// Serializes this Pratique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PratiqueCopyWith<Pratique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PratiqueCopyWith<$Res> {
  factory $PratiqueCopyWith(Pratique value, $Res Function(Pratique) then) =
      _$PratiqueCopyWithImpl<$Res, Pratique>;
  @useResult
  $Res call(
      {int? id,
      bool? favoris,
      String? designation,
      String? image,
      String? description,
      @JsonKey(name: "description_en") String? descriptionEn,
      @JsonKey(name: "type_pratique") TypePratique? typePratique,
      dynamic ca_souscription});

  $TypePratiqueCopyWith<$Res>? get typePratique;
}

/// @nodoc
class _$PratiqueCopyWithImpl<$Res, $Val extends Pratique>
    implements $PratiqueCopyWith<$Res> {
  _$PratiqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? favoris = freezed,
    Object? designation = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? typePratique = freezed,
    Object? ca_souscription = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      favoris: freezed == favoris
          ? _value.favoris
          : favoris // ignore: cast_nullable_to_non_nullable
              as bool?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      typePratique: freezed == typePratique
          ? _value.typePratique
          : typePratique // ignore: cast_nullable_to_non_nullable
              as TypePratique?,
      ca_souscription: freezed == ca_souscription
          ? _value.ca_souscription
          : ca_souscription // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypePratiqueCopyWith<$Res>? get typePratique {
    if (_value.typePratique == null) {
      return null;
    }

    return $TypePratiqueCopyWith<$Res>(_value.typePratique!, (value) {
      return _then(_value.copyWith(typePratique: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PratiqueImplCopyWith<$Res>
    implements $PratiqueCopyWith<$Res> {
  factory _$$PratiqueImplCopyWith(
          _$PratiqueImpl value, $Res Function(_$PratiqueImpl) then) =
      __$$PratiqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      bool? favoris,
      String? designation,
      String? image,
      String? description,
      @JsonKey(name: "description_en") String? descriptionEn,
      @JsonKey(name: "type_pratique") TypePratique? typePratique,
      dynamic ca_souscription});

  @override
  $TypePratiqueCopyWith<$Res>? get typePratique;
}

/// @nodoc
class __$$PratiqueImplCopyWithImpl<$Res>
    extends _$PratiqueCopyWithImpl<$Res, _$PratiqueImpl>
    implements _$$PratiqueImplCopyWith<$Res> {
  __$$PratiqueImplCopyWithImpl(
      _$PratiqueImpl _value, $Res Function(_$PratiqueImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? favoris = freezed,
    Object? designation = freezed,
    Object? image = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? typePratique = freezed,
    Object? ca_souscription = freezed,
  }) {
    return _then(_$PratiqueImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      favoris: freezed == favoris
          ? _value.favoris
          : favoris // ignore: cast_nullable_to_non_nullable
              as bool?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionEn: freezed == descriptionEn
          ? _value.descriptionEn
          : descriptionEn // ignore: cast_nullable_to_non_nullable
              as String?,
      typePratique: freezed == typePratique
          ? _value.typePratique
          : typePratique // ignore: cast_nullable_to_non_nullable
              as TypePratique?,
      ca_souscription: freezed == ca_souscription
          ? _value.ca_souscription
          : ca_souscription // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PratiqueImpl extends _Pratique with DiagnosticableTreeMixin {
  const _$PratiqueImpl(
      {this.id,
      this.favoris,
      this.designation,
      this.image,
      this.description,
      @JsonKey(name: "description_en") this.descriptionEn,
      @JsonKey(name: "type_pratique") this.typePratique,
      this.ca_souscription})
      : super._();

  factory _$PratiqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$PratiqueImplFromJson(json);

  @override
  final int? id;
  @override
  final bool? favoris;
  @override
  final String? designation;
  @override
  final String? image;
  @override
  final String? description;
  @override
  @JsonKey(name: "description_en")
  final String? descriptionEn;
  @override
  @JsonKey(name: "type_pratique")
  final TypePratique? typePratique;
  @override
  final dynamic ca_souscription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Pratique(id: $id, favoris: $favoris, designation: $designation, image: $image, description: $description, descriptionEn: $descriptionEn, typePratique: $typePratique, ca_souscription: $ca_souscription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Pratique'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('favoris', favoris))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('descriptionEn', descriptionEn))
      ..add(DiagnosticsProperty('typePratique', typePratique))
      ..add(DiagnosticsProperty('ca_souscription', ca_souscription));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PratiqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.favoris, favoris) || other.favoris == favoris) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.typePratique, typePratique) ||
                other.typePratique == typePratique) &&
            const DeepCollectionEquality()
                .equals(other.ca_souscription, ca_souscription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      favoris,
      designation,
      image,
      description,
      descriptionEn,
      typePratique,
      const DeepCollectionEquality().hash(ca_souscription));

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PratiqueImplCopyWith<_$PratiqueImpl> get copyWith =>
      __$$PratiqueImplCopyWithImpl<_$PratiqueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PratiqueImplToJson(
      this,
    );
  }
}

abstract class _Pratique extends Pratique {
  const factory _Pratique(
      {final int? id,
      final bool? favoris,
      final String? designation,
      final String? image,
      final String? description,
      @JsonKey(name: "description_en") final String? descriptionEn,
      @JsonKey(name: "type_pratique") final TypePratique? typePratique,
      final dynamic ca_souscription}) = _$PratiqueImpl;
  const _Pratique._() : super._();

  factory _Pratique.fromJson(Map<String, dynamic> json) =
      _$PratiqueImpl.fromJson;

  @override
  int? get id;
  @override
  bool? get favoris;
  @override
  String? get designation;
  @override
  String? get image;
  @override
  String? get description;
  @override
  @JsonKey(name: "description_en")
  String? get descriptionEn;
  @override
  @JsonKey(name: "type_pratique")
  TypePratique? get typePratique;
  @override
  dynamic get ca_souscription;

  /// Create a copy of Pratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PratiqueImplCopyWith<_$PratiqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
