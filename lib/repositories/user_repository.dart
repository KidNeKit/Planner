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
    var query = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: search)
        .get();
    return query.docs
        .map((e) => SearchUser.fromMap(e.id, e.data()))
        .where(
            (element) => element.id != FirebaseAuth.instance.currentUser!.uid)
        .toList();
  }

  Future<void> updateUserProfile(Map<String, dynamic> map) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }
}
