import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../models/enum/search_user.dart';
import '../../repositories/user_repository.dart';

part 'searcher_event.dart';
part 'searcher_state.dart';

class SearcherBloc extends Bloc<SearcherEvent, SearcherState> {
  final UserRepository _userRepository;

  SearcherBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
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

  void _onInviteRequested(InviteRequested event, Emitter<SearcherState> emit) {}
}