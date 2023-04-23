import '../../../domain/entities/user_entity.dart';

abstract class BaseFirebaseContactsDataSource {
  Stream<List<UserEntity>> get invitationsStream;
  Stream<List<UserEntity>> get contactsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
}
