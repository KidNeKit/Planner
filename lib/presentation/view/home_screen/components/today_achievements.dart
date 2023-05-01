import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/colors.dart';
import '../../../blocs/day_plans/day_plans_bloc.dart';

class TodayAchievements extends StatefulWidget {
  const TodayAchievements({super.key});

  @override
  State<TodayAchievements> createState() => _TodayAchievementsState();
}

class _TodayAchievementsState extends State<TodayAchievements> {
  @override
  void initState() {
    context
        .read<DayPlansBloc>()
        .add(PlansUpdateRequested(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlansBloc, DayPlansState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (_, constraints) {
            double width = (constraints.maxWidth - 32) / 3;
            var completedTasks = state.plans
                .where((event) => event.endDate.isBefore(DateTime.now()))
                .length;
            var activeTasks = state.plans
                .where((event) =>
                    event.startDate.isBefore(DateTime.now()) &&
                    event.endDate.isAfter(DateTime.now()))
                .length;
            var plannedTasks = state.plans
                .where((event) => event.startDate.isAfter(DateTime.now()))
                .length;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AchievementContainer(
                    text: 'Completed Tasks',
                    count: completedTasks.toString(),
                    width: width),
                SizedBox(
                  height: 1 / 2 * width,
                  child: VerticalDivider(color: neonGreen.withOpacity(0.5)),
                ),
                AchievementContainer(
                    text: 'Tasks In Progress',
                    count: activeTasks.toString(),
                    width: width),
                SizedBox(
                  height: 1 / 2 * width,
                  child: VerticalDivider(color: neonGreen.withOpacity(0.5)),
                ),
                AchievementContainer(
                    text: 'Planned Tasks',
                    count: plannedTasks.toString(),
                    width: width),
              ],
            );
          },
        );
      },
    );
  }
}

class AchievementContainer extends StatelessWidget {
  final String count;
  final String text;
  final double width;

  const AchievementContainer(
      {required this.text,
      required this.width,
      required this.count,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count, style: Theme.of(context).textTheme.bodyLarge),
          Text(text, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
