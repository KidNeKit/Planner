import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/base_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _authRepository;
  late StreamSubscription _streamSubscription;

  AuthBloc({required BaseAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unauthenticated()) {
    on<UserChanged>(onUserChanged);
    on<UserUpdated>(onUserUpdated);
    on<LogoutRequested>(onLogoutRequested);

    _streamSubscription = _authRepository.user.listen((firebaseUser) {
      log('Receiving firebase user in listener: $firebaseUser');
      add(UserChanged(firebaseUser));
    });
  }

  void onUserChanged(UserChanged event, Emitter<AuthState> emit) async {
    if (event.user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      User user = event.user!;
      log(user.toString());
      UserEntity myUser = await _authRepository.getUserById(user.uid);
      emit(AuthState.authenticated(myUser));
    }
  }

  void onUserUpdated(UserUpdated event, Emitter<AuthState> emit) async {
    UserEntity myUser = await _authRepository.getUserById(event.userId);
    emit(AuthState.authenticated(myUser));
  }

  void onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    _authRepository.signOut();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
