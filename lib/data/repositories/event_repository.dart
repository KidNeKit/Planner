import 'package:planner/data/remote/datasources/base_firebase_event_data_source.dart';
import 'package:planner/domain/entities/event_entity.dart';
import 'package:planner/domain/repositories/base_event_repository.dart';

class EventRepository extends BaseEventRepository {
  final BaseFirebaseEventDataSource _firebaseEventDataSource;

  EventRepository(
      {required BaseFirebaseEventDataSource firebaseEventDataSource})
      : _firebaseEventDataSource = firebaseEventDataSource;

  @override
  Future<void> createEvent(EventEntity event) async {
    await _firebaseEventDataSource.createEvent(event);
  }

  @override
  Future<List<EventEntity>> getEventsByDate(DateTime date) async {
    return await _firebaseEventDataSource.getEventsByDate(date);
  }
}
