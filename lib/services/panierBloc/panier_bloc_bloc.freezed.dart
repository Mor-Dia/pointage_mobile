// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panier_bloc_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PanierBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(Map<String, dynamic> body, String token)
        postPanier,
    required TResult Function(String token) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(Map<String, dynamic> body, String token)? postPanier,
    TResult? Function(String token)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(Map<String, dynamic> body, String token)? postPanier,
    TResult Function(String token)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierStarted value) started,
    required TResult Function(PostPanier value) postPanier,
    required TResult Function(RefreshPanier value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierStarted value)? started,
    TResult? Function(PostPanier value)? postPanier,
    TResult? Function(RefreshPanier value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierStarted value)? started,
    TResult Function(PostPanier value)? postPanier,
    TResult Function(RefreshPanier value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierBlocEventCopyWith<$Res> {
  factory $PanierBlocEventCopyWith(
          PanierBlocEvent value, $Res Function(PanierBlocEvent) then) =
      _$PanierBlocEventCopyWithImpl<$Res, PanierBlocEvent>;
}

/// @nodoc
class _$PanierBlocEventCopyWithImpl<$Res, $Val extends PanierBlocEvent>
    implements $PanierBlocEventCopyWith<$Res> {
  _$PanierBlocEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PanierStartedImplCopyWith<$Res> {
  factory _$$PanierStartedImplCopyWith(
          _$PanierStartedImpl value, $Res Function(_$PanierStartedImpl) then) =
      __$$PanierStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PanierStartedImplCopyWithImpl<$Res>
    extends _$PanierBlocEventCopyWithImpl<$Res, _$PanierStartedImpl>
    implements _$$PanierStartedImplCopyWith<$Res> {
  __$$PanierStartedImplCopyWithImpl(
      _$PanierStartedImpl _value, $Res Function(_$PanierStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PanierStartedImpl
    with DiagnosticableTreeMixin
    implements PanierStarted {
  const _$PanierStartedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocEvent.started()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'PanierBlocEvent.started'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PanierStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(Map<String, dynamic> body, String token)
        postPanier,
    required TResult Function(String token) refresh,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(Map<String, dynamic> body, String token)? postPanier,
    TResult? Function(String token)? refresh,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(Map<String, dynamic> body, String token)? postPanier,
    TResult Function(String token)? refresh,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierStarted value) started,
    required TResult Function(PostPanier value) postPanier,
    required TResult Function(RefreshPanier value) refresh,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierStarted value)? started,
    TResult? Function(PostPanier value)? postPanier,
    TResult? Function(RefreshPanier value)? refresh,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierStarted value)? started,
    TResult Function(PostPanier value)? postPanier,
    TResult Function(RefreshPanier value)? refresh,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class PanierStarted implements PanierBlocEvent {
  const factory PanierStarted() = _$PanierStartedImpl;
}

/// @nodoc
abstract class _$$PostPanierImplCopyWith<$Res> {
  factory _$$PostPanierImplCopyWith(
          _$PostPanierImpl value, $Res Function(_$PostPanierImpl) then) =
      __$$PostPanierImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> body, String token});
}

/// @nodoc
class __$$PostPanierImplCopyWithImpl<$Res>
    extends _$PanierBlocEventCopyWithImpl<$Res, _$PostPanierImpl>
    implements _$$PostPanierImplCopyWith<$Res> {
  __$$PostPanierImplCopyWithImpl(
      _$PostPanierImpl _value, $Res Function(_$PostPanierImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? body = null,
    Object? token = null,
  }) {
    return _then(_$PostPanierImpl(
      body: null == body
          ? _value._body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostPanierImpl with DiagnosticableTreeMixin implements PostPanier {
  const _$PostPanierImpl(
      {required final Map<String, dynamic> body, required this.token})
      : _body = body;

  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  final String token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocEvent.postPanier(body: $body, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierBlocEvent.postPanier'))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostPanierImpl &&
            const DeepCollectionEquality().equals(other._body, _body) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_body), token);

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostPanierImplCopyWith<_$PostPanierImpl> get copyWith =>
      __$$PostPanierImplCopyWithImpl<_$PostPanierImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(Map<String, dynamic> body, String token)
        postPanier,
    required TResult Function(String token) refresh,
  }) {
    return postPanier(body, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(Map<String, dynamic> body, String token)? postPanier,
    TResult? Function(String token)? refresh,
  }) {
    return postPanier?.call(body, token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(Map<String, dynamic> body, String token)? postPanier,
    TResult Function(String token)? refresh,
    required TResult orElse(),
  }) {
    if (postPanier != null) {
      return postPanier(body, token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierStarted value) started,
    required TResult Function(PostPanier value) postPanier,
    required TResult Function(RefreshPanier value) refresh,
  }) {
    return postPanier(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierStarted value)? started,
    TResult? Function(PostPanier value)? postPanier,
    TResult? Function(RefreshPanier value)? refresh,
  }) {
    return postPanier?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierStarted value)? started,
    TResult Function(PostPanier value)? postPanier,
    TResult Function(RefreshPanier value)? refresh,
    required TResult orElse(),
  }) {
    if (postPanier != null) {
      return postPanier(this);
    }
    return orElse();
  }
}

