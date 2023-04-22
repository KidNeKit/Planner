import 'package:planner/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel(
      {required super.eventName,
      required super.eventLocation,
      required super.startDate,
      required super.endDate});
}
