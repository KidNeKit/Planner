import 'package:flutter/material.dart';

import '../../global_components/custom_text_sizes.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 0.3 * size.width,
            width: 0.3 * size.width,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CustomTitleSmallText(text: 'Name'),
              CustomTitleSmallText(text: 'Surname'),
              CustomTitleSmallText(text: 'City, Country'),
            ],
          ),
        ],
      )),
    );
  }
}
