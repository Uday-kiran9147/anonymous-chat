import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/model/user.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState(status: AuthenticationStatus.unknown, user: User.empty)) {
    on<AuthenticationEvent>(authenticationEvent);
    on<AuthenticationLoginRequested>(authenticationLoginRequested);
  }

  FutureOr<void> authenticationEvent(AuthenticationEvent event, Emitter<AuthenticationState> emit) {
    print('Event: $event');
  }



  FutureOr<void> authenticationLoginRequested(AuthenticationLoginRequested event, Emitter<AuthenticationState> emit) {
    print('Event: $event');
    emit(AuthenticationSuccessState(user: event.user));
  }
}
