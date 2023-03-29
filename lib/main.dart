import 'package:flutter/material.dart';
import 'package:planner/resources/themes.dart';

void main() {
  runApp(const PlannerApp());
}

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyApp(),
      theme: baseTheme,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
