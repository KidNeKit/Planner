import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/repositories/auth_repository.dart';

import '../../models/enum/operation_status.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthRepository _authRepository;
  RegistrationCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegistrationState.initial());

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void signUpWithEmailAndPassword() async {
    log('Current registration state: $state');
    await _authRepository.signUpWithEmailAndPassword(
        state.email, state.password);
  }
}
