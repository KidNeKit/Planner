import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/contact_user.dart';
import '../models/custom_user.dart';
import '../models/search_user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  UserRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  Stream<List<ContactUser>> get invitationsStream => _firestore
      .collection('users')
      .doc(_firebaseAuth.currentUser!.uid)
      .collection('invitations')
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => ContactUser.fromMap(e.data())).toList());

  Future<CustomUser> getUserById(String id) async {
    var query = await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return CustomUser.fromMap(query.data()!);
  }

  Future<List<SearchUser>> getUsersBySearch(String search) async {
    if (search.isEmpty) {
      return [];
    }
    search = search.toLowerCase();
    var query = await _firestore.collection('users').get();
    List<SearchUser> users = query.docs
        .map((e) => SearchUser.fromMap(e.id, e.data()))
        .where((element) =>
            (element.name.toLowerCase().contains(search) ||
                element.surname.toLowerCase().contains(search) ||
                element.username.toLowerCase().contains(search)) &&
            element.id != _firebaseAuth.currentUser!.uid)
        .toList();
    var currentUser = await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    List invites = currentUser.data()!['invites'] ?? [];
    users = users.map((e) {
      if (invites.contains(e.id)) {
        return e.copyWith(isInvited: true);
      }
      return e;
    }).toList();
    return users;
  }

  Future<void> updateUserProfile(Map<String, dynamic> map) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update(map);
  }

  Future<void> inviteUser(String userId) async {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore.collection('users').doc(currentUserId).update({
      'invites': FieldValue.arrayUnion([userId])
    });
    CustomUser user = await getUserById(currentUserId);
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('invitations')
        .doc(currentUserId)
        .set(user.toMap());
  }

  Future<void> confirmUserInvitation(ContactUser user) async {
    cancelUserInvitation(user);
    _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('contacts')
        .doc(user.id)
        .set(user.toMap());
    CustomUser customUser = await getUserById(_firebaseAuth.currentUser!.uid);
    _firestore
        .collection('users')
        .doc(user.id)
        .collection('contacts')
        .doc(_firebaseAuth.currentUser!.uid)
        .set(customUser.toMap());
  }

  Future<void> cancelUserInvitation(ContactUser user) async {
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
