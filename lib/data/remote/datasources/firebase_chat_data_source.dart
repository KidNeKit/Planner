import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/chat_entity.dart';
import '../constants.dart';
import 'base_firebase_auth_data_source.dart';
import 'base_firebase_chat_data_source.dart';

class FirebaseChatDataSource extends BaseFirebaseChatDataBase {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final BaseFirebaseAuthDataSource _firebaseAuthDataSource;

  FirebaseChatDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required BaseFirebaseAuthDataSource firebaseAuthDataSource,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _firebaseAuthDataSource = firebaseAuthDataSource;

  @override
  Future<String> createChat(ChatEntity chat) async {
    var createdChat =
        await _firestore.collection(FirebaseConstants.chats).add(chat.toMap());
    return createdChat.id;
  }

  @override
  Future<ChatEntity> getChatById(String chatId) async {
    var chatDoc =
        await _firestore.collection(FirebaseConstants.chats).doc(chatId).get();
    return ChatEntity.fromFirebase(chatDoc.data());
  }
}
