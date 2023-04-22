import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../login_screen/login_screen.dart';
import '../navigation_screen/navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log('listener got state: $state');
        if (state.user == null) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        } else {
          Navigator.of(context)
              .pushReplacementNamed(NavigationScreen.routeName);
        }
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              'Splash',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => const SplashScreen(),
    );
  }
}
