import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner/models/custom_user.dart';

import '../models/enum/search_user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<CustomUser> getUserById(String id) async {
    var query = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
            element.id != FirebaseAuth.instance.currentUser!.uid)
        .toList();
    var currentUser = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }

  Future<void> inviteUser(String userId) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'invites': FieldValue.arrayUnion([userId])
    });
    await _firestore.collection('users').doc(userId).update({
      'invitations':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }
}
