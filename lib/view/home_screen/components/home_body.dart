import 'package:flutter/material.dart';

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
          SafeArea(
            child: Text('Hello, Username',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white)),
          ),
          Text(
            'Thursday, 30 Mar 2023',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 50.0),
          const TodayAchievements(),
          const SizedBox(height: 50.0),
          const HomeCards(),
        ],
      ),
    );
  }
}
