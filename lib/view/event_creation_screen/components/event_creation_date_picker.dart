import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/event_creation/event_creation_cubit.dart';
import '../../../models/enum/months_info.dart';

import '../../../models/enum/date_options.dart';
import '../../../resources/colors.dart';
import '../../global_components/custom_calendar.dart';
import '../../global_components/custom_rounded_card.dart';
import '../../global_components/custom_text_sizes.dart';

class EventCreationDatePicker extends StatefulWidget {
  final String label;
  final DateOptions dateOption;
  const EventCreationDatePicker(
      {required this.label, required this.dateOption, super.key});

  @override
  State<EventCreationDatePicker> createState() =>
      _EventCreationDatePickerState();
}

class _EventCreationDatePickerState extends State<EventCreationDatePicker> {
  late bool _isExpanded;

  @override
  void initState() {
    _isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRoundedCard(
      child: Column(
        children: [
          Row(
            children: [
              CustomTitleSmallText(
                text: widget.label,
                color: Colors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: widget.dateOption == DateOptions.start
                    ? const StartDateTitleArea()
                    : const EndDateTitleArea(),
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
          if (_isExpanded) const SizedBox(height: 10.0),
          if (_isExpanded)
            CustomCalendar(
              onDateSelectedFunc: (year, month, day) =>
                  widget.dateOption == DateOptions.start
                      ? context
                          .read<EventCreationCubit>()
                          .changeStartDate(year, month, day)
                      : context
                          .read<EventCreationCubit>()
                          .changeEndDate(year, month, day),
            ),
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

class StartDateTitleArea extends StatelessWidget {
  const StartDateTitleArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreationCubit, EventCreationState>(
      buildWhen: (previous, current) => previous.startDate != current.startDate,
      builder: (context, state) {
        DateTime? date = state.startDate;
        String text = date == null
            ? 'Pick a date'
            : '${MonthsInfo.getMonthByOrder(date.month).fullName} ${date.day}';
        return CustomTitleSmallText(
          text: text,
          color: neonGreen,
        );
      },
    );
  }
}

class EndDateTitleArea extends StatelessWidget {
  const EndDateTitleArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCreationCubit, EventCreationState>(
      buildWhen: (previous, current) => previous.endDate != current.endDate,
      builder: (context, state) {
        DateTime? date = state.endDate;
        String text = date == null
            ? 'Pick a date'
            : '${MonthsInfo.getMonthByOrder(date.month).fullName} ${date.day}';
        return CustomTitleSmallText(
          text: text,
          color: neonGreen,
        );
      },
    );
  }
}
