// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_notificationpush_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TypeNotificationPush _$TypeNotificationPushFromJson(Map<String, dynamic> json) {
  return _TypeNotificationPush.fromJson(json);
}

/// @nodoc
mixin _$TypeNotificationPush {
  int? get id => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "is_allowed")
  bool? get isAllowed => throw _privateConstructorUsedError;

  /// Serializes this TypeNotificationPush to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypeNotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeNotificationPushCopyWith<TypeNotificationPush> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeNotificationPushCopyWith<$Res> {
  factory $TypeNotificationPushCopyWith(TypeNotificationPush value,
          $Res Function(TypeNotificationPush) then) =
      _$TypeNotificationPushCopyWithImpl<$Res, TypeNotificationPush>;
  @useResult
  $Res call(
      {int? id,
      String? designation,
      String? description,
      @JsonKey(name: "is_allowed") bool? isAllowed});
}

/// @nodoc
class _$TypeNotificationPushCopyWithImpl<$Res,
        $Val extends TypeNotificationPush>
    implements $TypeNotificationPushCopyWith<$Res> {
  _$TypeNotificationPushCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeNotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? description = freezed,
    Object? isAllowed = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllowed: freezed == isAllowed
          ? _value.isAllowed
          : isAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypeNotificationPushImplCopyWith<$Res>
    implements $TypeNotificationPushCopyWith<$Res> {
  factory _$$TypeNotificationPushImplCopyWith(_$TypeNotificationPushImpl value,
          $Res Function(_$TypeNotificationPushImpl) then) =
      __$$TypeNotificationPushImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? designation,
      String? description,
      @JsonKey(name: "is_allowed") bool? isAllowed});
}

/// @nodoc
class __$$TypeNotificationPushImplCopyWithImpl<$Res>
    extends _$TypeNotificationPushCopyWithImpl<$Res, _$TypeNotificationPushImpl>
    implements _$$TypeNotificationPushImplCopyWith<$Res> {
  __$$TypeNotificationPushImplCopyWithImpl(_$TypeNotificationPushImpl _value,
      $Res Function(_$TypeNotificationPushImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypeNotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? designation = freezed,
    Object? description = freezed,
    Object? isAllowed = freezed,
  }) {
    return _then(_$TypeNotificationPushImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllowed: freezed == isAllowed
          ? _value.isAllowed
          : isAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypeNotificationPushImpl extends _TypeNotificationPush
    with DiagnosticableTreeMixin {
  const _$TypeNotificationPushImpl(
      {this.id,
      this.designation,
      this.description,
      @JsonKey(name: "is_allowed") this.isAllowed})
      : super._();

  factory _$TypeNotificationPushImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypeNotificationPushImplFromJson(json);

  @override
  final int? id;
  @override
  final String? designation;
  @override
  final String? description;
  @override
  @JsonKey(name: "is_allowed")
  final bool? isAllowed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TypeNotificationPush(id: $id, designation: $designation, description: $description, isAllowed: $isAllowed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TypeNotificationPush'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('designation', designation))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('isAllowed', isAllowed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeNotificationPushImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isAllowed, isAllowed) ||
                other.isAllowed == isAllowed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, designation, description, isAllowed);

  /// Create a copy of TypeNotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeNotificationPushImplCopyWith<_$TypeNotificationPushImpl>
      get copyWith =>
          __$$TypeNotificationPushImplCopyWithImpl<_$TypeNotificationPushImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypeNotificationPushImplToJson(
      this,
    );
  }
}

abstract class _TypeNotificationPush extends TypeNotificationPush {
  const factory _TypeNotificationPush(
          {final int? id,
          final String? designation,
          final String? description,
          @JsonKey(name: "is_allowed") final bool? isAllowed}) =
      _$TypeNotificationPushImpl;
  const _TypeNotificationPush._() : super._();

  factory _TypeNotificationPush.fromJson(Map<String, dynamic> json) =
      _$TypeNotificationPushImpl.fromJson;

  @override
  int? get id;
  @override
  String? get designation;
  @override
  String? get description;
  @override
  @JsonKey(name: "is_allowed")
  bool? get isAllowed;

  /// Create a copy of TypeNotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeNotificationPushImplCopyWith<_$TypeNotificationPushImpl>
      get copyWith => throw _privateConstructorUsedError;
}
