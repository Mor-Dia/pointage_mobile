// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_pratique_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TypePratique _$TypePratiqueFromJson(Map<String, dynamic> json) {
  return _TypePratique.fromJson(json);
}

/// @nodoc
mixin _$TypePratique {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  /// Serializes this TypePratique to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypePratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypePratiqueCopyWith<TypePratique> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypePratiqueCopyWith<$Res> {
  factory $TypePratiqueCopyWith(
          TypePratique value, $Res Function(TypePratique) then) =
      _$TypePratiqueCopyWithImpl<$Res, TypePratique>;
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class _$TypePratiqueCopyWithImpl<$Res, $Val extends TypePratique>
    implements $TypePratiqueCopyWith<$Res> {
  _$TypePratiqueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypePratique
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
abstract class _$$TypePratiqueImplCopyWith<$Res>
    implements $TypePratiqueCopyWith<$Res> {
  factory _$$TypePratiqueImplCopyWith(
          _$TypePratiqueImpl value, $Res Function(_$TypePratiqueImpl) then) =
      __$$TypePratiqueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class __$$TypePratiqueImplCopyWithImpl<$Res>
    extends _$TypePratiqueCopyWithImpl<$Res, _$TypePratiqueImpl>
    implements _$$TypePratiqueImplCopyWith<$Res> {
  __$$TypePratiqueImplCopyWithImpl(
      _$TypePratiqueImpl _value, $Res Function(_$TypePratiqueImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypePratique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$TypePratiqueImpl(
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
class _$TypePratiqueImpl extends _TypePratique with DiagnosticableTreeMixin {
  const _$TypePratiqueImpl({this.id, this.designation}) : super._();

  factory _$TypePratiqueImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypePratiqueImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TypePratique(id: $id, designation: $designation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TypePratique'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypePratiqueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation);

  /// Create a copy of TypePratique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypePratiqueImplCopyWith<_$TypePratiqueImpl> get copyWith =>
      __$$TypePratiqueImplCopyWithImpl<_$TypePratiqueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypePratiqueImplToJson(
      this,
    );
  }
}

abstract class _TypePratique extends TypePratique {
  const factory _TypePratique({final int? id, final String? designation}) =
      _$TypePratiqueImpl;
  const _TypePratique._() : super._();

  factory _TypePratique.fromJson(Map<String, dynamic> json) =
      _$TypePratiqueImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;

  /// Create a copy of TypePratique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypePratiqueImplCopyWith<_$TypePratiqueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
