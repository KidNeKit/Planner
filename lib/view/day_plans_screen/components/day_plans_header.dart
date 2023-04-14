import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/models/enum/days_of_week.dart';
import 'package:planner/models/enum/months_info.dart';

import '../../../blocs/day_plans/day_plans_bloc.dart';
import '../../../resources/colors.dart';

class DayPlansHeader extends StatefulWidget {
  const DayPlansHeader({super.key});

  @override
  State<DayPlansHeader> createState() => _DayPlansHeaderState();
}

class _DayPlansHeaderState extends State<DayPlansHeader> {
  late DateTime today;

  @override
  void initState() {
    today = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Today\'s Plan',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          today = DateTime.utc(
                              today.year, today.month, today.day - 1);
                          context
                              .read<DayPlansBloc>()
                              .add(PlansUpdateRequested(date: today));
                        });
                      },
                      child:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    Text(
                      '${DaysOfWeek.getDayOfWeekByOrder(today.weekday).fullName}, ${today.day} ${MonthsInfo.getMonthByOrder(today.month).fullName} ${today.year}',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: neonGreen),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          today = DateTime.utc(
                              today.year, today.month, today.day + 1);
                          context
                              .read<DayPlansBloc>()
                              .add(PlansUpdateRequested(date: today));
                        });
                      },
                      child: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
