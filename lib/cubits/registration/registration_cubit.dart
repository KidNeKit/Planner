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

  void changeSecondPassword(String password) {
    emit(state.copyWith(secondPassword: password));
  }

  void signUpWithEmailAndPassword() async {
    emit(state.copyWith(status: OperationStatus.loading));
    try {
      if (state.password != state.secondPassword) {
        throw Exception('Password missamtch');
      }
      await _authRepository.signUpWithEmailAndPassword(
          state.email, state.password);
    } catch (e) {
      log('Error: $e');
      emit(state.copyWith(status: OperationStatus.failed));
      return;
    }
    emit(state.copyWith(status: OperationStatus.successful));
  }
}
