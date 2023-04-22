import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_entity.dart';
import '../constants.dart' show FirebaseConstants;
import 'base_firebase_auth_data_source.dart';
import 'base_firebase_invitation_data_source.dart';

class FirebaseInvitationDataSource extends BaseFirebaseInvitationDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final BaseFirebaseAuthDataSource _firebaseAuthDataSource;

  late final CollectionReference _usersReference =
      _firestore.collection(FirebaseConstants.users);

  FirebaseInvitationDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required BaseFirebaseAuthDataSource firebaseAuthDataSource,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _firebaseAuthDataSource = firebaseAuthDataSource;

  @override
  Stream<List<UserEntity>> get getInvitationsStream => _usersReference
      .doc(_firebaseAuth.currentUser!.uid)
      .collection(FirebaseConstants.invitations)
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => UserEntity.fromMap(e.data())).toList());

  @override
  Future<void> inviteUser(String userId) async {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection(FirebaseConstants.users)
        .doc(currentUserId)
        .update({
      'invites': FieldValue.arrayUnion([userId])
    });
    UserEntity user = await _firebaseAuthDataSource.getUserById(currentUserId);
    await _usersReference
        .doc(userId)
        .collection(FirebaseConstants.invitations)
        .doc(currentUserId)
        .set(user.toMap());
  }

  @override
  Future<void> cancelUserInvitation(UserEntity user) async {
    _usersReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.invitations)
        .doc(user.id)
        .delete();
    _firestore.collection(FirebaseConstants.users).doc(user.id).update({
      'invites': FieldValue.arrayRemove([_firebaseAuth.currentUser!.uid])
    });
  }

  @override
  Future<void> confirmUserInvitation(UserEntity user) async {
    cancelUserInvitation(user);
    _usersReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.contacts)
        .doc(user.id)
        .set(user.toMap());
    UserEntity customUser = await _firebaseAuthDataSource
        .getUserById(_firebaseAuth.currentUser!.uid);
    _firestore
        .collection(FirebaseConstants.users)
        .doc(user.id)
        .collection(FirebaseConstants.contacts)
        .doc(_firebaseAuth.currentUser!.uid)
        .set(customUser.toMap());
  }
}
