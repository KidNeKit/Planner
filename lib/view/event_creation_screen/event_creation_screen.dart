import 'package:flutter/material.dart';

import 'components/event_creation_body.dart';
import 'components/event_creation_header.dart';

class EventCreationScreen extends StatelessWidget {
  static const String routeName = '/event-creation';
  const EventCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          EventCreationHeader(),
          EventCreationBody(),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => const EventCreationScreen(),
    );
  }
}
