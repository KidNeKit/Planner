import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/repositories/invitation_repository.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/contacts/contacts_bloc.dart';
import 'blocs/day_plans/day_plans_bloc.dart';
import 'cubits/registration/registration_cubit.dart';
import 'repositories/auth_repository.dart';
import 'repositories/event_repository.dart';
import 'repositories/user_repository.dart';
import 'resources/themes.dart';
import 'router/app_router.dart';
import 'view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PlannerApp());
}

class PlannerApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              AuthRepository(firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider(
          create: (context) => EventRepository(firestore: _firestore),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            firestore: _firestore,
            firebaseAuth: _firebaseAuth,
          ),
        ),
        RepositoryProvider(
          create: (context) => InvitationRepository(
            firestore: _firestore,
            firebaseAuth: _firebaseAuth,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => RegistrationCubit(
                authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                DayPlansBloc(eventRepository: context.read<EventRepository>()),
          ),
          BlocProvider(
            create: (context) => ContactsBloc(
              userRepository: context.read<UserRepository>(),
              invitationRepository: context.read<InvitationRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: baseTheme,
          onGenerateRoute: _appRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
