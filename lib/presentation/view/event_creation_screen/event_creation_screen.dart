import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection.dart';
import '../../cubits/event_creation/event_creation_cubit.dart';
import 'components/event_creation_body.dart';
import 'components/event_creation_header.dart';

class EventCreationScreen extends StatelessWidget {
  static const String routeName = '/eventCreation';
  const EventCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          EventCreationHeader(),
          EventCreationBody(),
        ],
      ),
    );
  }

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => locator.get<EventCreationCubit>(),
        child: const EventCreationScreen(),
      ),
    );
  }
}
