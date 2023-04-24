part of 'contacts_bloc.dart';

class ContactsState extends Equatable {
  final Map<String, List<ContactEntity>> contacts;
  final List<UserEntity> invitations;

  const ContactsState({
    required this.contacts,
    required this.invitations,
  });

  ContactsState.initial()
      : contacts = {},
        invitations = [];

  ContactsState copyWith({
    Map<String, List<ContactEntity>>? contacts,
    List<UserEntity>? invitations,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      invitations: invitations ?? this.invitations,
    );
  }

  @override
  List<Object> get props => [contacts, invitations];
}
