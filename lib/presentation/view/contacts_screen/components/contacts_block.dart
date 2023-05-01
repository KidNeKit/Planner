import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/domain/entities/user_entity.dart';
import 'package:planner/resources/colors.dart';

import '../../../../domain/entities/contact_entity.dart';
import '../../../blocs/contacts/contacts_bloc.dart';
import '../../global_components/custom_text_sizes.dart';

class ContactsBlock extends StatelessWidget {
  const ContactsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        log(state.contacts.toString());
        return state.contacts.isEmpty
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => log('change contacts filter'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_downward),
                          CustomLabelLargeText(
                            text: 'Surname',
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (ctx, index) => LetterGroupItem(
                      letter: state.contacts.entries.elementAt(index).key,
                      users: state.contacts.entries.elementAt(index).value,
                    ),
                    separatorBuilder: (ctx, index) =>
                        const SizedBox(height: 5.0),
                    itemCount: state.contacts.length,
                  ),
                ],
              );
      },
    );
  }
}

class LetterGroupItem extends StatelessWidget {
  final String letter;
  final List<ContactEntity> users;

  const LetterGroupItem({required this.letter, required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Theme.of(context).primaryColor,
                thickness: 1,
              ),
            ),
            CustomLabelLargeText(
              text: letter,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        ...List.generate(
          users.length,
          (index) => ContactItem(
            user: users[index],
          ),
        ),
      ],
    );
  }
}

class ContactItem extends StatelessWidget {
  final ContactEntity user;

  const ContactItem({required this.user, super.key});

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
        text: '${user.name} ${user.surname}',
        color: Colors.black,
      ),
      subtitle: CustomLabelLargeText(
        text: '@${user.username}',
        color: Colors.black.withOpacity(0.7),
      ),
      trailing: GestureDetector(
        onTap: () => log('Opening chat: ${user.chatId}'),
        child: const Icon(Icons.message),
      ),
    );
  }
}
