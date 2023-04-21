import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
