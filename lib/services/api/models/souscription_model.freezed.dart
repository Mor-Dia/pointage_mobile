// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'souscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Souscription _$SouscriptionFromJson(Map<String, dynamic> json) {
  return _Souscription.fromJson(json);
}

/// @nodoc
mixin _$Souscription {
  int? get id => throw _privateConstructorUsedError;
  UserFromApi? get client => throw _privateConstructorUsedError;

  /// Serializes this Souscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SouscriptionCopyWith<Souscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SouscriptionCopyWith<$Res> {
  factory $SouscriptionCopyWith(
          Souscription value, $Res Function(Souscription) then) =
      _$SouscriptionCopyWithImpl<$Res, Souscription>;
  @useResult
  $Res call({int? id, UserFromApi? client});

  $UserFromApiCopyWith<$Res>? get client;
}

/// @nodoc
class _$SouscriptionCopyWithImpl<$Res, $Val extends Souscription>
    implements $SouscriptionCopyWith<$Res> {
  _$SouscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? client = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserFromApi?,
    ) as $Val);
  }

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserFromApiCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserFromApiCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SouscriptionImplCopyWith<$Res>
    implements $SouscriptionCopyWith<$Res> {
  factory _$$SouscriptionImplCopyWith(
          _$SouscriptionImpl value, $Res Function(_$SouscriptionImpl) then) =
      __$$SouscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, UserFromApi? client});

  @override
  $UserFromApiCopyWith<$Res>? get client;
}

/// @nodoc
class __$$SouscriptionImplCopyWithImpl<$Res>
    extends _$SouscriptionCopyWithImpl<$Res, _$SouscriptionImpl>
    implements _$$SouscriptionImplCopyWith<$Res> {
  __$$SouscriptionImplCopyWithImpl(
      _$SouscriptionImpl _value, $Res Function(_$SouscriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? client = freezed,
  }) {
    return _then(_$SouscriptionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as UserFromApi?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SouscriptionImpl extends _Souscription with DiagnosticableTreeMixin {
  const _$SouscriptionImpl({this.id, this.client}) : super._();

  factory _$SouscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SouscriptionImplFromJson(json);

  @override
  final int? id;
  @override
  final UserFromApi? client;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Souscription(id: $id, client: $client)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Souscription'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('client', client));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SouscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.client, client) || other.client == client));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, client);

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SouscriptionImplCopyWith<_$SouscriptionImpl> get copyWith =>
      __$$SouscriptionImplCopyWithImpl<_$SouscriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SouscriptionImplToJson(
      this,
    );
  }
}

abstract class _Souscription extends Souscription {
  const factory _Souscription({final int? id, final UserFromApi? client}) =
      _$SouscriptionImpl;
  const _Souscription._() : super._();

  factory _Souscription.fromJson(Map<String, dynamic> json) =
      _$SouscriptionImpl.fromJson;

  @override
  int? get id;
  @override
  UserFromApi? get client;

  /// Create a copy of Souscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SouscriptionImplCopyWith<_$SouscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
