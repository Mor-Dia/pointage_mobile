part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

// abstract class AuthenticationEvent extends Equatable {
//   const AuthenticationEvent();

//   @override
//   List<Object?> get props => [];
// }

class AuthenticationUserRefreshed extends AuthenticationEvent {}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationChecked extends AuthenticationEvent {}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}

final class _UserChanged extends AuthenticationEvent {
  const _UserChanged(this.status);

  final UserChangeStatus status;
}