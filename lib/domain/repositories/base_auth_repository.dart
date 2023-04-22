import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner/domain/entities/search_user.dart';

import '../entities/user_entity.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();

  Future<UserEntity> getUserById(String id);
  Future<List<SearchUser>> getUsersBySearch(String searchQuery);
  Future<void> updateUserProfile(Map<String, dynamic> map);
}
