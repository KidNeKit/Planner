import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/models/custom_user.dart';

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
  }

  void onUserChanged(UserChanged event, Emitter<AuthState> emit) async {
    if (event.user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      User user = event.user!;
      String username = await _authRepository.getUserUsernameById(user.uid);
      CustomUser myUser =
          CustomUser(id: user.uid, email: user.email!, username: username);
      emit(AuthState.authenticated(myUser));
    }
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
