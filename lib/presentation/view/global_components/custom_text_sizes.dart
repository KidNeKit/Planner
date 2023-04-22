import 'package:flutter/material.dart';

class CustomBodySmallText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomBodySmallText(
      {required this.text, this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
    );
  }
}

class CustomTitleMediumText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomTitleMediumText(
      {required this.text, this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
    );
  }
}

class CustomTitleSmallText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomTitleSmallText(
      {required this.text, this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: color),
    );
  }
}

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
