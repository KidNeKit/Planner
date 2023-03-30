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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AchievementContainer(width: width),
            SizedBox(
              height: 1 / 2 * width,
              child: VerticalDivider(color: neonGreen.withOpacity(0.5)),
            ),
            AchievementContainer(width: width),
            SizedBox(
              height: 1 / 2 * width,
              child: VerticalDivider(color: neonGreen.withOpacity(0.5)),
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
      width: width,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('99', style: Theme.of(context).textTheme.bodyLarge),
          Text('Planned Tasks', style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
