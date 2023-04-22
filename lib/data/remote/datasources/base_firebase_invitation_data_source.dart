import '../../../domain/entities/user_entity.dart';

abstract class BaseFirebaseInvitationDataSource {
  Stream<List<UserEntity>> get getInvitationsStream;
  Future<void> inviteUser(String userId);
  Future<void> confirmUserInvitation(UserEntity user);
  Future<void> cancelUserInvitation(UserEntity user);
}
