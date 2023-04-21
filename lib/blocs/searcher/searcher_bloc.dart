import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../models/search_user.dart';
import '../../repositories/invitation_repository.dart';
import '../../repositories/user_repository.dart';

part 'searcher_event.dart';
part 'searcher_state.dart';

class SearcherBloc extends Bloc<SearcherEvent, SearcherState> {
  final UserRepository _userRepository;
  final InvitationRepository _invitationRepository;

  SearcherBloc({
    required UserRepository userRepository,
    required InvitationRepository invitationRepository,
  })  : _userRepository = userRepository,
        _invitationRepository = invitationRepository,
        super(SearcherState.initial()) {
    on<SearchByNameRequested>(_onSearchByName);
    on<InviteRequested>(_onInviteRequested);
  }

  void _onSearchByName(
      SearchByNameRequested event, Emitter<SearcherState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));

    var users = await _userRepository.getUsersBySearch(event.request);
    emit(state.copyWith(status: OperationStatus.successful, users: users));
  }

  void _onInviteRequested(
      InviteRequested event, Emitter<SearcherState> emit) async {
    var users = [...state.users];
    int index = users.indexWhere((element) => element.id == event.userId);
    users[index] = users[index].copyWith(isLoading: true);
    emit(state.copyWith(users: users));
    await _invitationRepository.inviteUser(event.userId);
    var updatedUsers = [...users];
    updatedUsers[index] =
        updatedUsers[index].copyWith(isInvited: true, isLoading: false);
    emit(state.copyWith(users: updatedUsers));
  }
}
