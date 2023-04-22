import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../domain/entities/enum/operation_status.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../cubits/login/login_cubit.dart';
import '../global_components/custom_text_field.dart';
import '../global_components/custom_text_sizes.dart';
import '../navigation_screen/navigation_screen.dart';
import '../registration_screen/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Theme.of(context).primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 0.7 * size.height,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  const CustomBodySmallText(
                    text: 'Welcome Back',
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30.0),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.email != current.email,
                    builder: (context, state) {
                      return CustomTextField(
                        labelText: 'Email',
                        onChangedFunc: (value) =>
                            context.read<LoginCubit>().changeEmail(value),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.password != current.password,
                    builder: (context, state) {
                      return CustomTextField(
                        labelText: 'Password',
                        obscureText: true,
                        onChangedFunc: (value) =>
                            context.read<LoginCubit>().changePassword(value),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        if (state.status == OperationStatus.loading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () => context
                              .read<LoginCubit>()
                              .signInWithEmailAndPassword(),
                          child: state.status == OperationStatus.loading
                              ? const CircularProgressIndicator()
                              : const CustomTitleSmallText(text: 'Sign In'),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      const CustomTitleSmallText(
                        text: 'OR',
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: const Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomLabelLargeText(
                        text: 'Don\'t have an account?',
                        color: Colors.black,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, RegistrationScreen.routeName),
                        child: CustomLabelLargeText(
                          text: 'Go to registration',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.user != null) {
              Navigator.of(context)
                  .pushReplacementNamed(NavigationScreen.routeName);
            }
          },
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
