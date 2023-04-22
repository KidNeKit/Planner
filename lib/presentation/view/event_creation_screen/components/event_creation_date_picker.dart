import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/enum/date_options.dart';
import '../../../../domain/entities/enum/months_info.dart';
import '../../../../resources/colors.dart';
import '../../../cubits/event_creation/event_creation_cubit.dart';
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
              HourContainer(dateOptions: widget.dateOption),
              const SizedBox(width: 3.0),
              const CustomTitleSmallText(
                text: ':',
                color: Colors.black,
              ),
              const SizedBox(width: 3.0),
              MinuteContainer(dateOptions: widget.dateOption),
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

class HourContainer extends StatelessWidget {
  final DateOptions dateOptions;
  const HourContainer({required this.dateOptions, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
      decoration: BoxDecoration(
        border: Border.all(color: neonGreen, width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: PageView.builder(
        onPageChanged: (value) => dateOptions == DateOptions.start
            ? context.read<EventCreationCubit>().changeStartHours(value)
            : context.read<EventCreationCubit>().changeEndHours(value),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Center(
          child: CustomTitleSmallText(
            text: index < 10 ? '0$index' : index.toString(),
            color: Colors.black,
          ),
        ),
        itemCount: 24,
      ),
    );
  }
}

class MinuteContainer extends StatelessWidget {
  final DateOptions dateOptions;
  const MinuteContainer({required this.dateOptions, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
      decoration: BoxDecoration(
        border: Border.all(color: neonGreen, width: 2.0),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: PageView.builder(
        onPageChanged: (value) => dateOptions == DateOptions.start
            ? context.read<EventCreationCubit>().changeStartMinutes(value)
            : context.read<EventCreationCubit>().changeEndMinutes(value),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Center(
          child: CustomTitleSmallText(
            text: index < 10 ? '0$index' : index.toString(),
            color: Colors.black,
          ),
        ),
        itemCount: 60,
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
