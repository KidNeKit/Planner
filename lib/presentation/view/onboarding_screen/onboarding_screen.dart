import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../domain/entities/enum/operation_status.dart';
import '../../cubits/onboarding/onboarding_cubit.dart';
import '../navigation_screen/navigation_screen.dart';
import 'components/onboarding_container.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == OperationStatus.successful) {
            Navigator.of(context)
                .pushReplacementNamed(NavigationScreen.routeName);
          }
        },
        child: const OnboardingContainer(),
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => OnboardingCubit(
          userRepository: context.read<AuthRepository>(),
        ),
        child: const OnboardingScreen(),
      ),
    );
  }
}
