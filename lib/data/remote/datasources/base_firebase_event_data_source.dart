import '../../../domain/entities/event_entity.dart';

abstract class BaseFirebaseEventDataSource {
  Future<void> createEvent(EventEntity event);
  Future<List<EventEntity>> getEventsByDate(DateTime date);
}
