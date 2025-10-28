import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc<T>
    extends Bloc<AuthenticationEvent, AuthenticationState<T>> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository<T> userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationState<T>.unknown()) {
    _authenticationRepository();
    _userRepository();
    onCreate();
    on<AuthenticationChecked>(_onAuthenticationChecked);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<_UserChanged>(_onUserChanged);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
    _userStatusSubscription = _userRepository.status.listen(
      (status) => add(_UserChanged(status)),
    );

    on<AuthenticationUserRefreshed>(_onAuthenticationUserRefreshed);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  late StreamSubscription<UserChangeStatus> _userStatusSubscription;

  Future<void> _onAuthenticationUserRefreshed(
    AuthenticationUserRefreshed event,
    Emitter<AuthenticationState<T>> emit,
  ) async {
    try {
      final user = await _tryGetUser();
      if (user != null) {
        emit(AuthenticationState<T>.authenticated(user));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erreur lors du rafraîchissement de l'utilisateur : $e");
      }
    }
  }

  void onCreate() async {
    if (kDebugMode) {
      print("CHECK PRIOR AUTH ");
    }
    _authenticationRepository.checkPersistentUser();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _userStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationChecked(
    AuthenticationChecked event,
    Emitter<AuthenticationState> emit,
  ) async {
    _authenticationRepository.checkPersistentUser();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (kDebugMode) {
      print("FROM BLOC AUTH AUTH STATUS CHANGED ${event.status}");
    }
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationState<T>.unauthenticated());
      case AuthenticationStatus.failure:
        return emit(AuthenticationState<T>.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        if (kDebugMode) {
          print("USER EMITTED $user");
        }
        return emit(
          user != null
              ? AuthenticationState<T>.authenticated(user)
              : AuthenticationState<T>.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(AuthenticationState<T>.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState<T>> emit,
  ) {
    _authenticationRepository.logOut();
  }

  void _onUserChanged(
    _UserChanged event,
    Emitter<AuthenticationState<T>> emit,
  ) async {
    if (kDebugMode) {
      print("USER CHANGED _onUserChanged ${event.status}");
    }
    switch (event.status) {
      case UserChangeStatus.userchanged:
        final user = await _tryGetUser();
        if (kDebugMode) {
          print("USER CHANGED _onUserChanged $user");
        }
        return emit(
          user != null
              ? AuthenticationState<T>.authenticated(user)
              : AuthenticationState<T>.unauthenticated(),
        );
      default:
        break;
    }
  }

  Future<T?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
