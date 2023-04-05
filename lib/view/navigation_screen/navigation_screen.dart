import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/view/event_creation_screen/event_creation_screen.dart';

import '../../cubits/navigation/navigation_cubit.dart';
import '../day_plans_screen/day_plans_screen.dart';
import '../home_screen/home_screen.dart';
import 'components/bottom_bar.dart';

class NavigationScreen extends StatelessWidget {
  static const String routeName = '/navigator';
  static List<Widget> screens = const [
    HomeScreen(),
    DayPlansScreen(),
  ];

  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: screens[state.index],
          ),
          bottomNavigationBar: const BottomBar(),
          floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(EventCreationScreen.routeName)),
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
