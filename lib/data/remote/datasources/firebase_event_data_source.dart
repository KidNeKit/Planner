import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/event_entity.dart';
import 'base_firebase_event_data_source.dart';
import '../constants.dart' show FirebaseConstants;

class FirebaseEventDataSource extends BaseFirebaseEventDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseEventDataSource(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Future<void> createEvent(EventEntity event) async {
    var startDate = event.startDate;
    await _firestore
        .collection(FirebaseConstants.users)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.events)
        .doc('${startDate.day}-${startDate.month}-${startDate.year}')
        .collection(FirebaseConstants.events)
        .add(event.toMap());
  }

  @override
  Future<List<EventEntity>> getEventsByDate(DateTime date) async {
    var queryResult = await _firestore
        .collection(FirebaseConstants.users)
        .doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.events)
        .doc('${date.day}-${date.month}-${date.year}')
        .collection(FirebaseConstants.events)
        .orderBy('startDate')
        .get();
    return queryResult.docs.map((e) => EventEntity.fromMap(e.data())).toList();
  }
}
