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
    context.read<DayPlansBloc>().add(PlansUpdateRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: BlocBuilder<DayPlansBloc, DayPlansState>(
          builder: (context, state) => state.plansView == DayPlansView.table
              ? const DayPlansViewTable()
              : const DayPlansViewList(),
        ),
      ),
    );
  }
}
