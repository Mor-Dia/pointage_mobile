// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professeur_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Professeur _$ProfesseurFromJson(Map<String, dynamic> json) {
  return _Professeur.fromJson(json);
}

/// @nodoc
mixin _$Professeur {
  int? get id => throw _privateConstructorUsedError;
  UserFromApi? get user => throw _privateConstructorUsedError;

  /// Serializes this Professeur to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfesseurCopyWith<Professeur> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfesseurCopyWith<$Res> {
  factory $ProfesseurCopyWith(
          Professeur value, $Res Function(Professeur) then) =
      _$ProfesseurCopyWithImpl<$Res, Professeur>;
  @useResult
  $Res call({int? id, UserFromApi? user});

  $UserFromApiCopyWith<$Res>? get user;
}

/// @nodoc
class _$ProfesseurCopyWithImpl<$Res, $Val extends Professeur>
    implements $ProfesseurCopyWith<$Res> {
  _$ProfesseurCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserFromApi?,
    ) as $Val);
  }

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserFromApiCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserFromApiCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfesseurImplCopyWith<$Res>
    implements $ProfesseurCopyWith<$Res> {
  factory _$$ProfesseurImplCopyWith(
          _$ProfesseurImpl value, $Res Function(_$ProfesseurImpl) then) =
      __$$ProfesseurImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, UserFromApi? user});

  @override
  $UserFromApiCopyWith<$Res>? get user;
}

/// @nodoc
class __$$ProfesseurImplCopyWithImpl<$Res>
    extends _$ProfesseurCopyWithImpl<$Res, _$ProfesseurImpl>
    implements _$$ProfesseurImplCopyWith<$Res> {
  __$$ProfesseurImplCopyWithImpl(
      _$ProfesseurImpl _value, $Res Function(_$ProfesseurImpl) _then)
      : super(_value, _then);

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
  }) {
    return _then(_$ProfesseurImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserFromApi?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfesseurImpl extends _Professeur with DiagnosticableTreeMixin {
  const _$ProfesseurImpl({this.id, this.user}) : super._();

  factory _$ProfesseurImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfesseurImplFromJson(json);

  @override
  final int? id;
  @override
  final UserFromApi? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Professeur(id: $id, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Professeur'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfesseurImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user);

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfesseurImplCopyWith<_$ProfesseurImpl> get copyWith =>
      __$$ProfesseurImplCopyWithImpl<_$ProfesseurImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfesseurImplToJson(
      this,
    );
  }
}

abstract class _Professeur extends Professeur {
  const factory _Professeur({final int? id, final UserFromApi? user}) =
      _$ProfesseurImpl;
  const _Professeur._() : super._();

  factory _Professeur.fromJson(Map<String, dynamic> json) =
      _$ProfesseurImpl.fromJson;

  @override
  int? get id;
  @override
  UserFromApi? get user;

  /// Create a copy of Professeur
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfesseurImplCopyWith<_$ProfesseurImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
