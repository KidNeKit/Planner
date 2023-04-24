import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner/data/remote/models/contact_model.dart';
import 'package:planner/data/remote/models/user_model.dart';
import 'package:planner/domain/entities/chat_entity.dart';
import 'package:planner/domain/entities/contact_entity.dart';

import '../../../domain/entities/user_entity.dart';
import '../constants.dart' show FirebaseConstants;
import 'base_firebase_auth_data_source.dart';
import 'base_firebase_chat_data_source.dart';
import 'base_firebase_contacts_data_source.dart';

class FirebaseContactsDataSource extends BaseFirebaseContactsDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final BaseFirebaseAuthDataSource _firebaseAuthDataSource;
  final BaseFirebaseChatDataBase _firebaseChatDataBase;

  late final CollectionReference _usersReference =
      _firestore.collection(FirebaseConstants.users);

  FirebaseContactsDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required BaseFirebaseAuthDataSource firebaseAuthDataSource,
    required BaseFirebaseChatDataBase firebaseChatDataBase,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _firebaseAuthDataSource = firebaseAuthDataSource,
        _firebaseChatDataBase = firebaseChatDataBase;

  @override
  Stream<List<UserEntity>> get invitationsStream => _usersReference
      .doc(_firebaseAuth.currentUser!.uid)
      .collection(FirebaseConstants.invitations)
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => UserEntity.fromMap(e.data())).toList());

  @override
  Stream<List<ContactEntity>> get contactsStream => _usersReference
      .doc(_firebaseAuth.currentUser!.uid)
      .collection(FirebaseConstants.contacts)
      .snapshots()
      .map((snap) =>
          snap.docs.map((e) => ContactEntity.fromMap(e.data())).toList());

  @override
  Future<void> inviteUser(String userId) async {
    String currentUserId = _firebaseAuth.currentUser!.uid;
    await _firestore
        .collection(FirebaseConstants.users)
        .doc(currentUserId)
        .update({
      'invites': FieldValue.arrayUnion([userId])
    });
    UserEntity user = await _firebaseAuthDataSource.getUserById(currentUserId);
    await _usersReference
        .doc(userId)
        .collection(FirebaseConstants.invitations)
        .doc(currentUserId)
        .set(user.toMap());
  }

  @override
  Future<void> cancelUserInvitation(UserEntity user) async {
    _usersReference
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.invitations)
        .doc(user.id)
        .delete();
    _firestore.collection(FirebaseConstants.users).doc(user.id).update({
      'invites': FieldValue.arrayRemove([_firebaseAuth.currentUser!.uid])
    });
  }

  @override
  Future<void> confirmUserInvitation(UserEntity user) async {
    cancelUserInvitation(user);

    String curentUserId = _firebaseAuth.currentUser!.uid;
    ChatEntity chat = ChatEntity(userIds: {curentUserId, user.id});
    String chatId = await _firebaseChatDataBase.createChat(chat);
    ContactModel contact = ContactModel.fromUserEntity(user);
    contact.setChatId = chatId;

    _usersReference
        .doc(curentUserId)
        .collection(FirebaseConstants.contacts)
        .doc(contact.id)
        .set(contact.toMap());
    var currentUser = await _firebaseAuthDataSource.getUserById(curentUserId);
    ContactModel contactCurrent = ContactModel.fromUserEntity(currentUser);
    contactCurrent.setChatId = chatId;
    _firestore
        .collection(FirebaseConstants.users)
        .doc(user.id)
        .collection(FirebaseConstants.contacts)
        .doc(curentUserId)
        .set(contactCurrent.toMap());
  }

  @override
  Map<String, List<ContactEntity>> getSplitedUsers(List<ContactEntity> users) {
    Map<String, List<ContactEntity>> usersMap = {};
    for (var user in users) {
      usersMap.update(
          user.surname[0].toUpperCase(), (addedUsers) => addedUsers..add(user),
          ifAbsent: () => [user]);
    }
    return usersMap;
  }
}
