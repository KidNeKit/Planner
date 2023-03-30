import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 0.5 * size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            greenColor,
            darkColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
    );
  }
}
