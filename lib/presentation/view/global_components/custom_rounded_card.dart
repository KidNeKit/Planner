import 'package:flutter/material.dart';

class CustomRoundedCard extends StatelessWidget {
  final Widget child;

  const CustomRoundedCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: child,
      ),
    );
  }
}
