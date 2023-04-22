import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/domain/entities/user_entity.dart';

import '../../../../resources/colors.dart';
import '../../../blocs/contacts/contacts_bloc.dart';
import '../../global_components/custom_text_sizes.dart';

class InvitationsBlock extends StatelessWidget {
  const InvitationsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return state.invitations.isEmpty
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTitleSmallText(
                    text: 'Invitations',
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10.0),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (context, index) =>
                        FriendInviteItem(user: state.invitations[index]),
                    itemCount: state.invitations.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5.0),
                  ),
                ],
              );
      },
    );
  }
}

class FriendInviteItem extends StatelessWidget {
  final UserEntity user;

  const FriendInviteItem({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 46.0,
        width: 46.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      title: CustomTitleSmallText(
          text: '${user.name} ${user.surname}', color: Colors.black),
      subtitle: CustomLabelLargeText(
        text: '@${user.username}',
        color: Colors.black.withOpacity(0.7),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CancelButton(user: user),
          const SizedBox(width: 10.0),
          ConfirmButton(user: user),
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final UserEntity user;

  const CancelButton({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ContactsBloc>().add(InvitationCanceled(user)),
      child: Container(
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
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final UserEntity user;

  const ConfirmButton({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ContactsBloc>().add(InvitationConfirmed(user)),
      child: Container(
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
      ),
    );
  }
}
