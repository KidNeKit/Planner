import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../repositories/user_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository _userRepository;

  OnboardingCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const OnboardingState.initial());

  void changeUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void changeName(String name) {
    emit(state.copyWith(name: name));
  }

  void changeSurname(String surname) {
    emit(state.copyWith(surname: surname));
  }

  void increaseScreenIndex() {
    if (state.screenIndex == 1) return;
    emit(state.copyWith(screenIndex: state.screenIndex + 1));
  }

  void decreaseScreenIndex() {
    if (state.screenIndex == 0) return;
    emit(state.copyWith(screenIndex: state.screenIndex - 1));
  }

  void updateProfile() async {
    if (state.status == OperationStatus.loading) return;
    emit(state.copyWith(status: OperationStatus.loading));

    await _userRepository.updateUserProfile({
      'name': state.name,
      'username': state.username,
      'surname': state.surname
    });
    emit(state.copyWith(status: OperationStatus.successful));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
