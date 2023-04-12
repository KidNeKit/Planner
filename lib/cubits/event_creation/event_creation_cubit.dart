import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';

part 'event_creation_state.dart';

class EventCreationCubit extends Cubit<EventCreationState> {
  EventCreationCubit() : super(const EventCreationState.initial());

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

  void createEvent() {
    log(state.toString());
  }
}
