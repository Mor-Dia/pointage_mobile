// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Salle _$SalleFromJson(Map<String, dynamic> json) {
  return _Salle.fromJson(json);
}

/// @nodoc
mixin _$Salle {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  /// Serializes this Salle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Salle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalleCopyWith<Salle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalleCopyWith<$Res> {
  factory $SalleCopyWith(Salle value, $Res Function(Salle) then) =
      _$SalleCopyWithImpl<$Res, Salle>;
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class _$SalleCopyWithImpl<$Res, $Val extends Salle>
    implements $SalleCopyWith<$Res> {
  _$SalleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Salle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalleImplCopyWith<$Res> implements $SalleCopyWith<$Res> {
  factory _$$SalleImplCopyWith(
          _$SalleImpl value, $Res Function(_$SalleImpl) then) =
      __$$SalleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class __$$SalleImplCopyWithImpl<$Res>
    extends _$SalleCopyWithImpl<$Res, _$SalleImpl>
    implements _$$SalleImplCopyWith<$Res> {
  __$$SalleImplCopyWithImpl(
      _$SalleImpl _value, $Res Function(_$SalleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Salle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$SalleImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalleImpl extends _Salle with DiagnosticableTreeMixin {
  const _$SalleImpl({this.id, this.designation}) : super._();

  factory _$SalleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalleImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Salle(id: $id, designation: $designation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Salle'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation);

  /// Create a copy of Salle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalleImplCopyWith<_$SalleImpl> get copyWith =>
      __$$SalleImplCopyWithImpl<_$SalleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalleImplToJson(
      this,
    );
  }
}

abstract class _Salle extends Salle {
  const factory _Salle({final int? id, final String? designation}) =
      _$SalleImpl;
  const _Salle._() : super._();

  factory _Salle.fromJson(Map<String, dynamic> json) = _$SalleImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;

  /// Create a copy of Salle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalleImplCopyWith<_$SalleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
