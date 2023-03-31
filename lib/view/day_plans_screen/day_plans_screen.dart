import 'package:flutter/material.dart';

import 'components/day_plans_header.dart';
import 'components/day_plans_view_selector.dart';

class DayPlansScreen extends StatelessWidget {
  const DayPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DayPlansHeader(),
        DayPlansViewSelector(),
      ],
    );
  }
}
