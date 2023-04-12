part of 'event_creation_cubit.dart';

class EventCreationState extends Equatable {
  final String eventName;
  final String eventLocation;
  final DateTime? startDate;
  final DateTime? endDate;
  final OperationStatus status;

  const EventCreationState(this.eventName, this.eventLocation, this.startDate,
      this.endDate, this.status);

  const EventCreationState.initial()
      : eventName = '',
        eventLocation = '',
        startDate = null,
        endDate = null,
        status = OperationStatus.initial;

  EventCreationState copyWith(
      {String? eventName,
      String? eventLocation,
      DateTime? startDate,
      DateTime? endDate,
      OperationStatus? status}) {
    return EventCreationState(
        eventName ?? this.eventName,
        eventLocation ?? this.eventLocation,
        startDate ?? this.startDate,
        endDate ?? this.endDate,
        status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [eventName, eventLocation, startDate, endDate, status];
}
