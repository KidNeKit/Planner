part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class InvitationsFetched extends ContactsEvent {
  final List<UserEntity> users;

  const InvitationsFetched(this.users);

  @override
  List<Object> get props => [users];
}

class ContactsFetched extends ContactsEvent {
  final List<ContactEntity> users;

  const ContactsFetched(this.users);

  @override
  List<Object> get props => [users];
}

class InvitationConfirmed extends ContactsEvent {
  final UserEntity user;

  const InvitationConfirmed(this.user);

  @override
  List<Object> get props => [user];
}

class InvitationCanceled extends ContactsEvent {
  final UserEntity user;

  const InvitationCanceled(this.user);

  @override
  List<Object> get props => [user];
}
