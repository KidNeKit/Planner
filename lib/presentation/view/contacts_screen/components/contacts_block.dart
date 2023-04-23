import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/domain/entities/user_entity.dart';

import '../../../blocs/contacts/contacts_bloc.dart';
import '../../global_components/custom_text_sizes.dart';

class ContactsBlock extends StatelessWidget {
  const ContactsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
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
                            text: 'Name',
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (ctx, index) =>
                        ContactItem(user: state.contacts[index]),
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

class ContactItem extends StatelessWidget {
  final UserEntity user;

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
    );
  }
}
