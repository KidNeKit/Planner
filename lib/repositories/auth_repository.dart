import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static const String userCollectionPath = 'users';

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _firestore
                  .collection(userCollectionPath)
                  .doc(value.user!.uid)
                  .set({
                'email': email,
                'username': username,
                'id': value.user!.uid
              }));
    } catch (e) {
      log('Registration error: $e');
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log('Authorization error: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
