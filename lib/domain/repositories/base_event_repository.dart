import '../entities/event_entity.dart';

abstract class BaseEventRepository {
  Future<void> createEvent(EventEntity event);
  Future<List<EventEntity>> getEventsByDate(DateTime date);
}
