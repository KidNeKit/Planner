import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/onboarding/onboarding_cubit.dart';
import '../../global_components/custom_text_field.dart';

class NameScreen extends StatelessWidget {
  const NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            onChangedFunc: (value) =>
                context.read<OnboardingCubit>().changeUsername(value),
            labelText: 'Username'),
        const SizedBox(height: 10.0),
        CustomTextField(
            onChangedFunc: (value) =>
                context.read<OnboardingCubit>().changeName(value),
            labelText: 'Name'),
        const SizedBox(height: 10.0),
        CustomTextField(
            onChangedFunc: (value) =>
                context.read<OnboardingCubit>().changeSurname(value),
            labelText: 'Surname'),
      ],
    );
  }
}
