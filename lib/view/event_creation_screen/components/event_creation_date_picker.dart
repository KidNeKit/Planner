import 'package:flutter/material.dart';
import 'package:planner/view/global_components/custom_calendar.dart';

import '../../../resources/colors.dart';
import '../../global_components/custom_rounded_card.dart';
import '../../global_components/custom_text_sizes.dart';

class EventCreationDatePicker extends StatelessWidget {
  final String label;
  const EventCreationDatePicker({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRoundedCard(
      child: Column(
        children: [
          Row(
            children: [
              CustomTitleSmallText(
                text: label,
                color: Colors.black,
              ),
              const Spacer(),
              CustomTitleSmallText(
                text: 'Pick a date',
                color: neonGreen,
              ),
              const SizedBox(width: 10.0),
              const TimeContainer(),
              const SizedBox(width: 3.0),
              const CustomTitleSmallText(
                text: ':',
                color: Colors.black,
              ),
              const SizedBox(width: 3.0),
              const TimeContainer(),
            ],
          ),
          const SizedBox(height: 10.0),
          const CustomCalendar(),
        ],
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  const TimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
      decoration: BoxDecoration(
        border: Border.all(color: neonGreen, width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: const CustomTitleSmallText(
        text: '00',
        color: Colors.black,
      ),
    );
  }
}
