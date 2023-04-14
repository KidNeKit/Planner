import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/day_plans/day_plans_bloc.dart';
import 'day_plans_view_list.dart';
import 'day_plans_view_table.dart';

class DayPlansContainer extends StatefulWidget {
  const DayPlansContainer({super.key});

  @override
  State<DayPlansContainer> createState() => _DayPlansContainerState();
}

class _DayPlansContainerState extends State<DayPlansContainer> {
  @override
  void initState() {
    context
        .read<DayPlansBloc>()
        .add(PlansUpdateRequested(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15.0),
        color: const Color(0xFFF8F8FD),
        child:
            BlocBuilder<DayPlansBloc, DayPlansState>(builder: (context, state) {
          log('state: $state');
          if (state.plans.isEmpty) {
            return Center(
              child: Text(
                'There is no event for today',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black),
              ),
            );
          }
          return state.plansView == DayPlansView.table
              ? const DayPlansViewTable()
              : const DayPlansViewList();
        }),
      ),
    );
  }
}
