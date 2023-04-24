import 'package:planner/domain/entities/contact_entity.dart';

import '../../../domain/entities/user_entity.dart';

abstract class BaseFirebaseContactsDataSource {
  Stream<List<UserEntity>> get invitationsStream;
  Stream<List<ContactEntity>> get contactsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
  Map<String, List<ContactEntity>> getSplitedUsers(List<ContactEntity> users);
}
