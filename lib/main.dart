import 'package:chat/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'authentication/authentication.dart';
import 'authentication/bloc/authentication_bloc.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) {
            return AuthenticationBloc();
          },
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return ChatPage(name: "uday",);
              } else {
                return ChatPage(name: "uday",);
              }
            },
          )),
    );
  }
}
