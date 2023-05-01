import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/enum/days_of_week.dart';
import '../../../../domain/entities/enum/months_info.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../resources/colors.dart';
import '../../../blocs/auth/auth_bloc.dart';
import 'home_cards.dart';
import 'today_achievements.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late DateTime today;

  @override
  void initState() {
    today = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              UserEntity user = state.user!;
              return Text(
                  'Hello, ${user.name.isEmpty ? user.username : user.name}',
                  style: Theme.of(context).textTheme.titleMedium);
            },
          ),
          Text(
            '${DaysOfWeek.getDayOfWeekByOrder(today.weekday).fullName}, ${today.day} ${MonthsInfo.getMonthByOrder(today.month).fullName} ${today.year}',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: neonGreen),
          ),
          const SizedBox(height: 30.0),
          const TodayAchievements(),
          const SizedBox(height: 50.0),
          const HomeCards(),
        ],
      ),
    );
  }
}
