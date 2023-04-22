import '../entities/user_entity.dart';

abstract class BaseInvitationRepository {
  Stream<List<UserEntity>> get invitationsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
}
