import 'package:flutter/material.dart';

import 'resources/themes.dart';
import 'router/app_router.dart';
import 'view/home_screen/home_screen.dart';

void main() {
  runApp(PlannerApp());
}

class PlannerApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: baseTheme,
      onGenerateRoute: _appRouter.onGenerateRoute,
      initialRoute: HomeScreen.routeName,
    );
  }
}
