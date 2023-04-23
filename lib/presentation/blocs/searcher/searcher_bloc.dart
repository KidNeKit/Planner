import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/enum/operation_status.dart';
import '../../../domain/entities/search_user.dart';
import '../../../domain/repositories/base_auth_repository.dart';
import '../../../domain/repositories/base_contacts_repository.dart';

part 'searcher_event.dart';
part 'searcher_state.dart';

class SearcherBloc extends Bloc<SearcherEvent, SearcherState> {
  final BaseAuthRepository _userRepository;
  final BaseContactsRepository _contactsRepository;

  SearcherBloc({
    required BaseAuthRepository userRepository,
    required BaseContactsRepository invitationRepository,
  })  : _userRepository = userRepository,
        _contactsRepository = invitationRepository,
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
    await _contactsRepository.inviteUser(event.userId);
    var updatedUsers = [...users];
    updatedUsers[index] =
        updatedUsers[index].copyWith(isInvited: true, isLoading: false);
    emit(state.copyWith(users: updatedUsers));
  }
}
