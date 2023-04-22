import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/colors.dart';
import '../../../cubits/navigation/navigation_cubit.dart';
import '../navigation_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 0.08 * size.height,
      width: size.width,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          NavigationScreen.screens.length,
          (index) => GestureDetector(
              onTap: () =>
                  context.read<NavigationCubit>().changeScreenIndex(index),
              child: const Icon(Icons.home, color: Colors.white)),
        ),
      ),
    );
  }
}
