part of 'event_creation_cubit.dart';

class EventCreationState extends Equatable {
  final String eventName;
  final String eventLocation;
  final DateTime? startDate;
  final DateTime? endDate;
  final int startHours;
  final int startMinutes;
  final int endHours;
  final int endMinutes;
  final OperationStatus status;

  const EventCreationState(
      {required this.eventName,
      required this.eventLocation,
      this.startDate,
      this.endDate,
      required this.status,
      required this.endHours,
      required this.endMinutes,
      required this.startHours,
      required this.startMinutes});

  const EventCreationState.initial()
      : eventName = '',
        eventLocation = '',
        startDate = null,
        endDate = null,
        status = OperationStatus.initial,
        startHours = 0,
        startMinutes = 0,
        endHours = 0,
        endMinutes = 0;

  EventCreationState copyWith({
    String? eventName,
    String? eventLocation,
    DateTime? startDate,
    DateTime? endDate,
    OperationStatus? status,
    int? startHours,
    int? startMinutes,
    int? endHours,
    int? endMinutes,
  }) {
    return EventCreationState(
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      startHours: startHours ?? this.startHours,
      startMinutes: startMinutes ?? this.startMinutes,
      endHours: endHours ?? this.endHours,
      endMinutes: endMinutes ?? this.endMinutes,
    );
  }

  @override
  List<Object?> get props => [
        eventName,
        eventLocation,
        startDate,
        endDate,
        status,
        startHours,
        startMinutes,
        endHours,
        endMinutes
      ];
}
