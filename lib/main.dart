import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependency_injection.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/contacts/contacts_bloc.dart';
import 'presentation/blocs/day_plans/day_plans_bloc.dart';
import 'presentation/cubits/registration/registration_cubit.dart';
import 'presentation/view/splash_screen/splash_screen.dart';
import 'resources/themes.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initDI();
  runApp(const PlannerApp());
}

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator.get<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => locator.get<RegistrationCubit>(),
        ),
        BlocProvider(
          create: (context) => locator.get<DayPlansBloc>(),
        ),
        BlocProvider(
          create: (context) => locator.get<ContactsBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: baseTheme,
        onGenerateRoute: locator.get<AppRouter>().onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
