part of 'day_plans_bloc.dart';

abstract class DayPlansEvent extends Equatable {
  const DayPlansEvent();

  @override
  List<Object> get props => [];
}

class PlansViewSelected extends DayPlansEvent {
  final DayPlansView plansView;

  const PlansViewSelected({required this.plansView});

  @override
  List<Object> get props => [plansView];
}

class PlansUpdateRequested extends DayPlansEvent {
  //final Date date;
}
