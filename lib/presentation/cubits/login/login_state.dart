part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final OperationStatus status;
  const LoginState(
      {required this.email, required this.password, required this.status});

  const LoginState.initial()
      : email = '',
        password = '',
        status = OperationStatus.initial;

  LoginState copyWith(
      {String? email, String? password, OperationStatus? status}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, status];
}
