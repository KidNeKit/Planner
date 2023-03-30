import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

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
        children: const [
          Icon(Icons.home, color: Colors.white),
        ],
      ),
    );
  }
}
