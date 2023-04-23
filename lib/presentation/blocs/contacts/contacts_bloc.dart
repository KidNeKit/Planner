import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/base_auth_repository.dart';
import '../../../domain/repositories/base_contacts_repository.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final BaseAuthRepository _userRepository;
  final BaseContactsRepository _contactsRepository;

  late StreamSubscription _invitationsSubscription;
  late StreamSubscription _contactsSubscription;

  ContactsBloc({
    required BaseAuthRepository userRepository,
    required BaseContactsRepository invitationRepository,
  })  : _userRepository = userRepository,
        _contactsRepository = invitationRepository,
        super(ContactsState.initial()) {
    _invitationsSubscription =
        _contactsRepository.invitationsStream.listen((invitations) {
      log('received list of invitations: $invitations');
      add(InvitationsFetched(invitations));
    });
    _contactsRepository.contactsStream.listen((contacts) {
      log('received list of contacts: $contacts');
      add(ContactsFetched(contacts));
    });

    on<InvitationReceived>(_onInvitationUpdated);
    on<InvitationsFetched>(_onInvitationsFetched);
    on<InvitationConfirmed>(_onInvitationConfirmed);
    on<InvitationCanceled>(_onInvitationCanceled);
    on<ContactsFetched>(_onContactsFetched);
  }

  void _onInvitationUpdated(
      InvitationReceived event, Emitter<ContactsState> emit) {}

  void _onInvitationsFetched(
      InvitationsFetched event, Emitter<ContactsState> emit) {
    emit(state.copyWith(invitations: event.users));
  }

  void _onContactsFetched(ContactsFetched event, Emitter<ContactsState> emit) {
    emit(state.copyWith(
        contacts: _contactsRepository.getSplitedUsers(event.users)));
  }

  void _onInvitationConfirmed(
      InvitationConfirmed event, Emitter<ContactsState> emit) async {
    await _contactsRepository.confirmUserInvitation(event.user);
  }

  void _onInvitationCanceled(
      InvitationCanceled event, Emitter<ContactsState> emit) async {
    await _contactsRepository.cancelUserInvitation(event.user);
  }

  @override
  Future<void> close() {
    _invitationsSubscription.cancel();
    _contactsSubscription.cancel();
    return super.close();
  }
}
