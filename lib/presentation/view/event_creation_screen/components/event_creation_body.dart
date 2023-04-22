import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/enum/date_options.dart';
import '../../../cubits/event_creation/event_creation_cubit.dart';
import '../../global_components/custom_rounded_card.dart';
import '../../global_components/custom_text_sizes.dart';
import 'event_creation_date_picker.dart';

class EventCreationBody extends StatelessWidget {
  const EventCreationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleInputCard(
                textLabel: 'Event Name',
                onChangeFunc: (value) =>
                    context.read<EventCreationCubit>().changeEventName(value),
              ),
              const SizedBox(height: 5.0),
              TitleInputCard(
                textLabel: 'Place',
                onChangeFunc: (value) => context
                    .read<EventCreationCubit>()
                    .changeEventLocation(value),
              ),
              const SizedBox(height: 5.0),
              const EventCreationDatePicker(
                label: 'Start',
                dateOption: DateOptions.start,
              ),
              const SizedBox(height: 5.0),
              const EventCreationDatePicker(
                label: 'End',
                dateOption: DateOptions.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleInputCard extends StatelessWidget {
  final String textLabel;
  final Function(String) onChangeFunc;
  const TitleInputCard(
      {required this.textLabel, required this.onChangeFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleSmallText(
            text: textLabel,
            color: Colors.black,
          ),
          const SizedBox(height: 5.0),
          TextField(
            onChanged: onChangeFunc,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black),
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.5),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
