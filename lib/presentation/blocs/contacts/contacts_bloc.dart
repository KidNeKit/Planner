import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/base_auth_repository.dart';
import '../../../domain/repositories/base_invitation_repository.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final BaseAuthRepository _userRepository;
  final BaseInvitationRepository _invitationRepository;

  late StreamSubscription _invitationsSubscription;

  ContactsBloc({
    required BaseAuthRepository userRepository,
    required BaseInvitationRepository invitationRepository,
  })  : _userRepository = userRepository,
        _invitationRepository = invitationRepository,
        super(ContactsState.initial()) {
    _invitationsSubscription =
        _invitationRepository.invitationsStream.listen((invitations) {
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
    await _invitationRepository.confirmUserInvitation(event.user);
    //emit(state.copyWith(invitations: state.invitations..remove(event.user)));
  }

  void _onInvitationCanceled(
      InvitationCanceled event, Emitter<ContactsState> emit) async {
    await _invitationRepository.cancelUserInvitation(event.user);
    //emit(state.copyWith(invitations: state.invitations..remove(event.user)));
  }

  @override
  Future<void> close() {
    _invitationsSubscription.cancel();
    return super.close();
  }
}
