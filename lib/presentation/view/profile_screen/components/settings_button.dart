import 'package:flutter/material.dart';

import '../../global_components/custom_text_sizes.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onPressedFunc;

  const SettingsButton(
      {required this.text,
      this.color = Colors.white,
      required this.onPressedFunc,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedFunc,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
        ),
        child: CustomTitleMediumText(
          text: text,
          color: Colors.black,
        ),
      ),
    );
  }
}
