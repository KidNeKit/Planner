import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore;

  EventRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> createEvent(Event event) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .add(event.toMap());
  }
}
