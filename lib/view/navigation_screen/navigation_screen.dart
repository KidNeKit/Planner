import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/navigation_cubit.dart';
import '../home_screen/home_screen.dart';
import 'components/bottom_bar.dart';

class NavigationScreen extends StatelessWidget {
  static const String routeName = 'navigator';
  static List<Widget> screens = const [
    HomeScreen(),
  ];

  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.index],
          bottomNavigationBar: const BottomBar(),
        );
      },
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
          create: (context) => NavigationCubit(),
          child: const NavigationScreen()),
    );
  }
}
