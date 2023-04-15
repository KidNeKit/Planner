import 'package:flutter/material.dart';
import 'package:planner/resources/colors.dart';

import '../../global_components/custom_text_sizes.dart';

class InvitationsBlock extends StatelessWidget {
  const InvitationsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CustomTitleSmallText(
          text: 'Invitations',
          color: Colors.black,
        ),
        SizedBox(height: 10.0),
        FriendInviteItem(),
        FriendInviteItem(),
      ],
    );
  }
}

class FriendInviteItem extends StatelessWidget {
  const FriendInviteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(width: 10.0),
          const CustomLabelLargeText(
            text: 'Name Surname',
            color: Colors.black,
          ),
          const Spacer(),
          Row(
            children: const [
              CancelButton(),
              SizedBox(width: 10.0),
              ConfirmButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: neonRed,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.close,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: neonGreen,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
