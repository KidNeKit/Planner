part of 'searcher_bloc.dart';

class SearcherState extends Equatable {
  final List<SearchUser> users;
  final OperationStatus status;

  const SearcherState({required this.users, required this.status});

  SearcherState.initial()
      : users = [],
        status = OperationStatus.initial;

  SearcherState copyWith({List<SearchUser>? users, OperationStatus? status}) {
    return SearcherState(
        users: users ?? this.users, status: status ?? this.status);
  }

  @override
  List<Object> get props => [users, status];
}
