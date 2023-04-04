import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState.initial());

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void signInWithEmailAndPassword() {
    _authRepository.signInWithEmailAndPassword(state.email, state.password);
  }
}
