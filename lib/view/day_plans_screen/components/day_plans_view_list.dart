import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/day_plans/day_plans_bloc.dart';
import '../../../models/enum/operation_status.dart';

class DayPlansViewList extends StatelessWidget {
  const DayPlansViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayPlansBloc, DayPlansState>(
      builder: (context, state) {
        if (state.status == OperationStatus.loading ||
            state.status == OperationStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // } else if (state.status == OperationStatus.failed) {
        //   return Center(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Icon(Icons.circle_outlined),
        //         Text('Try again'),
        //       ],
        //     ),
        //   );
        // }
        return const Text('List');
      },
    );
  }
}
