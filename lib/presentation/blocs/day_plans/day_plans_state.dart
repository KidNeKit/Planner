part of 'day_plans_bloc.dart';

enum DayPlansView {
  list,
  table;
}

class DayPlansState extends Equatable {
  final DayPlansView plansView;
  final List<EventEntity> plans;
  final OperationStatus status;
  const DayPlansState(
      {required this.plansView, required this.plans, required this.status});

  DayPlansState.initial()
      : plansView = DayPlansView.table,
        plans = [],
        status = OperationStatus.initial;

  DayPlansState copyWith(
      {DayPlansView? plansView,
      List<EventEntity>? plans,
      OperationStatus? status}) {
    return DayPlansState(
        plansView: plansView ?? this.plansView,
        plans: plans ?? this.plans,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [plansView, plans, status];
}
