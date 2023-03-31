import 'package:flutter/material.dart';

class DayPlansContainer extends StatelessWidget {
  const DayPlansContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
      ),
    );
  }
}
