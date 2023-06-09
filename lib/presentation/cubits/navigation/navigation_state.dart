part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int index;

  const NavigationState({required this.index});

  NavigationState copyWith({int? index}) {
    return NavigationState(index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
