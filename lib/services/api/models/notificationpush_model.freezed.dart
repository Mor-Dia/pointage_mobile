// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notificationpush_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationPush _$NotificationPushFromJson(Map<String, dynamic> json) {
  return _NotificationPush.fromJson(json);
}

/// @nodoc
mixin _$NotificationPush {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: "is_read")
  bool? get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: "data_type")
  String? get dataType => throw _privateConstructorUsedError;
  @JsonKey(name: "data_id")
  int? get dataId => throw _privateConstructorUsedError;
  @JsonKey(name: "date_emission_fr")
  String? get dateEmissionFr => throw _privateConstructorUsedError;

  /// Serializes this NotificationPush to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPushCopyWith<NotificationPush> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPushCopyWith<$Res> {
  factory $NotificationPushCopyWith(
          NotificationPush value, $Res Function(NotificationPush) then) =
      _$NotificationPushCopyWithImpl<$Res, NotificationPush>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? content,
      @JsonKey(name: "is_read") bool? isRead,
      @JsonKey(name: "data_type") String? dataType,
      @JsonKey(name: "data_id") int? dataId,
      @JsonKey(name: "date_emission_fr") String? dateEmissionFr});
}

/// @nodoc
class _$NotificationPushCopyWithImpl<$Res, $Val extends NotificationPush>
    implements $NotificationPushCopyWith<$Res> {
  _$NotificationPushCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
    Object? dataType = freezed,
    Object? dataId = freezed,
    Object? dateEmissionFr = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      dataType: freezed == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String?,
      dataId: freezed == dataId
          ? _value.dataId
          : dataId // ignore: cast_nullable_to_non_nullable
              as int?,
      dateEmissionFr: freezed == dateEmissionFr
          ? _value.dateEmissionFr
          : dateEmissionFr // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationPushImplCopyWith<$Res>
    implements $NotificationPushCopyWith<$Res> {
  factory _$$NotificationPushImplCopyWith(_$NotificationPushImpl value,
          $Res Function(_$NotificationPushImpl) then) =
      __$$NotificationPushImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? content,
      @JsonKey(name: "is_read") bool? isRead,
      @JsonKey(name: "data_type") String? dataType,
      @JsonKey(name: "data_id") int? dataId,
      @JsonKey(name: "date_emission_fr") String? dateEmissionFr});
}

/// @nodoc
class __$$NotificationPushImplCopyWithImpl<$Res>
    extends _$NotificationPushCopyWithImpl<$Res, _$NotificationPushImpl>
    implements _$$NotificationPushImplCopyWith<$Res> {
  __$$NotificationPushImplCopyWithImpl(_$NotificationPushImpl _value,
      $Res Function(_$NotificationPushImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
    Object? dataType = freezed,
    Object? dataId = freezed,
    Object? dateEmissionFr = freezed,
  }) {
    return _then(_$NotificationPushImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      dataType: freezed == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String?,
      dataId: freezed == dataId
          ? _value.dataId
          : dataId // ignore: cast_nullable_to_non_nullable
              as int?,
      dateEmissionFr: freezed == dateEmissionFr
          ? _value.dateEmissionFr
          : dateEmissionFr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPushImpl extends _NotificationPush
    with DiagnosticableTreeMixin {
  const _$NotificationPushImpl(
      {this.id,
      this.title,
      this.description,
      this.content,
      @JsonKey(name: "is_read") this.isRead,
      @JsonKey(name: "data_type") this.dataType,
      @JsonKey(name: "data_id") this.dataId,
      @JsonKey(name: "date_emission_fr") this.dateEmissionFr})
      : super._();

  factory _$NotificationPushImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPushImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? content;
  @override
  @JsonKey(name: "is_read")
  final bool? isRead;
  @override
  @JsonKey(name: "data_type")
  final String? dataType;
  @override
  @JsonKey(name: "data_id")
  final int? dataId;
  @override
  @JsonKey(name: "date_emission_fr")
  final String? dateEmissionFr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationPush(id: $id, title: $title, description: $description, content: $content, isRead: $isRead, dataType: $dataType, dataId: $dataId, dateEmissionFr: $dateEmissionFr)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationPush'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('isRead', isRead))
      ..add(DiagnosticsProperty('dataType', dataType))
      ..add(DiagnosticsProperty('dataId', dataId))
      ..add(DiagnosticsProperty('dateEmissionFr', dateEmissionFr));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPushImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.dataId, dataId) || other.dataId == dataId) &&
            (identical(other.dateEmissionFr, dateEmissionFr) ||
                other.dateEmissionFr == dateEmissionFr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, content,
      isRead, dataType, dataId, dateEmissionFr);

  /// Create a copy of NotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPushImplCopyWith<_$NotificationPushImpl> get copyWith =>
      __$$NotificationPushImplCopyWithImpl<_$NotificationPushImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPushImplToJson(
      this,
    );
  }
}

abstract class _NotificationPush extends NotificationPush {
  const factory _NotificationPush(
          {final int? id,
          final String? title,
          final String? description,
          final String? content,
          @JsonKey(name: "is_read") final bool? isRead,
          @JsonKey(name: "data_type") final String? dataType,
          @JsonKey(name: "data_id") final int? dataId,
          @JsonKey(name: "date_emission_fr") final String? dateEmissionFr}) =
      _$NotificationPushImpl;
  const _NotificationPush._() : super._();

  factory _NotificationPush.fromJson(Map<String, dynamic> json) =
      _$NotificationPushImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get content;
  @override
  @JsonKey(name: "is_read")
  bool? get isRead;
  @override
  @JsonKey(name: "data_type")
  String? get dataType;
  @override
  @JsonKey(name: "data_id")
  int? get dataId;
  @override
  @JsonKey(name: "date_emission_fr")
  String? get dateEmissionFr;

  /// Create a copy of NotificationPush
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPushImplCopyWith<_$NotificationPushImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
