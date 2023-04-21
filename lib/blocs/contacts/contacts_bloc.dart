import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/contact_user.dart';
import '../../repositories/user_repository.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final UserRepository _userRepository;

  late StreamSubscription _invitationsSubscription;

  ContactsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ContactsState.initial()) {
    _invitationsSubscription =
        _userRepository.invitationsStream.listen((invitations) {
      log('received list of invitations: $invitations');
      add(InvitationsFetched(invitations));
    });

    on<InvitationReceived>(_onInvitationUpdated);
    on<InvitationsFetched>(_onInvitationsFetched);
    on<InvitationConfirmed>(_onInvitationConfirmed);
    on<InvitationCanceled>(_onInvitationCanceled);
  }

  void _onInvitationUpdated(
      InvitationReceived event, Emitter<ContactsState> emit) {}

  void _onInvitationsFetched(
      InvitationsFetched event, Emitter<ContactsState> emit) {
    emit(state.copyWith(invitations: event.users));
  }

  void _onInvitationConfirmed(
      InvitationConfirmed event, Emitter<ContactsState> emit) async {
    await _userRepository.confirmUserInvitation(event.user);
    //emit(state.copyWith(invitations: state.invitations..remove(event.user)));
  }

  void _onInvitationCanceled(
      InvitationCanceled event, Emitter<ContactsState> emit) async {
    await _userRepository.cancelUserInvitation(event.user);
    //emit(state.copyWith(invitations: state.invitations..remove(event.user)));
  }

  @override
  Future<void> close() {
    _invitationsSubscription.cancel();
    return super.close();
  }
}
