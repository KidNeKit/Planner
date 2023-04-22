import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'data/remote/datasources/base_firebase_auth_data_source.dart';
import 'data/remote/datasources/base_firebase_event_data_source.dart';
import 'data/remote/datasources/base_firebase_invitation_data_source.dart';
import 'data/remote/datasources/firebase_auth_data_source.dart';
import 'data/remote/datasources/firebase_event_data_source.dart';
import 'data/remote/datasources/firebase_invitation_data_source.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/repositories/invitation_repository.dart';
import 'domain/repositories/base_auth_repository.dart';
import 'domain/repositories/base_event_repository.dart';
import 'domain/repositories/base_invitation_repository.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/contacts/contacts_bloc.dart';
import 'presentation/blocs/day_plans/day_plans_bloc.dart';
import 'presentation/blocs/searcher/searcher_bloc.dart';
import 'presentation/cubits/event_creation/event_creation_cubit.dart';
import 'presentation/cubits/login/login_cubit.dart';
import 'presentation/cubits/navigation/navigation_cubit.dart';
import 'presentation/cubits/onboarding/onboarding_cubit.dart';
import 'presentation/cubits/registration/registration_cubit.dart';
import 'router/app_router.dart';

GetIt locator = GetIt.instance;

Future<void> initDI() async {
  //bloc
  locator.registerFactory<AuthBloc>(
      () => AuthBloc(authRepository: locator.call()));
  locator.registerFactory<ContactsBloc>(() => ContactsBloc(
      userRepository: locator.call(), invitationRepository: locator.call()));
  locator.registerFactory<DayPlansBloc>(
      () => DayPlansBloc(eventRepository: locator.call()));
  locator.registerFactory<SearcherBloc>(() => SearcherBloc(
      userRepository: locator.call(), invitationRepository: locator.call()));

  //cubit
  locator.registerFactory<EventCreationCubit>(
      () => EventCreationCubit(eventRepository: locator.call()));
  locator.registerFactory<LoginCubit>(
      () => LoginCubit(authRepository: locator.call()));
  locator.registerFactory<NavigationCubit>(() => NavigationCubit());
  locator.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(userRepository: locator.call()));
  locator.registerFactory<RegistrationCubit>(
      () => RegistrationCubit(authRepository: locator.call()));

  //repository
  locator.registerLazySingleton<BaseEventRepository>(
      () => EventRepository(firebaseEventDataSource: locator.call()));
  locator.registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(firebaseAuthDataSource: locator.call()));
  locator.registerLazySingleton<BaseInvitationRepository>(
      () => InvitationRepository(firebaseInvitationDataSource: locator.call()));

  //datasource
  locator.registerLazySingleton<BaseFirebaseEventDataSource>(() =>
      FirebaseEventDataSource(
          firebaseAuth: locator.call(), firestore: locator.call()));
  locator.registerLazySingleton<BaseFirebaseAuthDataSource>(() =>
      FirebaseAuthDataSource(
          firebaseAuth: locator.call(), firestore: locator.call()));
  locator.registerLazySingleton<BaseFirebaseInvitationDataSource>(() =>
      FirebaseInvitationDataSource(
          firebaseAuth: locator.call(),
          firestore: locator.call(),
          firebaseAuthDataSource: locator.call()));

  //other
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}
