part of 'auth_bloc_bloc.dart';

@immutable
class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {
  final UserClass? user;

  AuthBlocInitial({required this.user});
}

class AuthBlocLoading extends AuthBlocState {}

final class AuthBlocError extends AuthBlocState {
  final String error;

  AuthBlocError({required this.error});
}

final class UpdateUserSucces extends AuthBlocInitial {
  UpdateUserSucces({required super.user});
}
