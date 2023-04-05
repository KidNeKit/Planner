import 'package:flutter/material.dart';
import 'package:planner/view/event_creation_screen/components/event_creation_date_picker.dart';
import 'package:planner/view/global_components/custom_rounded_card.dart';

import '../../global_components/custom_text_sizes.dart';

class EventCreationBody extends StatelessWidget {
  const EventCreationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [
          TitleInputCard(textLabel: 'Event Name'),
          SizedBox(height: 5.0),
          TitleInputCard(textLabel: 'Place'),
          SizedBox(height: 5.0),
          EventCreationDatePicker(label: 'Start'),
          SizedBox(height: 5.0),
          EventCreationDatePicker(label: 'End'),
        ],
      ),
    );
  }
}

class TitleInputCard extends StatelessWidget {
  final String textLabel;
  const TitleInputCard({required this.textLabel, super.key});

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
