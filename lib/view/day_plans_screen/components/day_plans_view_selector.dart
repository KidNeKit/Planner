import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/day_plans/day_plans_bloc.dart';
import '../../global_components/custom_text_sizes.dart';

class DayPlansViewSelector extends StatelessWidget {
  const DayPlansViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.all(15.0).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: LayoutBuilder(builder: (ctx, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                BlocBuilder<DayPlansBloc, DayPlansState>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      padding: EdgeInsets.only(
                          left: state.plansView == DayPlansView.table
                              ? 0
                              : constraints.maxWidth / 2),
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        width: constraints.maxWidth / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: const [
                    SelectorOption(
                        optionText: 'Table View',
                        plansView: DayPlansView.table),
                    SelectorOption(
                      optionText: 'List View',
                      plansView: DayPlansView.list,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class SelectorOption extends StatelessWidget {
  final String optionText;
  final DayPlansView plansView;
  const SelectorOption(
      {required this.optionText, required this.plansView, super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => context
            .read<DayPlansBloc>()
            .add(PlansViewSelected(plansView: plansView)),
        child: Center(
          child: CustomLabelLargeText(text: optionText, color: Colors.black),
        ),
      ),
    );
  }
}
