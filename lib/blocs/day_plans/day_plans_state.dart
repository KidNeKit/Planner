part of 'day_plans_bloc.dart';

enum DayPlansView {
  list,
  table;
}

class DayPlansState extends Equatable {
  final DayPlansView plansView;
  final List<Plan> plans;
  const DayPlansState({required this.plansView, required this.plans});

  DayPlansState.initial()
      : plansView = DayPlansView.table,
        plans = [];

  DayPlansState copyWith({DayPlansView? plansView, List<Plan>? plans}) {
    return DayPlansState(
        plansView: plansView ?? this.plansView, plans: plans ?? this.plans);
  }

  @override
  List<Object> get props => [plansView, plans];
}
