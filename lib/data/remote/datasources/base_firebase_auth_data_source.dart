import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/entities/search_user.dart';

abstract class BaseFirebaseAuthDataSource {
  Stream<User?> get user;
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();

  Future<UserEntity> getUserById(String id);
  Future<List<SearchUser>> getUsersBySearch(String searchQuery);
  Future<void> updateUserProfile(Map<String, dynamic> map);
}
