import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/custom_user.dart';

class InvitationRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  late final CollectionReference _usersReference =
      _firestore.collection('users');
  late final DocumentReference _currentUserReference;

  InvitationRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  Stream<List<CustomUser>> get invitationsStream => _usersReference
      .doc(_firebaseAuth.currentUser!.uid)
      .collection('invitations')
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => CustomUser.fromMap(e.data())).toList());

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

  Future<void> confirmUserInvitation(CustomUser user) async {
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

  Future<void> cancelUserInvitation(CustomUser user) async {
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
}
