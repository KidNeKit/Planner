import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/enum/operation_status.dart';
import '../../models/event.dart';
import '../../repositories/event_repository.dart';

part 'day_plans_event.dart';
part 'day_plans_state.dart';

class DayPlansBloc extends Bloc<DayPlansEvent, DayPlansState> {
  final EventRepository _eventRepository;

  DayPlansBloc({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(DayPlansState.initial()) {
    on<PlansViewSelected>(_onPlansViewSelected);
    on<PlansUpdateRequested>(_onPlansUpdateRequested);
  }

  void _onPlansViewSelected(
      PlansViewSelected event, Emitter<DayPlansState> emit) {
    emit(state.copyWith(plansView: event.plansView));
  }

  void _onPlansUpdateRequested(
      PlansUpdateRequested event, Emitter<DayPlansState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var events = await _eventRepository.getEventsByDate(event.date);
    emit(state.copyWith(plans: events, status: OperationStatus.successful));
  }
}
