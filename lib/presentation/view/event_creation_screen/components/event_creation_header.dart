import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/enum/operation_status.dart';
import '../../../../resources/colors.dart';
import '../../../cubits/event_creation/event_creation_cubit.dart';
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
            children: const [
              CancelButton(),
              CustomTitleSmallText(text: 'Event Creation'),
              SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCreationCubit, EventCreationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) => Navigator.of(context).pop(),
      listenWhen: (previous, current) =>
          current.status == OperationStatus.successful,
      builder: (context, state) {
        return TextButton(
          onPressed: () => context.read<EventCreationCubit>().createEvent(),
          child: state.status == OperationStatus.loading
              ? const CircularProgressIndicator()
              : CustomLabelLargeText(
                  text: 'Save',
                  color: neonGreen,
                ),
        );
      },
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: CustomLabelLargeText(
        text: 'Cancel',
        color: neonRed,
      ),
    );
  }
}
