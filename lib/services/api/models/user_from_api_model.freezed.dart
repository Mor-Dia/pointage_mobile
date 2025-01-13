// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_from_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserFromApi _$UserFromApiFromJson(Map<String, dynamic> json) {
  return _UserFromApi.fromJson(json);
}

/// @nodoc
mixin _$UserFromApi {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get nom_complet => throw _privateConstructorUsedError;

  /// Serializes this UserFromApi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFromApi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFromApiCopyWith<UserFromApi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFromApiCopyWith<$Res> {
  factory $UserFromApiCopyWith(
          UserFromApi value, $Res Function(UserFromApi) then) =
      _$UserFromApiCopyWithImpl<$Res, UserFromApi>;
  @useResult
  $Res call({int? id, String? name, String? nom_complet});
}

/// @nodoc
class _$UserFromApiCopyWithImpl<$Res, $Val extends UserFromApi>
    implements $UserFromApiCopyWith<$Res> {
  _$UserFromApiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFromApi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nom_complet = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nom_complet: freezed == nom_complet
          ? _value.nom_complet
          : nom_complet // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFromApiImplCopyWith<$Res>
    implements $UserFromApiCopyWith<$Res> {
  factory _$$UserFromApiImplCopyWith(
          _$UserFromApiImpl value, $Res Function(_$UserFromApiImpl) then) =
      __$$UserFromApiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? nom_complet});
}

/// @nodoc
class __$$UserFromApiImplCopyWithImpl<$Res>
    extends _$UserFromApiCopyWithImpl<$Res, _$UserFromApiImpl>
    implements _$$UserFromApiImplCopyWith<$Res> {
  __$$UserFromApiImplCopyWithImpl(
      _$UserFromApiImpl _value, $Res Function(_$UserFromApiImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFromApi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nom_complet = freezed,
  }) {
    return _then(_$UserFromApiImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nom_complet: freezed == nom_complet
          ? _value.nom_complet
          : nom_complet // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserFromApiImpl extends _UserFromApi with DiagnosticableTreeMixin {
  const _$UserFromApiImpl({this.id, this.name, this.nom_complet}) : super._();

  factory _$UserFromApiImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFromApiImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? nom_complet;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserFromApi(id: $id, name: $name, nom_complet: $nom_complet)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserFromApi'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('nom_complet', nom_complet));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFromApiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nom_complet, nom_complet) ||
                other.nom_complet == nom_complet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nom_complet);

  /// Create a copy of UserFromApi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFromApiImplCopyWith<_$UserFromApiImpl> get copyWith =>
      __$$UserFromApiImplCopyWithImpl<_$UserFromApiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFromApiImplToJson(
      this,
    );
  }
}

abstract class _UserFromApi extends UserFromApi {
  const factory _UserFromApi(
      {final int? id,
      final String? name,
      final String? nom_complet}) = _$UserFromApiImpl;
  const _UserFromApi._() : super._();

  factory _UserFromApi.fromJson(Map<String, dynamic> json) =
      _$UserFromApiImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get nom_complet;

  /// Create a copy of UserFromApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFromApiImplCopyWith<_$UserFromApiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
