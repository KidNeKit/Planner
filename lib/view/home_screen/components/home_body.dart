import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import 'home_cards.dart';
import 'today_achievements.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          Text('Hello, Username',
              style: Theme.of(context).textTheme.titleMedium),
          Text(
            'Thursday, 30 Mar 2023',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: neonGreen),
          ),
          const SizedBox(height: 30.0),
          const TodayAchievements(),
          const SizedBox(height: 50.0),
          //const HomeCards(),
        ],
      ),
    );
  }
}
