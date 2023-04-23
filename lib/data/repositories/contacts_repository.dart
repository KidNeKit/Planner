import '../../domain/entities/user_entity.dart';
import '../remote/datasources/base_firebase_contacts_data_source.dart';
import '../../domain/repositories/base_contacts_repository.dart';

class ContactsRepository extends BaseContactsRepository {
  final BaseFirebaseContactsDataSource _firebaseContactsDataSource;

  ContactsRepository(
      {required BaseFirebaseContactsDataSource firebaseInvitationDataSource})
      : _firebaseContactsDataSource = firebaseInvitationDataSource;

  @override
  Stream<List<UserEntity>> get invitationsStream =>
      _firebaseContactsDataSource.invitationsStream;

  @override
  Stream<List<UserEntity>> get contactsStream =>
      _firebaseContactsDataSource.contactsStream;

  @override
  Future<void> inviteUser(String userId) async =>
      await _firebaseContactsDataSource.inviteUser(userId);

  @override
  Future<void> cancelUserInvitation(UserEntity user) async =>
      await _firebaseContactsDataSource.cancelUserInvitation(user);

  @override
  Future<void> confirmUserInvitation(UserEntity user) async =>
      await _firebaseContactsDataSource.confirmUserInvitation(user);

  @override
  Map<String, List<UserEntity>> getSplitedUsers(List<UserEntity> users) {
    return _firebaseContactsDataSource.getSplitedUsers(users);
  }
}
