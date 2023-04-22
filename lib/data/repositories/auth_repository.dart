import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/search_user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/base_auth_repository.dart';
import '../remote/datasources/base_firebase_auth_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseFirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepository({required BaseFirebaseAuthDataSource firebaseAuthDataSource})
      : _firebaseAuthDataSource = firebaseAuthDataSource;

  @override
  Stream<User?> get user => _firebaseAuthDataSource.user;

  @override
  Future<UserEntity> getUserById(String id) async {
    return await _firebaseAuthDataSource.getUserById(id);
  }

  @override
  Future<List<SearchUser>> getUsersBySearch(String searchQuery) async {
    return await _firebaseAuthDataSource.getUsersBySearch(searchQuery);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuthDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthDataSource.signOut();
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _firebaseAuthDataSource.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<void> updateUserProfile(Map<String, dynamic> map) async {
    await _firebaseAuthDataSource.updateUserProfile(map);
  }
}
