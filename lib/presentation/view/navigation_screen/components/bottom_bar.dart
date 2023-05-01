import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/navigation/navigation_cubit.dart';
import '../navigation_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomAppBar(
      notchMargin: 5.0,
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        height: 0.08 * size.height,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            NavigationScreen.screens.length,
            (index) => GestureDetector(
              onTap: () =>
                  context.read<NavigationCubit>().changeScreenIndex(index),
              child: NavigationScreen.icons[index],
            ),
          ),
        ),
      ),
    );
  }
}
