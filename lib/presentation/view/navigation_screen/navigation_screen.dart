import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../../resources/colors.dart';
import '../../cubits/navigation/navigation_cubit.dart';
import '../contacts_screen/contacts_screen.dart';
import '../day_plans_screen/day_plans_screen.dart';
import '../event_creation_screen/event_creation_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'components/bottom_bar.dart';

class NavigationScreen extends StatelessWidget {
  static const String routeName = '/navigator';
  static List<Widget> screens = const [
    HomeScreen(),
    DayPlansScreen(),
    ContactsScreen(),
    ProfileScreen(),
  ];
  static List<Widget> icons = const [
    Icon(Icons.home, color: Colors.white),
    Icon(Icons.list, color: Colors.white),
    Icon(Icons.contact_phone, color: Colors.white),
    Icon(Icons.manage_accounts, color: Colors.white),
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
            backgroundColor: neonGreen,
            foregroundColor: primaryColor,
            onPressed: () =>
                Navigator.of(context).pushNamed(EventCreationScreen.routeName),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
          create: (context) => locator.get<NavigationCubit>(),
          child: const NavigationScreen()),
    );
  }
}
