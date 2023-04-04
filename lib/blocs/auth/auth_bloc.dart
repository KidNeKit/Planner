import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription _streamSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unauthenticated()) {
    on<UserChanged>(onUserChanged);
    on<LogoutRequested>(onLogoutRequested);

    _streamSubscription = _authRepository.user.listen((firebaseUser) {
      log('Receiving firebase user in listener: $firebaseUser');
      add(UserChanged(firebaseUser));
    });
    log('created subscription');
  }

  void onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    if (event.user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(event.user));
    }
  }

  void onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {}

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
