// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;
  const AuthenticationState({
    required this.status,
    required this.user,
  });

  @override
  List<Object> get props => [status, user];
}

class AuthenticationSuccessState extends AuthenticationState {
  const AuthenticationSuccessState({required super.user})
      : super(status: AuthenticationStatus.authenticated);
}

class AuthenticationActionState extends AuthenticationState {
  AuthenticationActionState({required super.status, required super.user});
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
