import 'package:flutter/material.dart';
import 'package:planner/resources/colors.dart';

class DayPlansScreen extends StatelessWidget {
  const DayPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Today\'s Plan',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                        Text(
                          'Thursday, 30 Mar 2023',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: neonGreen),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
