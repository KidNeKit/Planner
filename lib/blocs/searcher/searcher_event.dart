part of 'searcher_bloc.dart';

abstract class SearcherEvent extends Equatable {
  const SearcherEvent();

  @override
  List<Object> get props => [];
}

class SearchByNameRequested extends SearcherEvent {
  final String request;

  const SearchByNameRequested({required this.request});

  @override
  List<Object> get props => [request];
}

class InviteRequested extends SearcherEvent {
  final String userId;

  const InviteRequested({required this.userId});

  @override
  List<Object> get props => [userId];
}
