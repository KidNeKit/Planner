import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/search_user.dart';
import '../../../domain/entities/user_entity.dart';
import '../constants.dart' show FirebaseConstants;
import 'base_firebase_auth_data_source.dart';

class FirebaseAuthDataSource extends BaseFirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDataSource(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _firestore
                  .collection(FirebaseConstants.users)
                  .doc(value.user!.uid)
                  .set({
                'email': email,
                'id': value.user!.uid,
                'username': 'guest_${value.user!.uid}',
              }));
    } catch (e) {
      log('Registration error: $e');
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log('Authorization error: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserEntity> getUserById(String id) async {
    var query = await _firestore
        .collection(FirebaseConstants.users)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    return UserEntity.fromMap(query.data()!);
  }

  @override
  Future<List<SearchUser>> getUsersBySearch(String searchQuery) async {
    if (searchQuery.isEmpty) {
      return [];
    }
    searchQuery = searchQuery.toLowerCase();
    var query = await _firestore.collection(FirebaseConstants.users).get();
    List<SearchUser> users = query.docs
        .map((e) => SearchUser.fromMap(e.id, e.data()))
        .where((element) =>
            (element.name.toLowerCase().contains(searchQuery) ||
                element.surname.toLowerCase().contains(searchQuery) ||
                element.username.toLowerCase().contains(searchQuery)) &&
            element.id != _firebaseAuth.currentUser!.uid)
        .toList();
    var currentUser = await _firestore
        .collection(FirebaseConstants.users)
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

  @override
  Future<void> updateUserProfile(Map<String, dynamic> map) async {
    await _firestore
        .collection(FirebaseConstants.users)
        .doc(_firebaseAuth.currentUser!.uid)
        .update(map);
  }
}
