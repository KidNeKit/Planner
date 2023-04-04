part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final CustomUser? user;

  const AuthState.authenticated(this.user);

  const AuthState.unauthenticated() : user = null;

  @override
  List<Object?> get props => [user];
}
