import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/onboarding/onboarding_cubit.dart';
import '../../global_components/custom_text_sizes.dart';
import 'location_screen.dart';
import 'name_screen.dart';

class OnboardingContainer extends StatelessWidget {
  static List<Widget> screens = const [
    NameScreen(),
    LocationScreen(),
  ];

  const OnboardingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Container(
          height: 0.7 * size.height,
          width: 0.8 * size.width,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              bool isLastScreen = state.screenIndex == screens.length - 1;
              return Column(
                children: [
                  screens[state.screenIndex],
                  const Spacer(),
                  Row(
                    children: [
                      const OnboardingBackButton(),
                      const SizedBox(width: 10.0),
                      OnboardingNextButton(isLastScreen: isLastScreen),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OnboardingBackButton extends StatelessWidget {
  const OnboardingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => context.read<OnboardingCubit>().decreaseScreenIndex(),
        child: const CustomTitleSmallText(text: 'Back'),
      ),
    );
  }
}

class OnboardingNextButton extends StatelessWidget {
  final bool isLastScreen;

  const OnboardingNextButton({this.isLastScreen = false, super.key});

  @override
  Widget build(BuildContext context) {
    Function() onPressedFunc = isLastScreen
        ? () => context.read<OnboardingCubit>().updateProfile()
        : () => context.read<OnboardingCubit>().increaseScreenIndex();
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressedFunc,
        child: CustomTitleSmallText(text: isLastScreen ? 'Finish' : 'Next'),
      ),
    );
  }
}