abstract class PostPanier implements PanierBlocEvent {
  const factory PostPanier(
      {required final Map<String, dynamic> body,
      required final String token}) = _$PostPanierImpl;

  Map<String, dynamic> get body;
  String get token;

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostPanierImplCopyWith<_$PostPanierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshPanierImplCopyWith<$Res> {
  factory _$$RefreshPanierImplCopyWith(
          _$RefreshPanierImpl value, $Res Function(_$RefreshPanierImpl) then) =
      __$$RefreshPanierImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$RefreshPanierImplCopyWithImpl<$Res>
    extends _$PanierBlocEventCopyWithImpl<$Res, _$RefreshPanierImpl>
    implements _$$RefreshPanierImplCopyWith<$Res> {
  __$$RefreshPanierImplCopyWithImpl(
      _$RefreshPanierImpl _value, $Res Function(_$RefreshPanierImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$RefreshPanierImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshPanierImpl
    with DiagnosticableTreeMixin
    implements RefreshPanier {
  const _$RefreshPanierImpl({required this.token});

  @override
  final String token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocEvent.refresh(token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierBlocEvent.refresh'))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshPanierImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshPanierImplCopyWith<_$RefreshPanierImpl> get copyWith =>
      __$$RefreshPanierImplCopyWithImpl<_$RefreshPanierImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(Map<String, dynamic> body, String token)
        postPanier,
    required TResult Function(String token) refresh,
  }) {
    return refresh(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(Map<String, dynamic> body, String token)? postPanier,
    TResult? Function(String token)? refresh,
  }) {
    return refresh?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(Map<String, dynamic> body, String token)? postPanier,
    TResult Function(String token)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierStarted value) started,
    required TResult Function(PostPanier value) postPanier,
    required TResult Function(RefreshPanier value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierStarted value)? started,
    TResult? Function(PostPanier value)? postPanier,
    TResult? Function(RefreshPanier value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierStarted value)? started,
    TResult Function(PostPanier value)? postPanier,
    TResult Function(RefreshPanier value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshPanier implements PanierBlocEvent {
  const factory RefreshPanier({required final String token}) =
      _$RefreshPanierImpl;

  String get token;

  /// Create a copy of PanierBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshPanierImplCopyWith<_$RefreshPanierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PanierBlocState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierBlocStateCopyWith<$Res> {
  factory $PanierBlocStateCopyWith(
          PanierBlocState value, $Res Function(PanierBlocState) then) =
      _$PanierBlocStateCopyWithImpl<$Res, PanierBlocState>;
}

/// @nodoc
class _$PanierBlocStateCopyWithImpl<$Res, $Val extends PanierBlocState>
    implements $PanierBlocStateCopyWith<$Res> {
  _$PanierBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PanierInitialImplCopyWith<$Res> {
  factory _$$PanierInitialImplCopyWith(
          _$PanierInitialImpl value, $Res Function(_$PanierInitialImpl) then) =
      __$$PanierInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PanierInitialImplCopyWithImpl<$Res>
    extends _$PanierBlocStateCopyWithImpl<$Res, _$PanierInitialImpl>
    implements _$$PanierInitialImplCopyWith<$Res> {
  __$$PanierInitialImplCopyWithImpl(
      _$PanierInitialImpl _value, $Res Function(_$PanierInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PanierInitialImpl
    with DiagnosticableTreeMixin
    implements PanierInitial {
  const _$PanierInitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'PanierBlocState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PanierInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PanierInitial implements PanierBlocState {
  const factory PanierInitial() = _$PanierInitialImpl;
}

/// @nodoc
abstract class _$$PanierLoadingImplCopyWith<$Res> {
  factory _$$PanierLoadingImplCopyWith(
          _$PanierLoadingImpl value, $Res Function(_$PanierLoadingImpl) then) =
      __$$PanierLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PanierLoadingImplCopyWithImpl<$Res>
    extends _$PanierBlocStateCopyWithImpl<$Res, _$PanierLoadingImpl>
    implements _$$PanierLoadingImplCopyWith<$Res> {
  __$$PanierLoadingImplCopyWithImpl(
      _$PanierLoadingImpl _value, $Res Function(_$PanierLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PanierLoadingImpl
    with DiagnosticableTreeMixin
    implements PanierLoading {
  const _$PanierLoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'PanierBlocState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PanierLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PanierLoading implements PanierBlocState {
  const factory PanierLoading() = _$PanierLoadingImpl;
}

/// @nodoc
abstract class _$$PanierSuccessImplCopyWith<$Res> {
  factory _$$PanierSuccessImplCopyWith(
          _$PanierSuccessImpl value, $Res Function(_$PanierSuccessImpl) then) =
      __$$PanierSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PanierSuccessImplCopyWithImpl<$Res>
    extends _$PanierBlocStateCopyWithImpl<$Res, _$PanierSuccessImpl>
    implements _$$PanierSuccessImplCopyWith<$Res> {
  __$$PanierSuccessImplCopyWithImpl(
      _$PanierSuccessImpl _value, $Res Function(_$PanierSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PanierSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PanierSuccessImpl
    with DiagnosticableTreeMixin
    implements PanierSuccess {
  const _$PanierSuccessImpl({required this.message});

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocState.success(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierBlocState.success'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanierSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanierSuccessImplCopyWith<_$PanierSuccessImpl> get copyWith =>
      __$$PanierSuccessImplCopyWithImpl<_$PanierSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class PanierSuccess implements PanierBlocState {
  const factory PanierSuccess({required final String message}) =
      _$PanierSuccessImpl;

  String get message;

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanierSuccessImplCopyWith<_$PanierSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanierLoadedImplCopyWith<$Res> {
  factory _$$PanierLoadedImplCopyWith(
          _$PanierLoadedImpl value, $Res Function(_$PanierLoadedImpl) then) =
      __$$PanierLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PanierPProduit> panier});
}

/// @nodoc
class __$$PanierLoadedImplCopyWithImpl<$Res>
    extends _$PanierBlocStateCopyWithImpl<$Res, _$PanierLoadedImpl>
    implements _$$PanierLoadedImplCopyWith<$Res> {
  __$$PanierLoadedImplCopyWithImpl(
      _$PanierLoadedImpl _value, $Res Function(_$PanierLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? panier = null,
  }) {
    return _then(_$PanierLoadedImpl(
      panier: null == panier
          ? _value._panier
          : panier // ignore: cast_nullable_to_non_nullable
              as List<PanierPProduit>,
    ));
  }
}

/// @nodoc

class _$PanierLoadedImpl with DiagnosticableTreeMixin implements PanierLoaded {
  const _$PanierLoadedImpl({required final List<PanierPProduit> panier})
      : _panier = panier;

  final List<PanierPProduit> _panier;
  @override
  List<PanierPProduit> get panier {
    if (_panier is EqualUnmodifiableListView) return _panier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_panier);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocState.loaded(panier: $panier)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierBlocState.loaded'))
      ..add(DiagnosticsProperty('panier', panier));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanierLoadedImpl &&
            const DeepCollectionEquality().equals(other._panier, _panier));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_panier));

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanierLoadedImplCopyWith<_$PanierLoadedImpl> get copyWith =>
      __$$PanierLoadedImplCopyWithImpl<_$PanierLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(panier);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(panier);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(panier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PanierLoaded implements PanierBlocState {
  const factory PanierLoaded({required final List<PanierPProduit> panier}) =
      _$PanierLoadedImpl;

  List<PanierPProduit> get panier;

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanierLoadedImplCopyWith<_$PanierLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanierErrorImplCopyWith<$Res> {
  factory _$$PanierErrorImplCopyWith(
          _$PanierErrorImpl value, $Res Function(_$PanierErrorImpl) then) =
      __$$PanierErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PanierErrorImplCopyWithImpl<$Res>
    extends _$PanierBlocStateCopyWithImpl<$Res, _$PanierErrorImpl>
    implements _$$PanierErrorImplCopyWith<$Res> {
  __$$PanierErrorImplCopyWithImpl(
      _$PanierErrorImpl _value, $Res Function(_$PanierErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PanierErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PanierErrorImpl with DiagnosticableTreeMixin implements PanierError {
  const _$PanierErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierBlocState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierBlocState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanierErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PanierErrorImplCopyWith<_$PanierErrorImpl> get copyWith =>
      __$$PanierErrorImplCopyWithImpl<_$PanierErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) success,
    required TResult Function(List<PanierPProduit> panier) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? success,
    TResult? Function(List<PanierPProduit> panier)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? success,
    TResult Function(List<PanierPProduit> panier)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PanierInitial value) initial,
    required TResult Function(PanierLoading value) loading,
    required TResult Function(PanierSuccess value) success,
    required TResult Function(PanierLoaded value) loaded,
    required TResult Function(PanierError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PanierInitial value)? initial,
    TResult? Function(PanierLoading value)? loading,
    TResult? Function(PanierSuccess value)? success,
    TResult? Function(PanierLoaded value)? loaded,
    TResult? Function(PanierError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PanierInitial value)? initial,
    TResult Function(PanierLoading value)? loading,
    TResult Function(PanierSuccess value)? success,
    TResult Function(PanierLoaded value)? loaded,
    TResult Function(PanierError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PanierError implements PanierBlocState {
  const factory PanierError({required final String message}) =
      _$PanierErrorImpl;

  String get message;

  /// Create a copy of PanierBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PanierErrorImplCopyWith<_$PanierErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
