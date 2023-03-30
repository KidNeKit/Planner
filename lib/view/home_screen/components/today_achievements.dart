import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

class TodayAchievements extends StatelessWidget {
  const TodayAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        double width = (constraints.maxWidth - 32) / 3;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AchievementContainer(width: width),
            SizedBox(
              height: 2 / 3 * width,
              child: const VerticalDivider(),
            ),
            AchievementContainer(width: width),
            SizedBox(
              height: 2 / 3 * width,
              child: const VerticalDivider(),
            ),
            AchievementContainer(width: width),
          ],
        );
      },
    );
  }
}

class AchievementContainer extends StatelessWidget {
  final double width;
  const AchievementContainer({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      color: greenColor,
    );
  }
}
