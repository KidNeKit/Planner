import 'package:planner/domain/entities/contact_entity.dart';

import '../entities/user_entity.dart';

abstract class BaseContactsRepository {
  Stream<List<UserEntity>> get invitationsStream;
  Stream<List<ContactEntity>> get contactsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
  Map<String, List<ContactEntity>> getSplitedUsers(List<ContactEntity> users);
}
