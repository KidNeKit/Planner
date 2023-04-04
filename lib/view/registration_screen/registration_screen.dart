import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/registration/registration_cubit.dart';
import '../../repositories/auth_repository.dart';
import '../login_screen/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration';
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<RegistrationCubit, RegistrationState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextField(
                onChanged: (value) =>
                    context.read<RegistrationCubit>().changeEmail(value),
              );
            },
          ),
          BlocBuilder<RegistrationCubit, RegistrationState>(
            buildWhen: (previous, current) =>
                previous.password != current.password,
            builder: (context, state) {
              return TextField(
                onChanged: (value) =>
                    context.read<RegistrationCubit>().changePassword(value),
              );
            },
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<RegistrationCubit>().signUpWithEmailAndPassword(),
            child: const Text('Sign Up'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.routeName),
            child: const Text('To login'),
          ),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) =>
            RegistrationCubit(authRepository: context.read<AuthRepository>()),
        child: const RegistrationScreen(),
      ),
    );
  }
}
