import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/remote/datasources/firebase_auth_data_source.dart';
import 'data/remote/datasources/firebase_event_data_source.dart';
import 'data/remote/datasources/firebase_invitation_data_source.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/repositories/invitation_repository.dart';
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
          create: (context) => EventRepository(
            firebaseEventDataSource: FirebaseEventDataSource(
              firebaseAuth: _firebaseAuth,
              firestore: _firestore,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseAuthDataSource: FirebaseAuthDataSource(
              firebaseAuth: _firebaseAuth,
              firestore: _firestore,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => InvitationRepository(
            firebaseInvitationDataSource: FirebaseInvitationDataSource(
              firebaseAuth: _firebaseAuth,
              firestore: _firestore,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
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
              userRepository: context.read<AuthRepository>(),
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
