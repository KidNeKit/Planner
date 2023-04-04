import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/view/registration_screen/registration_screen.dart';

import '../../cubits/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextField(
                onChanged: (value) =>
                    context.read<LoginCubit>().changeEmail(value),
              );
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) =>
                previous.password != current.password,
            builder: (context, state) {
              return TextField(
                onChanged: (value) =>
                    context.read<LoginCubit>().changePassword(value),
              );
            },
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<LoginCubit>().signInWithEmailAndPassword(),
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, RegistrationScreen.routeName),
            child: const Text('To registration'),
          ),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
    );
  }
}
