part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}


class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final User user;

  AuthenticationLoginRequested({required this.user});
}

class AuthenticationLoginSucess extends AuthenticationEvent {}

class AuthenticationLoginFailed extends AuthenticationEvent {}

class AuthenticationInitial extends AuthenticationEvent {}

class AuthenticationNavigateToHome extends AuthenticationEvent {}
