import 'package:flutter/material.dart';

import '../add_contact_screen/add_contact_screen.dart';
import '../global_components/custom_search.dart';
import 'components/invitations_block.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contacts',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AddContactScreen.routeName),
                        child: const Icon(Icons.add_box_rounded,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  CustomSearch(onChangedFunc: (value) {}),
                  const SizedBox(height: 10.0),
                  Text('Last Search',
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: const [
                  InvitationsBlock(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
