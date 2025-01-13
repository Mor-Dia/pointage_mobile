// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_lignecredit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TypeLigneCredit _$TypeLigneCreditFromJson(Map<String, dynamic> json) {
  return _TypeLigneCredit.fromJson(json);
}

/// @nodoc
mixin _$TypeLigneCredit {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  /// Serializes this TypeLigneCredit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypeLigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeLigneCreditCopyWith<TypeLigneCredit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeLigneCreditCopyWith<$Res> {
  factory $TypeLigneCreditCopyWith(
          TypeLigneCredit value, $Res Function(TypeLigneCredit) then) =
      _$TypeLigneCreditCopyWithImpl<$Res, TypeLigneCredit>;
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class _$TypeLigneCreditCopyWithImpl<$Res, $Val extends TypeLigneCredit>
    implements $TypeLigneCreditCopyWith<$Res> {
  _$TypeLigneCreditCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeLigneCredit
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
abstract class _$$TypeLigneCreditImplCopyWith<$Res>
    implements $TypeLigneCreditCopyWith<$Res> {
  factory _$$TypeLigneCreditImplCopyWith(_$TypeLigneCreditImpl value,
          $Res Function(_$TypeLigneCreditImpl) then) =
      __$$TypeLigneCreditImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class __$$TypeLigneCreditImplCopyWithImpl<$Res>
    extends _$TypeLigneCreditCopyWithImpl<$Res, _$TypeLigneCreditImpl>
    implements _$$TypeLigneCreditImplCopyWith<$Res> {
  __$$TypeLigneCreditImplCopyWithImpl(
      _$TypeLigneCreditImpl _value, $Res Function(_$TypeLigneCreditImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypeLigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$TypeLigneCreditImpl(
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
class _$TypeLigneCreditImpl extends _TypeLigneCredit
    with DiagnosticableTreeMixin {
  const _$TypeLigneCreditImpl({this.id, this.designation}) : super._();

  factory _$TypeLigneCreditImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypeLigneCreditImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TypeLigneCredit(id: $id, designation: $designation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TypeLigneCredit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeLigneCreditImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation);

  /// Create a copy of TypeLigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeLigneCreditImplCopyWith<_$TypeLigneCreditImpl> get copyWith =>
      __$$TypeLigneCreditImplCopyWithImpl<_$TypeLigneCreditImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypeLigneCreditImplToJson(
      this,
    );
  }
}

abstract class _TypeLigneCredit extends TypeLigneCredit {
  const factory _TypeLigneCredit({final int? id, final String? designation}) =
      _$TypeLigneCreditImpl;
  const _TypeLigneCredit._() : super._();

  factory _TypeLigneCredit.fromJson(Map<String, dynamic> json) =
      _$TypeLigneCreditImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;

  /// Create a copy of TypeLigneCredit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeLigneCreditImplCopyWith<_$TypeLigneCreditImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
