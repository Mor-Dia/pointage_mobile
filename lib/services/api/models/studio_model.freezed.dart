// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'studio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Studio _$StudioFromJson(Map<String, dynamic> json) {
  return _Studio.fromJson(json);
}

/// @nodoc
mixin _$Studio {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;

  /// Serializes this Studio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Studio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudioCopyWith<Studio> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudioCopyWith<$Res> {
  factory $StudioCopyWith(Studio value, $Res Function(Studio) then) =
      _$StudioCopyWithImpl<$Res, Studio>;
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class _$StudioCopyWithImpl<$Res, $Val extends Studio>
    implements $StudioCopyWith<$Res> {
  _$StudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Studio
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
abstract class _$$StudioImplCopyWith<$Res> implements $StudioCopyWith<$Res> {
  factory _$$StudioImplCopyWith(
          _$StudioImpl value, $Res Function(_$StudioImpl) then) =
      __$$StudioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? designation});
}

/// @nodoc
class __$$StudioImplCopyWithImpl<$Res>
    extends _$StudioCopyWithImpl<$Res, _$StudioImpl>
    implements _$$StudioImplCopyWith<$Res> {
  __$$StudioImplCopyWithImpl(
      _$StudioImpl _value, $Res Function(_$StudioImpl) _then)
      : super(_value, _then);

  /// Create a copy of Studio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
  }) {
    return _then(_$StudioImpl(
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
class _$StudioImpl extends _Studio with DiagnosticableTreeMixin {
  const _$StudioImpl({this.id, this.designation}) : super._();

  factory _$StudioImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudioImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Studio(id: $id, designation: $designation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Studio'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, designation);

  /// Create a copy of Studio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudioImplCopyWith<_$StudioImpl> get copyWith =>
      __$$StudioImplCopyWithImpl<_$StudioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudioImplToJson(
      this,
    );
  }
}

abstract class _Studio extends Studio {
  const factory _Studio({final int? id, final String? designation}) =
      _$StudioImpl;
  const _Studio._() : super._();

  factory _Studio.fromJson(Map<String, dynamic> json) = _$StudioImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;

  /// Create a copy of Studio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudioImplCopyWith<_$StudioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
