part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserEntity? user;

  const AuthState.authenticated(this.user);

  const AuthState.unauthenticated() : user = null;

  @override
  List<Object?> get props => [user];
}
