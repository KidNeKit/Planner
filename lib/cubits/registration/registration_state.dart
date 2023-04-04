part of 'registration_cubit.dart';

class RegistrationState extends Equatable {
  final String email;
  final String password;
  final String username;
  final OperationStatus status;
  const RegistrationState(
      {required this.email,
      required this.password,
      required this.username,
      required this.status});

  const RegistrationState.initial()
      : email = '',
        password = '',
        username = '',
        status = OperationStatus.initial;

  RegistrationState copyWith(
      {String? email,
      String? password,
      String? username,
      OperationStatus? status}) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, username, status];
}
