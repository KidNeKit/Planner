part of 'contacts_bloc.dart';

class ContactsState extends Equatable {
  final List<ContactUser> contacts;
  final List<ContactUser> invitations;

  const ContactsState({
    required this.contacts,
    required this.invitations,
  });

  ContactsState.initial()
      : contacts = [],
        invitations = [];

  ContactsState copyWith({
    List<ContactUser>? contacts,
    List<ContactUser>? invitations,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      invitations: invitations ?? this.invitations,
    );
  }

  @override
  List<Object> get props => [contacts, invitations];
}
