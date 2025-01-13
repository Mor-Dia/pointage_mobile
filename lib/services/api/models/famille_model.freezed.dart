// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'famille_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Famille _$FamilleFromJson(Map<String, dynamic> json) {
  return _Famille.fromJson(json);
}

/// @nodoc
mixin _$Famille {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  /// Serializes this Famille to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Famille
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FamilleCopyWith<Famille> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilleCopyWith<$Res> {
  factory $FamilleCopyWith(Famille value, $Res Function(Famille) then) =
      _$FamilleCopyWithImpl<$Res, Famille>;
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class _$FamilleCopyWithImpl<$Res, $Val extends Famille>
    implements $FamilleCopyWith<$Res> {
  _$FamilleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Famille
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
abstract class _$$FamilleImplCopyWith<$Res> implements $FamilleCopyWith<$Res> {
  factory _$$FamilleImplCopyWith(
          _$FamilleImpl value, $Res Function(_$FamilleImpl) then) =
      __$$FamilleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class __$$FamilleImplCopyWithImpl<$Res>
    extends _$FamilleCopyWithImpl<$Res, _$FamilleImpl>
    implements _$$FamilleImplCopyWith<$Res> {
  __$$FamilleImplCopyWithImpl(
      _$FamilleImpl _value, $Res Function(_$FamilleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Famille
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$FamilleImpl(
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
class _$FamilleImpl extends _Famille with DiagnosticableTreeMixin {
  const _$FamilleImpl({this.id, this.designation}) : super._();

  factory _$FamilleImpl.fromJson(Map<String, dynamic> json) =>
      _$$FamilleImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Famille(id: $id, designation: $designation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Famille'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation);

  /// Create a copy of Famille
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilleImplCopyWith<_$FamilleImpl> get copyWith =>
      __$$FamilleImplCopyWithImpl<_$FamilleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FamilleImplToJson(
      this,
    );
  }
}

abstract class _Famille extends Famille {
  const factory _Famille({final int? id, final String? designation}) =
      _$FamilleImpl;
  const _Famille._() : super._();

  factory _Famille.fromJson(Map<String, dynamic> json) = _$FamilleImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;

  /// Create a copy of Famille
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FamilleImplCopyWith<_$FamilleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
