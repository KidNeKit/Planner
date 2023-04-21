part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class InvitationsFetched extends ContactsEvent {
  final List<ContactUser> users;

  const InvitationsFetched(this.users);

  @override
  List<Object> get props => [users];
}

class InvitationReceived extends ContactsEvent {
  final ContactUser user;

  const InvitationReceived(this.user);

  @override
  List<Object> get props => [user];
}

class InvitationConfirmed extends ContactsEvent {
  final ContactUser user;

  const InvitationConfirmed(this.user);

  @override
  List<Object> get props => [user];
}

class InvitationCanceled extends ContactsEvent {
  final ContactUser user;

  const InvitationCanceled(this.user);

  @override
  List<Object> get props => [user];
}
