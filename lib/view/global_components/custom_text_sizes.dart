import 'package:flutter/material.dart';

class CustomLabelLargeText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomLabelLargeText(
      {required this.text, this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: color),
    );
  }
}
