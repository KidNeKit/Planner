import 'package:flutter/material.dart';

import '../../../global_components/custom_text_sizes.dart';

class PersonalDataScreen extends StatelessWidget {
  static const String routeName = '/personalData';
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const CustomTitleSmallText(text: 'Personal Data'),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => const PersonalDataScreen(),
    );
  }
}
