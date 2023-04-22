import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_entity.dart';
import 'base_firebase_invitation_data_source.dart';

class FirebaseInvitationDataSource extends BaseFirebaseInvitationDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  late final CollectionReference _usersReference =
      _firestore.collection('users');
  late final DocumentReference _currentUserReference;

  FirebaseInvitationDataSource(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Stream<List<UserEntity>> get getInvitationsStream => _usersReference
      .doc(_firebaseAuth.currentUser!.uid)
      .collection('invitations')
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => UserEntity.fromMap(e.data())).toList());

  @override
  Future<void> inviteUser(String userId) async {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore.collection('users').doc(currentUserId).update({
      'invites': FieldValue.arrayUnion([userId])
    });
    // CustomUser user = await getUserById(currentUserId);
    // await _firestore
    //     .collection('users')
    //     .doc(userId)
    //     .collection('invitations')
    //     .doc(currentUserId)
    //     .set(user.toMap());
  }

  @override
  Future<void> cancelUserInvitation(UserEntity user) async {
    _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('invitations')
        .doc(user.id)
        .delete();
    _firestore.collection('users').doc(user.id).update({
      'invites': FieldValue.arrayRemove([_firebaseAuth.currentUser!.uid])
    });
  }

  @override
  Future<void> confirmUserInvitation(UserEntity user) async {
    cancelUserInvitation(user);
    _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('contacts')
        .doc(user.id)
        .set(user.toMap());
    // CustomUser customUser = await getUserById(_firebaseAuth.currentUser!.uid);
    // _firestore
    //     .collection('users')
    //     .doc(user.id)
    //     .collection('contacts')
    //     .doc(_firebaseAuth.currentUser!.uid)
    //     .set(customUser.toMap());
  }
}
