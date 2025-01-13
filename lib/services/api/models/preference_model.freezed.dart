// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Preference _$PreferenceFromJson(Map<String, dynamic> json) {
  return _Preference.fromJson(json);
}

/// @nodoc
mixin _$Preference {
  int? get id => throw _privateConstructorUsedError;
  dynamic? get parametre => throw _privateConstructorUsedError;
  dynamic? get valeur => throw _privateConstructorUsedError;
  @JsonKey(name: "valeur_text")
  dynamic? get valeurText => throw _privateConstructorUsedError;

  /// Serializes this Preference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreferenceCopyWith<Preference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferenceCopyWith<$Res> {
  factory $PreferenceCopyWith(
          Preference value, $Res Function(Preference) then) =
      _$PreferenceCopyWithImpl<$Res, Preference>;
  @useResult
  $Res call(
      {int? id,
      dynamic? parametre,
      dynamic? valeur,
      @JsonKey(name: "valeur_text") dynamic? valeurText});
}

/// @nodoc
class _$PreferenceCopyWithImpl<$Res, $Val extends Preference>
    implements $PreferenceCopyWith<$Res> {
  _$PreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parametre = freezed,
    Object? valeur = freezed,
    Object? valeurText = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      parametre: freezed == parametre
          ? _value.parametre
          : parametre // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      valeur: freezed == valeur
          ? _value.valeur
          : valeur // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      valeurText: freezed == valeurText
          ? _value.valeurText
          : valeurText // ignore: cast_nullable_to_non_nullable
              as dynamic?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreferenceImplCopyWith<$Res>
    implements $PreferenceCopyWith<$Res> {
  factory _$$PreferenceImplCopyWith(
          _$PreferenceImpl value, $Res Function(_$PreferenceImpl) then) =
      __$$PreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      dynamic? parametre,
      dynamic? valeur,
      @JsonKey(name: "valeur_text") dynamic? valeurText});
}

/// @nodoc
class __$$PreferenceImplCopyWithImpl<$Res>
    extends _$PreferenceCopyWithImpl<$Res, _$PreferenceImpl>
    implements _$$PreferenceImplCopyWith<$Res> {
  __$$PreferenceImplCopyWithImpl(
      _$PreferenceImpl _value, $Res Function(_$PreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parametre = freezed,
    Object? valeur = freezed,
    Object? valeurText = freezed,
  }) {
    return _then(_$PreferenceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      parametre: freezed == parametre
          ? _value.parametre
          : parametre // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      valeur: freezed == valeur
          ? _value.valeur
          : valeur // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      valeurText: freezed == valeurText
          ? _value.valeurText
          : valeurText // ignore: cast_nullable_to_non_nullable
              as dynamic?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreferenceImpl extends _Preference with DiagnosticableTreeMixin {
  const _$PreferenceImpl(
      {this.id,
      this.parametre,
      this.valeur,
      @JsonKey(name: "valeur_text") this.valeurText})
      : super._();

  factory _$PreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreferenceImplFromJson(json);

  @override
  final int? id;
  @override
  final dynamic? parametre;
  @override
  final dynamic? valeur;
  @override
  @JsonKey(name: "valeur_text")
  final dynamic? valeurText;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Preference(id: $id, parametre: $parametre, valeur: $valeur, valeurText: $valeurText)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Preference'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('parametre', parametre))
      ..add(DiagnosticsProperty('valeur', valeur))
      ..add(DiagnosticsProperty('valeurText', valeurText));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.parametre, parametre) &&
            const DeepCollectionEquality().equals(other.valeur, valeur) &&
            const DeepCollectionEquality()
                .equals(other.valeurText, valeurText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(parametre),
      const DeepCollectionEquality().hash(valeur),
      const DeepCollectionEquality().hash(valeurText));

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreferenceImplCopyWith<_$PreferenceImpl> get copyWith =>
      __$$PreferenceImplCopyWithImpl<_$PreferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreferenceImplToJson(
      this,
    );
  }
}

abstract class _Preference extends Preference {
  const factory _Preference(
          {final int? id,
          final dynamic? parametre,
          final dynamic? valeur,
          @JsonKey(name: "valeur_text") final dynamic? valeurText}) =
      _$PreferenceImpl;
  const _Preference._() : super._();

  factory _Preference.fromJson(Map<String, dynamic> json) =
      _$PreferenceImpl.fromJson;

  @override
  int? get id;
  @override
  dynamic? get parametre;
  @override
  dynamic? get valeur;
  @override
  @JsonKey(name: "valeur_text")
  dynamic? get valeurText;

  /// Create a copy of Preference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreferenceImplCopyWith<_$PreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
