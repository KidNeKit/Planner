import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/event_creation/event_creation_cubit.dart';
import '../../../resources/colors.dart';
import '../../global_components/custom_text_sizes.dart';

class EventCreationHeader extends StatelessWidget {
  const EventCreationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: CustomLabelLargeText(
                  text: 'Cancel',
                  color: neonRed,
                ),
              ),
              const CustomTitleSmallText(text: 'Event Creation'),
              TextButton(
                onPressed: () =>
                    context.read<EventCreationCubit>().createEvent(),
                child: CustomLabelLargeText(
                  text: 'Save',
                  color: neonGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
