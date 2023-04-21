part of 'contacts_bloc.dart';

class ContactsState extends Equatable {
  final List<CustomUser> contacts;
  final List<CustomUser> invitations;

  const ContactsState({
    required this.contacts,
    required this.invitations,
  });

  ContactsState.initial()
      : contacts = [],
        invitations = [];

  ContactsState copyWith({
    List<CustomUser>? contacts,
    List<CustomUser>? invitations,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      invitations: invitations ?? this.invitations,
    );
  }

  @override
  List<Object> get props => [contacts, invitations];
}
