part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class UserChanged extends AuthEvent {
  final User? user;

  const UserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdated extends AuthEvent {
  final String userId;

  const UserUpdated(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LogoutRequested extends AuthEvent {}
