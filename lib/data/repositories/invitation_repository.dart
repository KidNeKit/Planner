import '../../domain/entities/user_entity.dart';
import '../remote/datasources/base_firebase_invitation_data_source.dart';
import '../../domain/repositories/base_invitation_repository.dart';

class InvitationRepository extends BaseInvitationRepository {
  final BaseFirebaseInvitationDataSource _firebaseInvitationDataSource;

  InvitationRepository(
      {required BaseFirebaseInvitationDataSource firebaseInvitationDataSource})
      : _firebaseInvitationDataSource = firebaseInvitationDataSource;

  @override
  Stream<List<UserEntity>> get invitationsStream =>
      _firebaseInvitationDataSource.getInvitationsStream;

  @override
  Future<void> inviteUser(String userId) async =>
      await _firebaseInvitationDataSource.inviteUser(userId);

  @override
  Future<void> cancelUserInvitation(UserEntity user) async =>
      await _firebaseInvitationDataSource.cancelUserInvitation(user);

  @override
  Future<void> confirmUserInvitation(UserEntity user) async =>
      await _firebaseInvitationDataSource.confirmUserInvitation(user);
}
