import '../entities/user_entity.dart';

abstract class BaseContactsRepository {
  Stream<List<UserEntity>> get invitationsStream;
  Stream<List<UserEntity>> get contactsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
  Map<String, List<UserEntity>> getSplitedUsers(List<UserEntity> users);
}
