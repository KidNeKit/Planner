import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/enum/search_user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

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
}
