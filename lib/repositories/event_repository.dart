import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore;

  EventRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> createEvent(Event event) async {
    var startDate = event.startDate;
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc('${startDate.day}-${startDate.month}-${startDate.year}')
        .collection('events')
        .add(event.toMap());
  }

  Future<List<Event>> getEventsByDate(DateTime date) async {
    var queryResult = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc('${date.day}-${date.month}-${date.year}')
        .collection('events')
        .get();
    return queryResult.docs.map((e) => Event.fromMap(e.data())).toList();
  }
}
