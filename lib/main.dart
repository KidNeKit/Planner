import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/day_plans/day_plans_bloc.dart';
import 'resources/themes.dart';
import 'router/app_router.dart';
import 'view/navigation_screen/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PlannerApp());
}

class PlannerApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DayPlansBloc(),
        ),
      ],
      child: MaterialApp(
        theme: baseTheme,
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: NavigationScreen.routeName,
      ),
    );
  }
}
