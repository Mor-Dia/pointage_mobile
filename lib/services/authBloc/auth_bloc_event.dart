part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class AppStartedEvent extends AuthBlocEvent {
  final Map<String, dynamic>? data;

  AppStartedEvent({required this.data});
}

class loginEvent extends AuthBlocEvent {
  final Map<String, dynamic> data;

  loginEvent({required this.data});
}

class SignUpEvent extends AuthBlocEvent {
  final String emailController;
  final String passwordController;

  SignUpEvent(
      {required this.emailController, required this.passwordController});
}
