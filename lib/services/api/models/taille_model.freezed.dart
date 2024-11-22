// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taille_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaillProperties _$TaillPropertiesFromJson(Map<String, dynamic> json) {
  return _TaillProperties.fromJson(json);
}

/// @nodoc
mixin _$TaillProperties {
  int get id => throw _privateConstructorUsedError;
  String get designation => throw _privateConstructorUsedError;
  String get abreviation => throw _privateConstructorUsedError;

  /// Serializes this TaillProperties to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaillProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaillPropertiesCopyWith<TaillProperties> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaillPropertiesCopyWith<$Res> {
  factory $TaillPropertiesCopyWith(
          TaillProperties value, $Res Function(TaillProperties) then) =
      _$TaillPropertiesCopyWithImpl<$Res, TaillProperties>;
  @useResult
  $Res call({int id, String designation, String abreviation});
}

/// @nodoc
class _$TaillPropertiesCopyWithImpl<$Res, $Val extends TaillProperties>
    implements $TaillPropertiesCopyWith<$Res> {
  _$TaillPropertiesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaillProperties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? designation = null,
    Object? abreviation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      designation: null == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String,
      abreviation: null == abreviation
          ? _value.abreviation
          : abreviation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaillPropertiesImplCopyWith<$Res>
    implements $TaillPropertiesCopyWith<$Res> {
  factory _$$TaillPropertiesImplCopyWith(_$TaillPropertiesImpl value,
          $Res Function(_$TaillPropertiesImpl) then) =
      __$$TaillPropertiesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String designation, String abreviation});
}

/// @nodoc
class __$$TaillPropertiesImplCopyWithImpl<$Res>
    extends _$TaillPropertiesCopyWithImpl<$Res, _$TaillPropertiesImpl>
    implements _$$TaillPropertiesImplCopyWith<$Res> {
  __$$TaillPropertiesImplCopyWithImpl(
      _$TaillPropertiesImpl _value, $Res Function(_$TaillPropertiesImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaillProperties
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? designation = null,
    Object? abreviation = null,
  }) {
    return _then(_$TaillPropertiesImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      designation: null == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String,
      abreviation: null == abreviation
          ? _value.abreviation
          : abreviation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaillPropertiesImpl implements _TaillProperties {
  const _$TaillPropertiesImpl(
      {required this.id, required this.designation, required this.abreviation});

  factory _$TaillPropertiesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaillPropertiesImplFromJson(json);

  @override
  final int id;
  @override
  final String designation;
  @override
  final String abreviation;

  @override
  String toString() {
    return 'TaillProperties(id: $id, designation: $designation, abreviation: $abreviation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaillPropertiesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.abreviation, abreviation) ||
                other.abreviation == abreviation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation, abreviation);

  /// Create a copy of TaillProperties
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaillPropertiesImplCopyWith<_$TaillPropertiesImpl> get copyWith =>
      __$$TaillPropertiesImplCopyWithImpl<_$TaillPropertiesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaillPropertiesImplToJson(
      this,
    );
  }
}

abstract class _TaillProperties implements TaillProperties {
  const factory _TaillProperties(
      {required final int id,
      required final String designation,
      required final String abreviation}) = _$TaillPropertiesImpl;

  factory _TaillProperties.fromJson(Map<String, dynamic> json) =
      _$TaillPropertiesImpl.fromJson;

  @override
  int get id;
  @override
  String get designation;
  @override
  String get abreviation;

  /// Create a copy of TaillProperties
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaillPropertiesImplCopyWith<_$TaillPropertiesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Taille _$TailleFromJson(Map<String, dynamic> json) {
  return _Taille.fromJson(json);
}

/// @nodoc
mixin _$Taille {
  int get id => throw _privateConstructorUsedError;
  int get taille_id => throw _privateConstructorUsedError;
  TaillProperties get taille => throw _privateConstructorUsedError;

  /// Serializes this Taille to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TailleCopyWith<Taille> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TailleCopyWith<$Res> {
  factory $TailleCopyWith(Taille value, $Res Function(Taille) then) =
      _$TailleCopyWithImpl<$Res, Taille>;
  @useResult
  $Res call({int id, int taille_id, TaillProperties taille});

  $TaillPropertiesCopyWith<$Res> get taille;
}

/// @nodoc
class _$TailleCopyWithImpl<$Res, $Val extends Taille>
    implements $TailleCopyWith<$Res> {
  _$TailleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taille_id = null,
    Object? taille = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      taille_id: null == taille_id
          ? _value.taille_id
          : taille_id // ignore: cast_nullable_to_non_nullable
              as int,
      taille: null == taille
          ? _value.taille
          : taille // ignore: cast_nullable_to_non_nullable
              as TaillProperties,
    ) as $Val);
  }

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaillPropertiesCopyWith<$Res> get taille {
    return $TaillPropertiesCopyWith<$Res>(_value.taille, (value) {
      return _then(_value.copyWith(taille: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TailleImplCopyWith<$Res> implements $TailleCopyWith<$Res> {
  factory _$$TailleImplCopyWith(
          _$TailleImpl value, $Res Function(_$TailleImpl) then) =
      __$$TailleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int taille_id, TaillProperties taille});

  @override
  $TaillPropertiesCopyWith<$Res> get taille;
}

/// @nodoc
class __$$TailleImplCopyWithImpl<$Res>
    extends _$TailleCopyWithImpl<$Res, _$TailleImpl>
    implements _$$TailleImplCopyWith<$Res> {
  __$$TailleImplCopyWithImpl(
      _$TailleImpl _value, $Res Function(_$TailleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taille_id = null,
    Object? taille = null,
  }) {
    return _then(_$TailleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      taille_id: null == taille_id
          ? _value.taille_id
          : taille_id // ignore: cast_nullable_to_non_nullable
              as int,
      taille: null == taille
          ? _value.taille
          : taille // ignore: cast_nullable_to_non_nullable
              as TaillProperties,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TailleImpl implements _Taille {
  const _$TailleImpl(
      {required this.id, required this.taille_id, required this.taille});

  factory _$TailleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TailleImplFromJson(json);

  @override
  final int id;
  @override
  final int taille_id;
  @override
  final TaillProperties taille;

  @override
  String toString() {
    return 'Taille(id: $id, taille_id: $taille_id, taille: $taille)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TailleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taille_id, taille_id) ||
                other.taille_id == taille_id) &&
            (identical(other.taille, taille) || other.taille == taille));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, taille_id, taille);

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TailleImplCopyWith<_$TailleImpl> get copyWith =>
      __$$TailleImplCopyWithImpl<_$TailleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TailleImplToJson(
      this,
    );
  }
}

abstract class _Taille implements Taille {
  const factory _Taille(
      {required final int id,
      required final int taille_id,
      required final TaillProperties taille}) = _$TailleImpl;

  factory _Taille.fromJson(Map<String, dynamic> json) = _$TailleImpl.fromJson;

  @override
  int get id;
  @override
  int get taille_id;
  @override
  TaillProperties get taille;

  /// Create a copy of Taille
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TailleImplCopyWith<_$TailleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
