import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import 'bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
LoginPage({super.key});


final emailController = TextEditingController();
final usernameController = TextEditingController();
final passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  // if(value!.isEmpty){
                  //   return "username is required";
                  // }
                  // return null;
                },
                decoration: const InputDecoration(
                  labelText: 'username',
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Trigger the AuthenticationLoginRequested event
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthenticationBloc>().add(AuthenticationLoginRequested(user: User(email: emailController.text, name: usernameController.text, password: passwordController.text)));
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}