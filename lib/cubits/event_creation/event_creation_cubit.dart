import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../models/event.dart';
import '../../repositories/event_repository.dart';

part 'event_creation_state.dart';

class EventCreationCubit extends Cubit<EventCreationState> {
  final EventRepository _eventRepository;

  EventCreationCubit({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(const EventCreationState.initial());

  void changeEventName(String name) {
    emit(state.copyWith(eventName: name));
  }

  void changeEventLocation(String location) {
    emit(state.copyWith(eventLocation: location));
  }

  void changeStartDate(int year, int month, int day) {
    DateTime date = DateTime.utc(year, month, day);
    emit(state.copyWith(startDate: date));
    log(state.toString());
  }

  void changeEndDate(int year, int month, int day) {
    DateTime date = DateTime.utc(year, month, day);
    emit(state.copyWith(endDate: date));
    log(state.toString());
  }

  void changeStartHours(int hours) {
    emit(state.copyWith(startHours: hours));
  }

  void changeStartMinutes(int minutes) {
    emit(state.copyWith(startMinutes: minutes));
  }

  void changeEndHours(int hours) {
    emit(state.copyWith(endHours: hours));
  }

  void changeEndMinutes(int minutes) {
    emit(state.copyWith(endMinutes: minutes));
  }

  void createEvent() async {
    if (state.status == OperationStatus.loading) {
      return;
    }

    emit(state.copyWith(status: OperationStatus.loading));
    if (state.startDate == null || state.endDate == null) {
      emit(state.copyWith(status: OperationStatus.failed));
      return;
    }

    var startDate = state.startDate;
    var endDate = state.endDate;
    var finalStartDate = DateTime(startDate!.year, startDate.month,
        startDate.day, state.startHours, state.startMinutes);
    var finalEndDate = DateTime(endDate!.year, endDate.month, endDate.day,
        state.endHours, state.endMinutes);

    Event event = Event(
        eventName: state.eventName,
        eventLocation: state.eventLocation,
        startDate: finalStartDate,
        endDate: finalEndDate);

    List<Event> events = _splitEventByDay(event);
    for (var element in events) {
      await _eventRepository.createEvent(element);
    }

    emit(state.copyWith(status: OperationStatus.successful));
  }

  List<Event> _splitEventByDay(Event event) {
    List<Event> events = [];
    var startDate = event.startDate;
    var endDate = event.endDate;

    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      return [event];
    }

    var newDate = startDate;
    do {
      events.add(Event(
          eventName: event.eventName,
          eventLocation: event.eventLocation,
          startDate: newDate,
          endDate: DateTime(newDate.year, newDate.month, newDate.day + 1)));
      newDate = DateTime(newDate.year, newDate.month, newDate.day + 1);
    } while (
        newDate.isBefore(DateTime(endDate.year, endDate.month, endDate.day)));
    events.add(Event(
        eventName: event.eventName,
        eventLocation: event.eventLocation,
        startDate: DateTime(endDate.year, endDate.month, endDate.day),
        endDate: endDate));

    return events;
  }
}
